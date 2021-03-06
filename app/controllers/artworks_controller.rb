class ArtworksController < ApplicationController
  # 下記のアクションは、ログイン中のみ許可する
  before_action :authenticate_user!, only: [:new, :show, :edit, :update, :destroy]
  before_action :set_artwork, only: [:show, :edit, :update, :destroy]
  before_action :user_check, only: [:create, :edit, :show, :update, :destroy]
  # if: -> {current_user.present?} によって current_user が存在する場合(ログインしている場合)のみ実行する
  before_action :ridirect_to_artworks_top_unless_own_creator, only: [:index], if: -> {current_user.present?}
  before_action :ridirect_to_artworks_top_unless_own_folder, only: [:index], if: -> {current_user.present?}

  def index
    # ログイン中かつパラメーターに creator_id が含まれる（クリエイターの詳細画面から遷移する）場合
    if current_user && params[:creator_id]
      # そのクリエイターに紐付く作品のみ、全て取得する
      #（以下の場合、パラメーターに含まれる creator_id と current_user に紐付く artworksの中から creator_id カラムが一致する物を取り出す ）
      @artworks = current_user.artworks.where(creator_id: params[:creator_id])
      
      #（以下の場合、パラメーターに含まれる creator_id と current_user に紐付 foldersの中から creator_id カラムが一致する物を取り出す ）
      @folders = current_user.folders.where(creator_id: params[:creator_id]).order(updated_at: "DESC")

      @creator = current_user.creators.find_by(id: params[:creator_id])

      # クリエイターに紐付く作品一覧画面を template_name に代入する
      template_name = :creator_index

    # ログイン中かつパラメーターに folder_id が含まれる（フォルダに紐付いた作品のみ表示させる）場合
    elsif current_user && params[:folder_id]
      @folder = current_user.folders.find(params[:folder_id])
      # そのフォルダに紐付く作品のみ、全て取得する
      #（以下の場合、パラメーターに含まれる folder_id と artworksテーブルの folder_id カラムが一致する物を取り出す ）
      @artworks = current_user.artworks.where(folder_id: params[:folder_id])
      #（以下の場合、パラメーターに含まれる creator_id と foldersテーブルの creator_id カラムが一致する物を取り出す ）
      @folders = current_user.folders.where(creator_id: @folder.creator).order(updated_at: "DESC")

      @creator = current_user.creators.find_by(id: @folder.creator_id)
      # フォルダに紐付く作品一覧画面を template_name に代入する
      template_name = :folder_index

    else
      # current_user.artworks.published で artworkモデルで定義したスコープ published を呼びだす
      @artworks = Artwork.published
      # 作品一覧画面を template_name に代入する
      template_name = :index
    end

    @artworks = @artworks.page(params[:page]).per(12).order(updated_at: "DESC")

    # template_name 代入した、それぞれの作品一覧画面を表示させる
    render template_name

  end

  def new
    if params[:back]
      @artwork = Artwork.new(artwork_params)
    else
      @artwork = Artwork.new
    end
  end

  def create
    @artwork = Artwork.new(artwork_params)
    
    new_folder_name = params[:artwork][:new_folder_name]

    # new_folder_name が空の場合(フォルダの新規登録欄に何も入力されていない場合)
    if new_folder_name.blank?
      @artwork.folder_id = params[:artwork][:folder_id]
    end

    # トランザクションの設定(folder の作成に失敗した場合、artwork の処理もエラーにする為必要)
    Artwork.transaction do
      # 行いたい処理
      @artwork.save!
      # new_folder_name に値がある場合(フォルダの新規登録欄にフォルダ名を入力した場合)
      if new_folder_name.present?
        creator = current_user.creators.find(params[:artwork][:creator_id])
        #folder を作成する
        @folder = Folder.new(creator_id: creator.id, folder_name: new_folder_name)
        @folder.save!
        @artwork.update!(folder_id: @folder.id)
      end
    end
      # 上記の処理が全て成功した場合
      redirect_to creator_artworks_path(@artwork.creator_id), notice: "作品を投稿しました！"
    # 上記の処理が一つでも失敗した場合
    rescue => e
      render 'new'
  end

  def edit
  end
  
  def show
    @creator = current_user.creators.find(@artwork.creator_id)
  end

  def update
    new_folder_name = params[:artwork][:new_folder_name]

    # new_folder_name が空の場合(フォルダの新規登録欄に何も入力されていない場合)
    if new_folder_name.blank?
      @artwork.folder_id = params[:artwork][:folder_id]
    end

    # トランザクションの設定 (folder の作成に失敗した場合、artwork の処理もエラーにする為必要)
    Artwork.transaction do
      # 行いたい処理
      @artwork.update!(artwork_params)
        # new_folder_name に値がある場合(フォルダの新規登録欄にフォルダ名を入力した場合)
        if new_folder_name.present?
          creator = current_user.creators.find(params[:artwork][:creator_id])
          #folder を作成する
          @folder = current_user.folders.new(creator_id: creator.id, folder_name: new_folder_name)
          @folder.save!
          @artwork.update!(folder_id: @folder.id)
        end
    end
      # 上記の処理が全て成功した場合
      redirect_to creator_artworks_path(@artwork.creator_id),notice: "作品を編集しました！"
    # 上記の処理が一つでも失敗した場合
    rescue => e
      render "edit"
  end

  def destroy
    @artwork.destroy
    redirect_to creator_artworks_path(@artwork.creator_id), notice:" 作品を削除しました！"
  end

  private

  def artwork_params
    # params.require(:artwork).permit(:image, :image_cache, :caption, :creator_id, :created_date, :is_published, folder_attributes: [:folder_name])
    params.require(:artwork).permit(:image, :image_cache, :caption, :creator_id, :created_date, :is_published)
  end

  def set_artwork
    @artwork = Artwork.find(params[:id])
  end

  def user_check
    # current_user と作品に紐付く user が相違している場合は作品一覧画面に遷移し、エラーメッセージを表示する
    creator = params[:id].present? ? Artwork.find(params[:id]).creator : Creator.find(params[:artwork][:creator_id])
    unless current_user.id == creator.user_id
      redirect_to artworks_path, notice: "権限がありません"
    end
  end

  def ridirect_to_artworks_top_unless_own_creator
    # パラメーターに creator_id が含まれる場合
    if params[:creator_id].present?
      # クリエイターの中から idとパラメーターに含まれる creator_id が一致するもので、user_id と current_user.id が一致するものが存在しなければ
      unless Creator.exists?(id: params[:creator_id], user_id: current_user.id)
        redirect_to artworks_path
      end
    end
  end

  def ridirect_to_artworks_top_unless_own_folder
    # パラメーターに folder_id が含まれる場合
    if params[:folder_id].present?
      # パラメーターに含まれる folder_id に紐付いている、creator が持つ user_id と current_user.id が一致するものが存在しなければ
      folder = Folder.find(params[:folder_id])
      unless folder.creator.user_id == current_user.id
        redirect_to artworks_path
      end
    end
  end

end
