module Api
  class UrlsController < ApplicationController
    
    def get_token
      auth_token = AuthToken.new(token: SecureRandom.alphanumeric(16))
      render json: { token: auth_token.token} if auth_token.save
    end

    def create
      url = Url.new(long_url: params[:long_url])
      if url.save
        render json: { short_url: url.short_url}
      else
        render json: { errors: url.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def show
      url = Url.find_by!(short_url: params["id"])
      render json: { id: url.id, long_url: url.long_url, short_url: url.short_url }
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Short URL not found' }, status: :not_found
    end

  end
end
