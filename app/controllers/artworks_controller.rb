class ArtworksController < ApplicationController
  # before_action :set_artwork, only: [:show, :edit, :update, :destroy] 
  # 下記のアクションは、ログイン中のみ許可する
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]

  def index
  end

  def new
  end

  def edit
  end
  
  def show
  end

  def update
  end

  def destroy
  end

end
