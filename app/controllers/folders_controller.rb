class FoldersController < ApplicationController
  before_action :set_folder, only: [:show, :edit, :update, :destroy]

  def index
    @folders = Folder.all

    creator = Creator.find(params[:creator_id])
    render json: creator.folders.select(:id, :folder_name)

  end

  def show
    #（以下の場合、パラメーターに含まれる creator_id と artworksテーブルの creator_id カラムが一致する物を取り出す ）
    # @artworks = Artwork.where(creator_id: params[:creator_id]).order(updated_at: "DESC")
    @artworks = Artwork.where(folder_id: params[:folder_id]).order(updated_at: "DESC")
  end

  def new
    @folder = Folder.new

    respond_to do |format|
        format.html { }
        format.js { }
    end
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

    # @folder = Folder.new(folder_params)
    # @folder.creator_id = params[:creator_id]
    # if @folder.save
    #   redirect_to new_artwork_path, notice: "フォルダを追加しました！"
    # else
    #   render 'new'
    # end

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

    @folders = Folder.all

  end

  def destroy
  end

  private

  def set_folder
    @folder = Folder.find(params[:id])
  end

  def folder_params
    params.require(:folder).permit(:folder_name, :creator_id)
  end
end
