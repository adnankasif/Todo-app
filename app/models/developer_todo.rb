class DeveloperTodo < ActiveRecord::Base
  belongs_to :user
  belongs_to :todo

  def self.add_todo(params)
  	params[:selected_dev_ids].each do |dev|
  		DeveloperTodo.find_or_create_by(user_id: dev , todo_id: params[:todo_id])
  	end
  end

  def self.get_all_assigned_developers_ids(todo_id)
  	DeveloperTodo.where("todo_id = ?", todo_id).pluck(:user_id).to_a
  end

end
