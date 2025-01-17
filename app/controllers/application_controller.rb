class ApplicationController < ActionController::Base
	before_action :verify_authenticity_token, only: [:create, :show]
	private

	 def verify_authenticity_token
      token = request.headers["Authorization"]
      render json: { error: "Invalid Token." }, status: :unauthorized unless token&.split(" ")&.last == AuthToken.last.token
    end 

end
