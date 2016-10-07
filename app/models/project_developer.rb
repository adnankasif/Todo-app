class ProjectDeveloper < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  def self.get_all_assigned_developers_ids(project_id)
  	ProjectDeveloper.where("project_id = ?", project_id).to_a.uniq
  end

  def self.assign_dev_to_project(project_id, selected_dev_ids)
  	selected_dev_ids.each do |dev_id|
  		ProjectDeveloper.create(project_id: project_id, user_id: dev_id)
  	end	
  end
end
