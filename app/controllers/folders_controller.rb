class FoldersController < ApplicationController
  before_action :set_folder, only: [:show, :edit, :update, :destroy]

  def index
    @folders = Folder.all
  end

  def show
    #（以下の場合、パラメーターに含まれる creator_id と artworksテーブルの creator_id カラムが一致する物を取り出す ）
    # @artworks = Artwork.where(creator_id: params[:creator_id]).order(updated_at: "DESC")
    @artworks = Artwork.where(folder_id: params[:folder_id]).order(updated_at: "DESC")
  end

  def new
    @folder = Folder.new

    @folder.artworks.build
  end

  def edit
  end

  def create
    @folder = Folder.new(folder_params)

    # @folder.creator_id = params[:creator_id]

    @folder.creator_id = current_user.id

    if @folder.save
      redirect_to new_artworks_path, notice: "作品を追加しました！"
    else
      render 'new'
    end

    # respond_to do |format|
    #   if @folder.save
    #     format.html { redirect_to new_artwork_path, notice: 'Folder was successfully created.' }
    #     format.json { render :show, status: :created, location: @folder }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @folder.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def update
    @folder.update(folder_params)
  end

  def destroy
  end

  private

  def set_folder
    @folder = Folder.find(params[:id])
  end

  def folder_params
    params.require(:folder).permit(:folder_name)
  end
end
