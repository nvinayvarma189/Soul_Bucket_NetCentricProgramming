<!DOCTYPE html>
<html>
	<head>
        <!-- Content Type Meta tag -->
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <!--Responsive Viewport Meta tag-->
        <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">


		<title>Bucket list app</title>


        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">

		<!-- jQuery library -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

		<!-- Latest compiled JavaScript -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>


		<!-- Roboto font embed -->
		<link href="https://fonts.googleapis.com/css?family=Roboto:400,500,700" rel="stylesheet">

		<!-- Stylesheets -->
		<link rel="stylesheet" type="text/css" href="resources/css/reset.min.css">
		<link rel="stylesheet" type="text/css" href="resources/css/style.css">
	</head>
	<style>

</style>
	<body>



			<%
			HttpSession session_dash = request.getSession(false);
        	if(session_dash!=null){
				String First_name = (String)session_dash.getAttribute("First_name");
				String User_id = (String)session_dash.getAttribute("User_id");

				System.out.println(session_dash.getAttribute("rs_todo_list"));
				System.out.println(session_dash.getAttribute("rs_done_list"));

				String rs_todo = (String) session_dash.getAttribute("rs_todo_list");
				String rs_done = (String) session_dash.getAttribute("rs_done_list");

				System.out.println(1111);
				System.out.println(rs_todo);
				System.out.println(rs_done);


		%>



		<ul  class="navbar">
		  <li><a href="#home">Hello <% out.print(First_name); %>, UserID: <% out.print(User_id); %></a></li>
		  <li style="float:right"><a href = "LogoutController" onclick="clearBox('todo')">Logout</a></li>
		</ul>




	<%@page import="javax.servlet.http.*, java.sql.*, java.util.*" %>



			<header>
				<input type="text" placeholder="Enter an activity.." id="item">
				<button id="add">
					<svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"viewBox="0 0 16 16" style="enable-background:new 0 0 16 16;" xml:space="preserve"><g><path class="fill" d="M16,8c0,0.5-0.5,1-1,1H9v6c0,0.5-0.5,1-1,1s-1-0.5-1-1V9H1C0.5,9,0,8.5,0,8s0.5-1,1-1h6V1c0-0.5,0.5-1,1-1s1,0.5,1,1v6h6C15.5,7,16,7.5,16,8z"/></g></svg>
				</button>
			</header>

		<div class="container">
			<!-- Uncompleted tasks -->
			<ul class="todo" id="todo"></ul>

			<!-- Completed tasks -->
			<ul class="todo" id="completed"></ul>
		</div>



			<p id= 'First_name_id' style="display:none"> <% out.print(First_name); %> </p>

			<p id= 'rs_todo' style="display:none"> <% out.print(rs_todo); %> </p>
			<p id= 'rs_done' style="display:none"> <% out.print(rs_done); %> </p>

			<p id= 'User_id_id' style="display:none"> <% out.print(User_id); %> </p>

		<% }%>


		<!-- JavaScripts -->


		<script>
				var First_name_var = document.getElementById("First_name_id").innerHTML;
				var User_id_var = document.getElementById("User_id_id").innerHTML;

			    var value_var1 = document.getElementById("rs_done").innerHTML;
				var value_var2 = document.getElementById("rs_todo").innerHTML;

				var todo_items = value_var2.split("/*break*/");
				var done_items = value_var1.split("/*break*/");



				var data = (localStorage.getItem('todoList')) ? JSON.parse(localStorage.getItem('todoList')):{
				todo: [],
				completed: []
				};

				// Remove and complete icons in SVG format
				var removeSVG = '<svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 22 22" style="enable-background:new 0 0 22 22;" xml:space="preserve"><rect class="noFill" width="22" height="22"/><g><g><path class="fill" d="M16.1,3.6h-1.9V3.3c0-1.3-1-2.3-2.3-2.3h-1.7C8.9,1,7.8,2,7.8,3.3v0.2H5.9c-1.3,0-2.3,1-2.3,2.3v1.3c0,0.5,0.4,0.9,0.9,1v10.5c0,1.3,1,2.3,2.3,2.3h8.5c1.3,0,2.3-1,2.3-2.3V8.2c0.5-0.1,0.9-0.5,0.9-1V5.9C18.4,4.6,17.4,3.6,16.1,3.6z M9.1,3.3c0-0.6,0.5-1.1,1.1-1.1h1.7c0.6,0,1.1,0.5,1.1,1.1v0.2H9.1V3.3z M16.3,18.7c0,0.6-0.5,1.1-1.1,1.1H6.7c-0.6,0-1.1-0.5-1.1-1.1V8.2h10.6V18.7z M17.2,7H4.8V5.9c0-0.6,0.5-1.1,1.1-1.1h10.2c0.6,0,1.1,0.5,1.1,1.1V7z"/></g><g><g><path class="fill" d="M11,18c-0.4,0-0.6-0.3-0.6-0.6v-6.8c0-0.4,0.3-0.6,0.6-0.6s0.6,0.3,0.6,0.6v6.8C11.6,17.7,11.4,18,11,18z"/></g><g><path class="fill" d="M8,18c-0.4,0-0.6-0.3-0.6-0.6v-6.8c0-0.4,0.3-0.6,0.6-0.6c0.4,0,0.6,0.3,0.6,0.6v6.8C8.7,17.7,8.4,18,8,18z"/></g><g><path class="fill" d="M14,18c-0.4,0-0.6-0.3-0.6-0.6v-6.8c0-0.4,0.3-0.6,0.6-0.6c0.4,0,0.6,0.3,0.6,0.6v6.8C14.6,17.7,14.3,18,14,18z"/></g></g></g></svg>';
				var completeSVG = '<svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 22 22" style="enable-background:new 0 0 22 22;" xml:space="preserve"><rect y="0" class="noFill" width="22" height="22"/><g><path class="fill" d="M9.7,14.4L9.7,14.4c-0.2,0-0.4-0.1-0.5-0.2l-2.7-2.7c-0.3-0.3-0.3-0.8,0-1.1s0.8-0.3,1.1,0l2.1,2.1l4.8-4.8c0.3-0.3,0.8-0.3,1.1,0s0.3,0.8,0,1.1l-5.3,5.3C10.1,14.3,9.9,14.4,9.7,14.4z"/></g></svg>';

				renderTodoList();
				console.log(todo_items);
				console.log(done_items);


				for (var i = 0; i < todo_items.length; i++) {
					if (todo_items[i] != " " && todo_items[i] != "  ")
						addItemToDOM(todo_items[i]);
				}

				for (var i = 0; i < done_items.length; i++) {
					if (done_items[i] != " " && done_items[i] != "  ")
						addItemToDOM(done_items[i], true);
				}


				document.getElementById('add').addEventListener('click', function() {
				var value = document.getElementById('item').value;
				if (value) {
					var value_post = {value1:{User_id_var}, value2:{value}};
					$.post("InsertHandler", JSON.stringify(value_post), function(response) {
						// handle response from your servlet.
					});
					addItemToDOM(value);
				}
				});

				// document.getElementById('item').addEventListener('keydown', function (e) {
				// var value = this.value;
				// if ((e.code === 'Enter' || e.code === 'NumpadEnter') && value) {
				// 	addItemToDOM(value);
				// }
				// });

				function addItem (value) {
					addItemToDOM(value);
					document.getElementById('item').value = '';

					data.todo.push(value);
					dataObjectUpdated();
					}

					function renderTodoList() {
					if (!data.todo.length && !data.completed.length) return;

					// for (var i = 0; i < data.todo.length; i++) {
					// 	var value = data.todo[i];
					// 	addItemToDOM(value);
					// }

					// for (var j = 0; j < data.completed.length; j++) {
					// 	var value = data.completed[j];
					// 	addItemToDOM(value, true);
					// }
				}

				function dataObjectUpdated() {
					localStorage.setItem('todoList', JSON.stringify(data));
				}

				function removeItem() {
					var item = this.parentNode.parentNode;
					var parent = item.parentNode;
					var id = parent.id;
					var value = item.innerText;

					var value_post_delete = {value1:{User_id_var}, value2:{value}};

					$.post("DeleteHandler", JSON.stringify(value_post_delete), function(response) {
						// handle response from your servlet.s
					});

					if (id === 'todo') {
						data.todo.splice(data.todo.indexOf(value), 1);
					} else {
						data.completed.splice(data.completed.indexOf(value), 1);
					}
					dataObjectUpdated();

					parent.removeChild(item);
				}

				function completeItem() {
					var item = this.parentNode.parentNode;
					var parent = item.parentNode;
					var id = parent.id;
					var value = item.innerText;

					var value_post_complete = {value1:{User_id_var}, value2:{value}};

					$.post("UpdateHandler", JSON.stringify(value_post_complete), function(response) {
						// handle response from your servlet.s
					});

					if (id === 'todo') {
						data.todo.splice(data.todo.indexOf(value), 1);
						data.completed.push(value);
					} else {
						data.completed.splice(data.completed.indexOf(value), 1);
						data.todo.push(value);
					}
					dataObjectUpdated();

					// Check if the item should be added to the completed list or to re-added to the todo list
					var target = (id === 'todo') ? document.getElementById('completed'):document.getElementById('todo');

					parent.removeChild(item);
					target.insertBefore(item, target.childNodes[0]);
				}

				// Adds a new item to the todo list
				function addItemToDOM(text, completed) {
					var list = (completed) ? document.getElementById('completed'):document.getElementById('todo');

					var item = document.createElement('li');
					item.className = "allitems";
					item.innerText = text;

					var buttons = document.createElement('div');
					buttons.classList.add('buttons');

					var remove = document.createElement('button');
					remove.classList.add('remove');
					remove.innerHTML = removeSVG;

					// Add click event for removing the item
					remove.addEventListener('click', removeItem);

					var complete = document.createElement('button');
					complete.classList.add('complete');
					complete.innerHTML = completeSVG;

					// Add click event for completing the item
					complete.addEventListener('click', completeItem);

					buttons.appendChild(remove);
					buttons.appendChild(complete);
					item.appendChild(buttons);

					list.insertBefore(item, list.childNodes[0]);
				}


				function clearBox(elementID1)
					{
						console.log("came");
						console.log(elementID1);
						// var div = document.getElementById(elementID1);
						// while(div.firstChild){
						// 	console.log("here")
						// 	div.removeChild(div.firstChild);
						// }

						$('.allitems').remove();
					}



		</script>

        <!-- <a href = "LogoutController" onclick="clearBox('todo')">Logout</a> -->
	</body>
</html>
