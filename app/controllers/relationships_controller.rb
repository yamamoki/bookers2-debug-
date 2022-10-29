class RelationshipsController < ApplicationController


  def create #フォローする
    current_user.follow(params[:user_id])
    redirect_to request.referer #遷移前のURLを取得してリダイレクト
  end

  def destroy   #フォローを外す
    current_user.unfollow(params[:user_id])
    redirect_back(fallback_location: root_path)
  end

  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end

end