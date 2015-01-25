$(document).ready(function(){
	
	setTimeout(function(){ $("#flash_notice").fadeOut("slow");}, 3000);
	
	$("#save_all_cats").click(function(){
		$(".edit_cat").each(function(){
			var action = $(this).attr("action");
			$("#save_all_cats_loading").ajaxStart(function(){
				$(this).show();
			});
			$("#save_all_cats_loading").ajaxStop(function(){
				setTimeout(function(){ $("#save_all_cats_loading").fadeOut("slow");}, 2000);
			});
			$.post(action, $(this).serialize(), null, "script");
		});
		$(".edit_sub_cat").each(function(){
			var action = $(this).attr("action");
			$.post(action, $(this).serialize(), null, "script");
		});
	});
	//stagger the cats on the /admin page
	$(".admin_main_category_wrapper:even").wrap("<div class='sixcol' />");
	$(".admin_main_category_wrapper:odd").wrap("<div class='sixcol last' />");
	
	
	//power the populating of the sub cats on the create ad page
	$("#ad_category").change(function(){
		var url = "/get_select?cat_val=" + $(this).val();
		$("#sub_cats_select").empty();
		$.getJSON(url, function(data){
			var blank_row = "<option value=\"" + "" + "\">" + "Select a sub category" + "</option>";
			$("#sub_cats_select").append(blank_row);
			$.each(data,function(i, value){
				var row = "<option value=\"" + value.sub_cat.name + "\">" + value.sub_cat.name + "</option>";
				$("#sub_cats_select").append(row);
			});
		});
	});
	
	//stagger the cats on the /browse page
	$(".main_category_wrapper:even").wrap("<div class='sixcol' />");
	$(".main_category_wrapper:odd").wrap("<div class='sixcol last' />");
	
	
	$("#ad_tags").focus(function(){
		$("#ad_tags_popup").fadeIn();
	});
	$("#ad_tags").blur(function(){
		$("#ad_tags_popup").fadeOut();
	});
	

	
	
	//everything for form validation
	$("#new_ad").validate();
	$("#new_user").validate();
	
	
	//everything for facebook
	FB.init({
	    appId  : "208162909212982",
	    status : false, // check login status
	    cookie : true, // enable cookies to allow the server to access the session
	    xfbml  : true  // parse XFBML
	  });
	
	$("#facebook").click(function(){
		var name = $(this).attr("name");
		var description = $(this).attr("description");
		var link = $(this).attr("link");
		share = {
			method: "feed",
			name: name,
			description: description,
			link: link,
			message: "Check out this classified ad"
		}
		FB.ui(share, function(){});
	});
	
	
	

	
	
});