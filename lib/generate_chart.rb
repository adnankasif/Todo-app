class GenerateChart
	  require 'gchart'

	def self.generate_pie_chart
		@line_chart = []
	    @all_projects = Project.all
	    @all_projects.each do |project|

        all_todos = Todo.where("project_id = ?", project.id).pluck(:status)
        new_c = all_todos.count("new")
        inp_c = all_todos.count("in progress")
        done_c = all_todos.count("done")
        arr = [done_c,inp_c,new_c]
        lab = ["Done(#{done_c})", "In progress(#{inp_c})", "New(#{new_c})" ]
        project_name = project.name
        if !(new_c == 0 && inp_c == 0 && done_c == 0)
  		    @line_chart << Gchart.pie(:data => arr, :title => "Project:#{project_name}" , :size => '400x200', :labels => lab)
        end
      	end
      	@line_chart
	end
end