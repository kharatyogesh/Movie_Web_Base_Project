<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="org.techhub.model.UserModel"%>
<!DOCTYPE html>
<%
UserModel umodel = (UserModel) session.getAttribute("user");
%>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>User Dashboard</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<style>
body {
	background-image: url('resources/images/back.jpg');
	background-size: cover;
	background-repeat: no-repeat;
	background-attachment: fixed;
	background-position: center;
}

.sidebar {
	background-color: #343a40;
}
</style>
<script>
	function confirmLogout(event) {
		if (!confirm("Are you sure you want to logout?")) {
			event.preventDefault();
		}
	}
</script>
</head>
<body>



	<div class="container-fluid">
		<div class="row">

			<nav class="col-md-2 sidebar" style="height: 100vh;">
				<div class="sidebar-sticky" style="margin-top: 170px;">
					<ul class="nav flex-column">
						<li class="nav-item"><a class="nav-link active"
							href="userdashboard" target="contentFrame"> Dashboard </a></li>

						<li class="nav-item"><a class="nav-link"
							href="recommendations" target="contentFrame">Recommended
								Movies</a></li>

						<li class="nav-item"><a class="nav-link" href="watchedMovies"
							target="contentFrame"> Watchlist </a></li>

						<li class="nav-item"><a class="nav-link" href="#"
							data-toggle="modal" data-target="#changePasswordModal">
								Change Password </a></li>
						<li class="nav-item"><a class="nav-link" href="logout"
							onclick="confirmLogout(event)"> Logout </a></li>
					</ul>
				</div>
			</nav>

			<!-- Main Content Area with iframe -->
			<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
				<iframe name="contentFrame"
					style="width: 100%; height: 100vh; border: none;"></iframe>
			</main>
		</div>
	</div>


	<div class="modal fade" id="changePasswordModal" tabindex="-1"
		role="dialog" aria-labelledby="changePasswordModalLabel"
		aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="changePasswordModalLabel">Change
						Password</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form action="updatePassword" method="post">
					<div class="modal-body">
						<div class="form-group">
							<label for="currentPassword">Current Password</label> <input
								type="password" class="form-control" id="currentPassword"
								name="currentPassword" required>
						</div>
						<div class="form-group">
							<label for="newPassword">New Password</label> <input
								type="password" class="form-control" id="newPassword"
								name="newPassword" required>
						</div>
						<div class="form-group">
							<label for="confirmPassword">Confirm New Password</label> <input
								type="password" class="form-control" id="confirmPassword"
								name="confirmPassword" required>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">Close</button>
						<button type="submit" class="btn btn-primary">Save
							Changes</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>
