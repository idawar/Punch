class ClientsController < ApplicationController
	before_action :set_user, only: [:show, :update]

	def index
		@users = User.client
	end

	def create
		@user = User.client.new(client_params)
		render_error @user unless @user.save
	end

	def update
		render_error @user unless @user.update(client_params)
	end

	def show
	end

	private

	def set_user
		@user = User.client.find_by(id: params[:id])
		render :json => { errors: "Not Found" }, status: 404 unless @user.present?
	end

	def client_params
		params.require(:client).permit(:name, :email)
	end

end
