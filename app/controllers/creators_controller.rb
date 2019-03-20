class CreatorsController < ApplicationController
  # 下記のアクションは、ログイン中のみ許可する
  before_action :authenticate_user!
  before_action :set_creator, only:[:show, :edit, :update]

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
  end

  def destroy
  end

  private

  def creator_params
    params.require(:creator).permit(:name, :icon, :icon_cache)
  end

  def set_creator
    @creator = Creator.find(params[:id])
  end
end