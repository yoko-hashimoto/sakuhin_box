class CreatorsController < ApplicationController
  # 下記のアクションは、ログイン中のみ許可する
  before_action :authenticate_user!
  before_action :set_creator, only:[:show, :edit, :update, :destroy]
  before_action :user_check, only: [:create, :edit, :update, :destroy]

  def index
  end

  def new
    @creator = Creator.new
  end

  def create
    #ログイン中のuserのcreatorをbuild(new)する
    @creator = current_user.creators.build(creator_params)

    if @creator.save
      # 保存に成功した場合の処理
      redirect_to creator_path(@creator.id), notice: "クリエイターを登録しました！"
    else
      render 'new'
    end
  end

  def edit
  end
  
  def show
  end

  def update
    if @creator.update(creator_params)
      redirect_to creator_path, notice: "クリエイター情報を編集しました"
    else
      render 'edit'
    end
  end

  def destroy
    @creator.destroy
    redirect_to artworks_path, notice:"クリエイターを削除しました！"
  end

  private

  def creator_params
    params.require(:creator).permit(:name, :icon, :icon_cache)
  end

  def set_creator
    @creator = Creator.find(params[:id])
  end

  def user_check
    # current_user と作品に紐付く user が相違している場合は作品一覧画面に遷移し、エラーメッセージを表示する
    unless current_user.id == Creator.find(params[:id]).user_id
      redirect_to artworks_path, notice: "権限がありません"
    end
  end
end