class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]
  

  def show
    @book= Book.new#他人の詳細、投稿フォーム
    @user = User.find(params[:id])
    @books = @user.books
    @users = User.all
  end

  def index
    @users = User.all
    @book = Book.new
  end


  def edit
    @user = User.find(params[:id])#追加
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  #def follows
    #user = User.find(params[:id])
    #@users = user.following_user.page(params[:page]).per(3).reverse_order
  #end

  #def followers
  #  user = User.find(params[:id])
    #@users = user.follower_user.page(params[:page]).per(3).reverse_order
  #end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

 # def set_user#フォロー機能
 #   @user = User.find(params[:id])
#end


end
