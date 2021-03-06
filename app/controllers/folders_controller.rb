class FoldersController < ApplicationController
  # 下記のアクションは、ログイン中のみ許可する
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :set_folder, only: [:edit, :update, :destroy]
  before_action :user_check, only: [:index, :edit, :update, :destroy]

  def index
    respond_to do |format|
      @folders = params[:creator_id].present? ? current_user.folders.where(creator_id: params[:creator_id]) : []
      @creator = current_user.creators.find(params[:creator_id])

      format.html { render :index }

      creator = current_user.creators.find(params[:creator_id]) if params[:creator_id].present?
      format.js { render json: creator.folders.select(:id, :folder_name) }
    end
  end

  def edit
  end

  def update
    if @folder.update(folder_params)
      redirect_to folders_path(creator_id: @folder.creator_id), notice: "フォルダ名を編集しました！"
    else
      render "edit"
    end

  end

  def destroy
    # artworkに紐付くfolder_idを全てnillにする
    artworks = current_user.artworks.where(folder_id: @folder.id)
    artworks.update(folder_id: [])
    
    @creator = Folder.find(@folder.creator_id)

    @folder.destroy
    redirect_to folders_path(creator_id: @creator.id), notice:" フォルダを削除しました！"

  end

  private

  def set_folder
    @folder = Folder.find(params[:id])
  end

  def folder_params
    params.require(:folder).permit(:folder_name, :creator_id)
  end

  def user_check
    # パラメーターに creator の id が含まれる(edit, update, destroyアクションの)場合は、Creator モデルから creator を取得、
    # creator の id が含まれない（index アクション）の場合は、パラメーターの Folder の id から creator を取得
    creator = params[:creator_id].present? ? Creator.find(params[:creator_id]) : Folder.find(params[:id]).creator
    # current_user の id とfolder に紐付く creator の user_id  が相違している場合は作品一覧画面に遷移し、エラーメッセージを表示する
    unless current_user.id == creator.user_id
      redirect_to artworks_path, notice: "権限がありません。"
    end
  end

end
