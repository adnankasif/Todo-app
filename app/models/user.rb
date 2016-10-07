class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	     :recoverable, :rememberable, :trackable, :validatable

	has_many :projects, through: :project_developers
	has_many :todos, through: :developer_todos

	def self.get_all_developers
		User.all.where("role = ?", 2)
	end
end
