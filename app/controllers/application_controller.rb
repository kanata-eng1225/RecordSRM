class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :store_user_location!, if: :storable_location?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || super
  end

  def after_sign_up_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || super
  end

  private

  # ユーザーがログインや新規登録を要求される前にアクセスしようとしていたページの情報を保存する
  def store_user_location!
    store_location_for(:user, request.fullpath)
  end

  # リダイレクト先の情報を保存すべきかどうかを判定する
  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end
end
