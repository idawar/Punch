class User < ApplicationRecord
	has_many :project_users, dependent: :destroy
	has_many :projects, through: :project_users
	has_many :products, foreign_key: "client_id", class_name: "Project"

	validates_presence_of :name, :email, :role
	validates_uniqueness_of :email

	enum role: [:employee, :client]

	def employees
		self.class.employee.joins(:project_users).
			where(project_users: { project_id: products.ids })
	end
end
