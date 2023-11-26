class LikesController < ApplicationController
  def create
    @like = current_user.likes.build(stress_relief_id: params[:stress_relief_id])
    @like.save
    render_like_partial
  end

  def destroy
    @like = current_user.likes.find_by(stress_relief_id: params[:stress_relief_id])
    @like.destroy
    render_like_partial
  end

  private

  def render_like_partial
    @stress_relief = StressRelief.find(params[:stress_relief_id])
    render partial: 'like_button', locals: { stress_relief: @stress_relief }
  end
end
