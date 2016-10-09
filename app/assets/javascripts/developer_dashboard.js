$("document").ready(function(){





});



function openChangeStatusOption(e, todoId){

	if ($(".radio_option").is(':visible')) {
		return false;
	}else{
		var form_data = {user_id: current_user_id, todo_id: todoId};
		$.ajax({
		  url: "/dashboard/get_todo_status",
		  type: "GET",
		  data: form_data,
		  dataType: "script"
		});
	}

	
}

function cancel_change_status(e, todoId){
	$("#change_status_btn_for_todo"+todoId).show();
	$("#add_change_status_block"+todoId).hide();
	$("#radio_option"+todoId).hide();

	$('input:radio[name=stat]').attr('checked', false);


	// $('input:checkbox').removeAttr('checked');
	// $("#add_dev_block_pr"+todoId).hide();
 //    $("#add_dev_btn_for_todo"+todoId).show();
}

function save_change_status(e, todoId){

	
	if (!$("input[name='stat']:checked").val()){
			return false;

		}else{
				var selectedStat = document.querySelector('input[name="stat"]:checked').value;
				var form_data = {status: selectedStat, todo_id: todoId};
				$.ajax({
				  url: "/dashboard/change_todo_status",
				  type: "POST",
				  data: form_data,
				  dataType: "script"
				});
		}

	
}