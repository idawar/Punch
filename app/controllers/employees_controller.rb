class EmployeesController < ApplicationController
	before_action :set_employee, only: [:show, :update]

	def index
		@employees = User.employee
	end

	def create
		@employee = User.employee.new(employee_params)
		render_error @employee unless @employee.save
	end

	def update
		render_error @employee unless @employee.update_attributes(employee_params)
	end

	def show
	end

	private

	def set_employee
		@employee = User.employee.find_by(id: params[:id])
		render :json => { errors: "Not Found" }, status: 404 unless @employee.present?
	end

	def employee_params
		params.require(:employee).permit(:name, :email)
	end

end
