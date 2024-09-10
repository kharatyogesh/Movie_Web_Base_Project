<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Home</title>
<style>
/* Adjust the carousel to ensure a better fit */
carousel-inner {
	max-height: calc(100vh - 70px);
	/* Ensures the carousel fits within the viewport, subtracting space for the navbar */
	overflow: hidden;
}

.carousel-item img {
	width: 100%;
	height: auto; /* Adjusts the height automatically */
	max-height: calc(100vh - 10px);
	/* Ensures the image fits within the available space */
	object-fit: cover;
	/* Can be changed to 'contain' if cutting off the image is not desirable */
	border-radius: 10px;
}

carousel {
    margin: 0 auto;
    max-width: 90%;
    margin-top: 15px;
}

.carousel-control-prev-icon, .carousel-control-next-icon {
	background-color: rgba(0, 0, 0, 0.5);
	/* Makes the control icons more visible */
	border-radius: 50%;
}

.modal-content {
	border-radius: 0.75rem;
	box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
	transition: transform 0.3s ease-in-out;
}

.modal-content.show {
	transform: scale(1.02);
}

.modal-header {
	background-color: #343a40;
	color: #ffffff;
	border-bottom: 1px solid #444;
	border-top-left-radius: 0.75rem;
	border-top-right-radius: 0.75rem;
	padding: 1rem;
}

.modal-body {
	padding: 2rem;
	background-color: #f8f9fa;
}

.modal-footer {
	border-top: 1px solid #dee2e6;
	padding: 1rem;
	background-color: #f8f9fa;
}

.btn-primary {
	background-color: #007bff;
	border: none;
	border-radius: 0.3rem;
	padding: 0.75rem 1.25rem;
	font-size: 1rem;
	font-weight: bold;
	transition: background-color 0.3s ease;
}

.btn-primary:hover {
	background-color: #0056b3;
}

.btn-secondary {
	background-color: #6c757d;
	border: none;
	border-radius: 0.3rem;
	padding: 0.75rem 1.25rem;
	font-size: 1rem;
	font-weight: bold;
	transition: background-color 0.3s ease;
}

.btn-secondary:hover {
	background-color: #5a6268;
}

.modal-dialog {
	max-width: 500px;
	margin: 1.75rem auto;
}
</style>


<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">

</head>

<body >
	<!-- Navbar -->
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark"> <a
		class="navbar-brand" href="#">Movies Application</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown"
		aria-expanded="false" aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>
	<div style="margin-right: 20px" class="collapse navbar-collapse"
		id="navbarNavDropdown">
		<ul class="navbar-nav ml-auto" style="margin-right:70px;">
			<li class="nav-item"><a class="nav-link" href="#">Home</a></li>
			
		
			<li class="nav-item dropdown"><a
				class="nav-link dropdown-toggle" href="#"
				id="navbarDropdownMenuLink" role="button" data-toggle="dropdown"
				aria-haspopup="true" aria-expanded="false">Sign Up</a>
				<div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
					<div class="row">
						<div class="col-md-12">
							<h5 class="dropdown-header">Featured collections</h5>
							<a class="dropdown-item" href="log">Admin Login</a> <a
								class="dropdown-item" href="#" data-toggle="modal"
								data-target="#userLoginModal">User Login</a>
						</div>
					</div>
				</div></li>
		</ul>
	</div>
	</nav>

	<div id="carouselExampleIndicators" class="carousel slide"
		data-ride="carousel">
		<div class="carousel-indicators">
			<button type="button" data-target="#carouselExampleIndicators"
				data-slide-to="0" class="active" aria-current="true"
				aria-label="Slide 1"></button>
			<button type="button" data-target="#carouselExampleIndicators"
				data-slide-to="1" aria-label="Slide 2"></button>
			<button type="button" data-target="#carouselExampleIndicators"
				data-slide-to="2" aria-label="Slide 3"></button>
		</div>
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img src="resources/images/singham.jpg" class="d-block w-100"
					alt="Slide 1">
			</div>
			<div class="carousel-item">
				<img src="resources/images/kgf-2.jpg" class="d-block w-100"
					alt="Slide 2">
			</div>
			<div class="carousel-item">
				<img src="resources/images/tumtak.jpg" class="d-block w-100"
					alt="Slide 3">
			</div>
		</div>
		<button class="carousel-control-prev" type="button"
			data-target="#carouselExampleIndicators" data-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Previous</span>
		</button>
		<button class="carousel-control-next" type="button"
			data-target="#carouselExampleIndicators" data-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Next</span>
		</button>
	</div>

	<div class="modal fade" id="userLoginModal" style="margin-top: 60px"
		tabindex="-1" role="dialog" aria-labelledby="userLoginModalLabel"
		aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content" style="background-color:#f8f9fa ">
				<div class="modal-header">
					<h5 class="modal-title" id="userLoginModalLabel">User Login</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" >
					<form action="userLogin" method="post">
						<div class="form-group">
							<label for="username">Username:</label> <input type="text"
								class="form-control" id="username" name="username" required>
						</div>
						<div class="form-group">
							<label for="password">Password:</label> <input type="password"
								class="form-control" id="password" name="password" required>
						</div>
						<button type="submit" class="btn btn-primary">Login</button>
					</form>
					<div id="registerPrompt" class="mt-3" style="display: none;">
						<p class="text-danger">
							New User <a href="userRegister" class="btn btn-link">Register
								here</a>
						</p>
					</div>
					<!-- Display error message -->
					<div th:if="${error}" class="alert alert-danger mt-3">
						<p th:text="${error}"></p>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Bootstrap JS and dependencies -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script src="/JS/home.js"></script>
	<script>
		// Example JavaScript to handle showing the registration prompt
		// after login failure. Ensure this is triggered based on your backend response.
		function handleLoginFailure() {
			document.getElementById('registerPrompt').style.display = 'block';
		}

		// Simulate login failure for demonstration
		document.addEventListener('DOMContentLoaded', function() {
			// Simulate a failed login attempt
			setTimeout(handleLoginFailure, 1000); // Remove or replace this with your actual logic
		});
	</script>

</body>
</html>
