class FoldersController < ApplicationController
  before_action :set_folder, only: [:show, :edit, :update, :destroy]

  def index
    @folders = Folder.all
  end

  def show
  end

  def new
    @folder = Folder.new
  end

  def edit
  end

  def create
    @folder = Folder.new(folder_params)
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
