class RelationshipsController < ApplicationController
  def create
    followed = current_user.relationships.build(follower_id: params[:user_id]) #current_userに紐ついたrelationshipを作成
    followed.save
    redirect_to request.referrer 
  end
  
  def destroy    
    followed = current_user.relationships.find_by(follower_id: params[:user_id]) #current_userに紐ついたrelationshipを作成
    followed.destroy
    redirect_to request.referrer 
  end 
  
  #フォロー一覧
  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end
  # フォロワー一覧
  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end
  
end
