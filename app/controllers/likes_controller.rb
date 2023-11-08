class LikesController < ApplicationController
  before_action :store_location, only: %i[create destroy]

  def create
    @like = current_user.likes.build(stress_relief_id: params[:stress_relief_id])
    @like.save
    redirect_after_like
  end

  def destroy
    @like = current_user.likes.find_by(stress_relief_id: params[:stress_relief_id])
    @like.destroy
    redirect_after_like
  end

  private

  def store_location
    # セッションに元いたページを保存
    session[:return_to] = request.referer
  end

  def redirect_after_like
    # セッションに保存されたページにリダイレクト、なければデフォルトのページにリダイレクト
    redirect_to session.delete(:return_to) || stress_reliefs_path
  end
end
