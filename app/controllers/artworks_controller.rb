class ArtworksController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy] 
  # 下記のアクションは、ログイン中のみ許可する
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]

  def index
  end

end
