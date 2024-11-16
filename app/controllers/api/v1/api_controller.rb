# frozen_string_literal: true

class API::V1::APIController < ApplicationController

  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate_with_api_key

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  private

  def authenticate_with_api_key
    return true unless Rails.env.test?

    authenticate_or_request_with_http_token do |token, _options|
      @current_api_user = APIUser.active.with_token(token)
    end
  end

  # Override rails default 401 response to return JSON content-type
  # with request for Bearer token
  # https://api.rubyonrails.org/classes/ActionController/HttpAuthentication/Token/ControllerMethods.html
  def request_http_token_authentication(realm = "Application", message = nil)
    json_response = { errors: [message || "Access denied"] }
    headers["WWW-Authenticate"] = %(Bearer realm="#{realm.tr('"', '')}")
    render json: json_response, status: :unauthorized
  end

  def render_not_found
    render json: { errors: ["Record not found"] }, status: :not_found
  end

end
