class DashboardController < ApplicationController
  require 'gchart'

	before_action :verify_as_manager, except: [:home, :developer_dashboard, :get_todo_status, :change_todo_status] 
	before_action :verify_as_developer, except: [:home, :assign_todo_dev, :save_todo, :add_project, :project_manager_dashboard, :create_project, :save_project, :get_available_developers] 

  def home
  	begin
  		redirect_path = current_user.role == 1 ? "/project_manager_dashboard" : "/developer_dashboard"
  		redirect_to redirect_path
  	rescue Exception => e
  		Rails.logger.error "message: #{e.message}"
  	end
  end

  def project_manager_dashboard
  	begin
      @line_chart  = GenerateChart.generate_pie_chart
      # @line_chart = []
      # @all_projects = Project.all
      # @all_projects.each do |project|

      #   all_todos = Todo.where("project_id = ?", project.id).pluck(:status)
      #   new_c = all_todos.count("new")
      #   inp_c = all_todos.count("in progress")
      #   done_c = all_todos.count("done")
      #   arr = [done_c,inp_c,new_c]
      #   lab = ["Done(#{done_c})", "In progress(#{inp_c})", "New(#{new_c})" ]
      #   project_name = project.name
      #   if !(new_c == 0 && inp_c == 0 && done_c == 0)
  		  #   @line_chart << Gchart.pie(:data => arr, :title => "Project:#{project_name}" , :size => '400x200', :labels => lab)
      #   end
      # end
  	rescue Exception => e
  		Rails.logger.error "message: #{e.message}"
  	end
  end

  def developer_dashboard
  	begin
  		
  	rescue Exception => e
  		Rails.logger.error "message: #{e.message}"
  	end
  end

  def create_project
  end

  def save_project
    begin
      project_id = Project.save_project(params[:project_name])
      ProjectDeveloper.assign_dev_to_project(project_id, params[:selected_dev_ids]) if (!params[:selected_dev_ids].blank?)
      Todo.create_todo(project_id,params[:todo_list]) if (!params[:todo_list].blank?)
      redirect_to "/home"
    rescue Exception => e
      Rails.logger.error "message: #{e.message}"
    end
  end

  def get_available_developers()
    begin 
      @developers = User.get_all_developers
      # @assigned_developers = params[:project_status] == "create" ? [] : ProjectDeveloper.get_all_assigned_developers_ids(params[:project_id])
      @assigned_developers = params[:project_status] == "create" ? [] : DeveloperTodo.get_all_assigned_developers_ids(params[:todo_id])
      puts "developers-----------------", @developers.inspect
      puts "assigned_developers------------------", @assigned_developers.inspect
    rescue Exception => e
      Rails.logger.error "message: #{e.message}"
    end
  end

  def add_project
  end

  def save_todo
    Todo.create_todo(params[:project_id], params[:todo_list]) if (!params[:todo_list].blank?)
    redirect_to "/home"
  end

  def assign_todo_dev
    DeveloperTodo.add_todo(params)
    redirect_to "/home"
  end

  def get_todo_status
    @status = Todo.get_status(params[:todo_id])
  end

  def change_todo_status
    Todo.change_status(params)
    redirect_to "/home"
  end

  protected

  def verify_as_manager
  	if current_user.role != 1
  		redirect_to "/home"
  	end
  end

  def verify_as_developer
  	if current_user.role != 2
  		redirect_to "/home"
  	end
  end
end
