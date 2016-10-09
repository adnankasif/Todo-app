class Todo < ActiveRecord::Base
	belongs_to :project
	has_many :users, through: :developer_todos

	def self.create_todo(project_id, todo_list_arr)
		todo_list_arr.each do |dev_id|
  			Todo.create(project_id: project_id, item: dev_id)
  		end	
	end

	def self.get_status(todo_id)
		Todo.where("id = ?", todo_id)
	end

	def self.change_status(params)
		todo = Todo.find_by_id(params[:todo_id])
		todo.update_attributes(:status => params[:status])
	end

end
