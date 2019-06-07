class FoldersController < ApplicationController
  # 下記のアクションは、ログイン中のみ許可する
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :set_folder, only: [:edit, :update, :destroy]
  before_action :user_check, only: [:index, :create, :show, :edit, :update, :destroy]

  def index
    respond_to do |format|
      @folders = params[:creator_id].present? ? Folder.where(creator_id: params[:creator_id]) : []
      @creator = Creator.find(params[:creator_id])

      format.html { render :index }

      creator = Creator.find(params[:creator_id]) if params[:creator_id].present?
      format.js { render json: creator.folders.select(:id, :folder_name) }
    end
  end

  def new
    @folder = Folder.new
  end

  def edit
  end

  def create
    @folder = Folder.new(folder_params)
    
    respond_to do |format|
      if @folder.save
        format.html { redirect_to @folder, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @folder }
        format.js { @status = "success"}
      else
        format.html { render :new }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
        format.js { @status = "fail" }
      end
    end
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
    artworks = Artwork.where(folder_id: @folder.id)
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
    # current_user とfolder に紐付く user が相違している場合は作品一覧画面に遷移し、エラーメッセージを表示する
    unless current_user.id == Creator.find(params[:creator_id]).user_id
      redirect_to artworks_path, notice: "権限がありません。"
    end
  end
end
