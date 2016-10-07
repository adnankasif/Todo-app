class ProjectDeveloper < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  def self.get_all_assigned_developers_ids(project_id)
  	ProjectDeveloper.where("project_id = ?", project_id).to_a.uniq
  end
end
