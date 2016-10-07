class DashboardController < ApplicationController

	before_action :verify_as_manager, except: [:home, :developer_dashboard] 
	before_action :verify_as_developer, except: [:home, :add_project, :project_manager_dashboard, :create_project, :save_project, :get_available_developers] 

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
      puts "params = #{params}"
      # Project.save_project(title)
      redirect_to "/home"
    rescue Exception => e
      Rails.logger.error "message: #{e.message}"
    end
  end

  def get_available_developers()
    begin 
      @developers = User.get_all_developers
      @assigned_developers = params[:project_status] == "create" ? [] : ProjectDeveloper.get_all_assigned_developers_ids(params[:project_id])
    rescue Exception => e
      Rails.logger.error "message: #{e.message}"
    end
  end

  def add_project
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
