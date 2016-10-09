$("document").ready(function(){

	$(document).on("click", "#create-project-btn", function(e) { 
		var form_data = {};
		$.ajax({
	      url: "/dashboard/create_project",
	      type: "POST",
	      data: form_data,
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

    // $(document).on("click", "#cancel_add_todo_block_pr", function(e){
    // 	$("#add_todo_block_pr").hide();
    // 	$("#add_todo_block_pr").empty();
    // 	$("#add_todo_btn_for_project").show();
    // });


    $(document).on("click", "#add_todo", function(e) {
    	var todoVal = $("#todo_description").val();
    	$("#added_todo_list").append("- <p>" + todoVal + "</p>");
    	$("#todo_description").val('');
    });

    $(document).on("click", "#add_todo_pr", function(e) {
    	var todoVal = $("#todo_description_pr").val();
    	$("#added_todo_list_pr").append("- <p>" + todoVal + "</p>");
    	$("#todo_description_pr").val('');
    });

    $(document).on("click", "#save_add_dev_block", function(e){
    	// var selectedDevIds = [];
		selectedDevIds = getCheckedItemsValues();

    });
    // $(document).on("click", "#save_todo_for_pr", function(e){
    // 	var getTodoDescList = getAddedTodoList();
    // });
	
});

function save_add_dev_block_pr(e, todoId){
	selectedDevIds = getCheckedItemsValues();
	if (selectedDevIds === undefined || selectedDevIds.length == 0){
		return false;
	} else{
		var form_data = {selected_dev_ids: selectedDevIds, todo_id: todoId};
		$.ajax({
	      url: "/dashboard/assign_todo_dev",
	      type: "POST",
	      data: form_data,
	      dataType: "script"
	    });
	}
	

}

function cancel_add_dev_block_pr(e, todoId){
	$('input:checkbox').removeAttr('checked');
	$("#add_dev_block_pr"+todoId).hide();
    $("#add_dev_btn_for_todo"+todoId).show();
}

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
      dataType: "script"
    });

}

function openAddDevFormForProject(e,todoId, project_id){
	if ($(".add_dev_block_pr").is(':visible')){
		return false;
	}else{
		$("#add_dev_btn_for_todo"+todoId).hide();
		var project_status = "edit";
		var form_data = {project_status: project_status, project_id: project_id, todo_id: todoId};
		$.ajax({
	      url: "/dashboard/get_developers",
	      type: "GET",
	      data: form_data,
	      dataType: "script"
	    });
	}

	
}

function openTodoForm(e){
	$("#add_todo_block").show();
	$("#add_todo_btn").hide();
	$("#add_todo_block").empty().append($("<input type=\"text\" name=\"todoName\" id=\"todo_description\"><button type=\"button\" id=\"add_todo\">Add</button><br /><div id=\"added_todo_list\"></div><button type=\"reset\" value=\"Reset\" id=\"cancel_add_todo_block\">Cancel</button>"));

}

function openTodoFormForProject(e, p){
	$("#add_todo_block_pr"+p).show();
	$("#add_todo_btn_for_project"+p).hide();
	var id1 = "cancel_add_todo_block_pr"+p;

	$("#add_todo_block_pr"+p).empty().append($("<input type=\"text\" name=\"todoName\" id=\"todo_description_pr" + p + "\"><button type=\"button\" id=\"add_todo_pr" + p + "\" onclick = \"addTodoButtonPr("+p+");\">Add</button><br /><div id=\"added_todo_list_pr" + p + "\"></div><button type=\"reset\" onclick=\"open1("+p+");\"  value=\"Reset\" id=\"cancel_add_todo_block_pr" + p + "\">Cancel</button><button onclick=\"saveTodoList("+p+");\" id=\"save_todo_for_pr" + p + "\">Save</button>"));
}

function addTodoButtonPr(p){
	var todoVal = $("#todo_description_pr"+p).val();
	$("#added_todo_list_pr"+p).append("- <p>" + todoVal + "</p>");
	$("#todo_description_pr"+p).val('');
}

function saveTodoList(p){
    var getTodoDescList = getAddedTodoListPr(p);
    var form_data = {project_id: p, todo_list: getTodoDescList};
	$.ajax({
      url: "/dashboard/save_todo_for_project",
      type: "POST",
      data: form_data,
      dataType: "script"
    });
	open1(p);
}

function open1(p){
	$("#add_todo_block_pr"+p).hide();
    $("#add_todo_block_pr"+p).empty();
    $("#add_todo_btn_for_project"+p).show();
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
		if($(this).text().trim().length === 0){

		}else{
			todoArr.push($(this).text().trim());
		}
	});
	return todoArr;
}

function getAddedTodoListPr(p){
	var todoArr = [];
	var id = "added_todo_list_pr"+p;

	$("#"+id+" p").each (function() {
		if($(this).text().trim().length === 0){

		}else{
			todoArr.push($(this).text().trim());
		}
		
	});
	return todoArr;
}