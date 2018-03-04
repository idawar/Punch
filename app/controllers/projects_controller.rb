class ProjectsController < ApplicationController
	before_action :set_project, only: [:show, :update]

	def index
		@projects = Project.all
	end

	def create
		@project = Project.new(project_params)
		render_error @project unless @project.save
	end

	def show
	end

	def update
		render_error @project unless @project.update_attributes(project_params)
	end

	private

	def set_project
		@project = Project.find_by(id: params[:id])
		render :json => { errors: "Not Found" }, status: 404 unless @project.present?
	end

	def project_params
		params.require(:project).permit(:name, :description, :client_id, employee_ids: [])
	end

end
