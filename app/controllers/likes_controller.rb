class LikesController < ApplicationController
  def create
  @like = current_user.likes.build(stress_relief_id: params[:stress_relief_id])
  @like.save
  redirect_to stress_relief_path(params[:stress_relief_id])
  end

  def destroy
    @like = current_user.likes.find_by(stress_relief_id: params[:stress_relief_id])
    @like.destroy
    redirect_to stress_relief_path(params[:stress_relief_id])
  end
end
