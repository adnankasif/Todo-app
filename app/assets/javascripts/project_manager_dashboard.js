$("document").ready(function(){

	$(document).on("click", "#create-project-btn", function(e) { 
		var form_data = {};
		$.ajax({
	      url: "/dashboard/create_project",
	      type: "POST",
	      data: form_data,
	      processData: false,
	      contentType: false,
	      dataType: "script"
	    });
    });

	$(document).on("click", "#add-project-save-btn", function(e) {
    	e.preventDefault();
    	if ($("#project_name").val().trim() == ""){
    		
    		alert("please enter title");
    		return false;
    	} else {
	    	$("#project_name").prop('required',true);

	    	var projectName = $("#project_name").val();
	    	var selectedDevIds = getCheckedItemsValues();
	    	var addedTodoList = getAddedTodoList();
	    	var form_data = {project_name: projectName, selected_dev_ids: selectedDevIds, todo_list: addedTodoList};

	    	$.ajax({
		      url: "/dashboard/save_project",
		      type: "POST",
		      data: form_data,
		      dataType: "script"
		    });
    	}
    });

    $(document).on("click", "#cancel_add_dev_block", function(e){
    	$("#add_dev_block").hide();
    	$("#add_developer_btn").show();
    });

    $(document).on("click", "#cancel_add_todo_block", function(e){
    	$("#add_todo_block").hide();
    	$("#add_todo_btn").show();
    });

    $(document).on("click", "#add_todo", function(e) {
    	var todoVal = $("#todo_description").val();
    	$("#added_todo_list").append("- <p>" + todoVal + "</p>");
    	$("#todo_description").val('');
    });
	
});

function closeCreateProjectPopup(){
	$('#project_name').val("");
	$("#add_project_form").empty();
	$("#create-project-btn").show();

}

function openDeveloperForm(e, project_status){
	$("#add_developer_btn").hide();
	var form_data = {project_status: project_status};
	$.ajax({
      url: "/dashboard/get_developers",
      type: "GET",
      data: form_data,
      processData: false,
      contentType: false,
      dataType: "script"
    });

}

function openTodoForm(e){
	$("#add_todo_block").show();
	$("#add_todo_btn").hide();
	$("#add_todo_block").empty().append($("<input type=\"text\" name=\"todoName\" id=\"todo_description\"><button type=\"button\" id=\"add_todo\">Add</button><br /><div id=\"added_todo_list\"></div><button type=\"reset\" value=\"Reset\" id=\"cancel_add_todo_block\">Cancel</button>"));

}

function getCheckedItemsValues() {
	var selectedDevIds = [];
	$('input[class="dev_checkbox"]:checked').each(function() {
   		selectedDevIds.push(this.value);
	});
	return selectedDevIds;
}

function getTodoDesc(){
	var todo_description = $("#todo_description").val();
	return todo_description;
}

function getAddedTodoList() {
	var todoArr = [];
	$("#added_todo_list p").each (function() {
		todoArr.push($(this).text());
	});
	return todoArr;
}