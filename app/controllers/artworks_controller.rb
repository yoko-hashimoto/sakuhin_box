class ArtworksController < ApplicationController
  # 下記のアクションは、ログイン中のみ許可する
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :set_artwork, only: [:show, :edit, :update, :destroy] 

  def index
    # Artwork.published で artworkモデルで定義したスコープ published を呼びだす
    @artworks = Artwork.published.order(updated_at: "DESC")
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
      if @artwork.save
        redirect_to artworks_path, notice: "作品を投稿しました！"
      else
        render 'new'
      end

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
    params.require(:artwork).permit(:image, :image_cache, :caption, :creator_id, :created_date, :is_published, :folder_list)
  end

  def set_artwork
    @artwork = Artwork.find(params[:id])
  end

end
