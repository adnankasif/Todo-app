class Project < ActiveRecord::Base
	has_many :users, through: :project_developers
	has_many :todos

	def self.save_project(title)
		new_project = Project.new()
		new_project.name = title
		new_project.save!
	end

end
