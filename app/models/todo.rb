class Todo < ActiveRecord::Base
	belongs_to :project
	has_many :users, through: :developer_todos
end
