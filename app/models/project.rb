class Project < ApplicationRecord
	belongs_to :client, class_name: "User", foreign_key: "client_id", optional: true
	has_many :project_users, dependent: :destroy
	has_many :users, through: :project_users

	validates_presence_of :name

	accepts_nested_attributes_for :project_users, :client

	def employee_ids= employee_ids
		self.user_ids = employee_ids
	end
end
