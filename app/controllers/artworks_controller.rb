class ArtworksController < ApplicationController
  # 下記のアクションは、ログイン中のみ許可する
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :set_artwork, only: [:show, :edit, :update, :destroy] 

  def index
    # パラメーターに creator_id が含まれる（クリエイターの詳細画面から遷移する）場合
    if params[:creator_id]
      # そのクリエイターに紐付く作品のみ、全て取得する
      #（以下の場合、パラメーターに含まれる creator_id と artworksテーブルの creator_id カラムが一致する物を取り出す ）
      @artworks = Artwork.where(creator_id: params[:creator_id]).order(updated_at: "DESC")
      #（以下の場合、パラメーターに含まれる creator_id と foldersテーブルの creator_id カラムが一致する物を取り出す ）
      @folders = Folder.where(creator_id: params[:creator_id]).order(updated_at: "DESC")
      # クリエイターに紐付く作品一覧画面を表示させる

      @creator = Creator.find_by(id: params[:creator_id])

      render :creator_index

    # パラメーターに folder_id が含まれる（フォルダに紐付いた作品のみ表示させる）場合
    elsif params[:folder_id]
      # そのフォルダに紐付く作品のみ、全て取得する
      #（以下の場合、パラメーターに含まれる folder_id と artworksテーブルの folder_id カラムが一致する物を取り出す ）
      @artworks = Artwork.where(folder_id: params[:folder_id]).order(updated_at: "DESC")
      #（以下の場合、パラメーターに含まれる creator_id と foldersテーブルの creator_id カラムが一致する物を取り出す ）
      @folders = Folder.where(creator_id: params[:creator_id]).order(updated_at: "DESC")
      # フォルダに紐付く作品一覧画面を表示させる
      render :folder_index

    else
      # Artwork.published で artworkモデルで定義したスコープ published を呼びだす
      @artworks = Artwork.published.order(updated_at: "DESC")
    end
  end

  def new
    if params[:back]
      @artwork = Artwork.new(artwork_params)
    else
      @artwork = Artwork.new
      # 同時にFolderもbildする（Folder.new と同じ）
      # @artwork.build_folder
    end
  end

  def create
    @artwork = Artwork.new(artwork_params)

    @artwork.folder_id = params[:folder_id]

      if @artwork.save
        redirect_to artworks_path, notice: "作品を投稿しました！"
      else
        render 'new'
      end

      # respond_to do |format|
      #   if @artwork.save
      #     format.html { redirect_to artworks_path, notice: '作品を投稿しました！' }
      #     format.json { render :show, status: :created, location: @artwork }
      #   else
      #     format.html { render :new }
      #     format.json { render json: @artwork.errors, status: :unprocessable_entity }
      #   end
      # end

  end

  def edit
  end
  
  def show
  end

  def update
  end

  def destroy
  end

  private

  def artwork_params
    # params.require(:artwork).permit(:image, :image_cache, :caption, :creator_id, :created_date, :is_published, folder_attributes: [:folder_name])
    params.require(:artwork).permit(:image, :image_cache, :caption, :creator_id, :created_date, :is_published, :folder_id)
  end

  def set_artwork
    @artwork = Artwork.find(params[:id])
  end

end
