class ApplicationController < ActionController::Base
	# protect_from_forgery with: :exception
	before_action :authenticate_user, only: [:create, :update]

	def current_user
		@user
	end

	def authenticate_user
		authenticate_with_http_token do |token, options|
			@token = token
			# Authentication Logic and login
			# if session = Session.find_by_token token
			#   sign_in session.user
			# end
		end

		render_unauthorized unless @token.present?
	end

	rescue_from ActionController::UnknownFormat do |e|
      render json: { message: e.message }, staus: :unprocessable_entity
    end

    private

	def render_unauthorized
	    self.headers['WWW-Authenticate'] = 'Token realm="Application"'
	    render json: { errors: "Authentication Failed" }, status: 401
	end

	def render_error obj
		render :json => { errors: obj.errors.full_messages.to_sentence }, status: 422
	end
end
