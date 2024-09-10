<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search Genres</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<style>
body {
	background-color: #f0f4f7;
}

.form-container {
	background-color: #003366;
	padding: 30px;
	border-radius: 15px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	margin: 20px auto;
	width: 60%;
}

h1 {
	font-size: 24px;
	color: #ffcc00;
	text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.2);
	text-align: center;
	margin-bottom: 20px;
}

label {
	color: #ffcc00;
	font-weight: bold;
}

.form-control {
	background-color: #f9f9f9;
	border: 1px solid #ccc;
	padding: 10px;
	border-radius: 5px;
}

.btn-primary {
	background-color: #ff6b6b;
	border: none;
	padding: 10px 20px;
	font-size: 16px;
}

.btn-primary:hover {
	background-color: #ff4b4b;
}

.btn-danger {
	background-color: #dc3545;
	border: none;
	padding: 10px 20px;
	font-size: 16px;
}

.btn-danger:hover {
	background-color: #c82333;
}

.table {
	background-color: #f9f9f9;
}

.thead-dark {
	background-color: #000000;
	color: #ffcc00;
}

.modal-content {
	background-color: #003366;
	color: #ffcc00;
}
</style>
</head>
<body>
	<jsp:include page="superadmin.jsp"></jsp:include>

	<div class="container-fluid">
		<h1 class="text-center">Search Genre</h1>
		<div class="container form-container">
			<!-- Form -->
			<form id="searchGenreForm"
				action="${pageContext.request.contextPath}/searchGenre" method="get">
				<div class="form-row" style="width: 50%;margin-left: 300px">
					<div class="form-group col-md-6 mx-auto">
						<label for="inputName" style="margin-left: 80px">Genre Name</label> <input type="text"
							class="form-control" id="inputName" name="genName"
							placeholder="Genre Title">
					</div>
				</div>
				<div class="text-center">
					<!-- Submit button -->
					<button type="submit" class="btn btn-danger">Search</button>
					<button type="button" class="btn btn-danger">
						<a href="${pageContext.request.contextPath}/genre"
							class="text-white" style="text-decoration: none;">New</a>
					</button>
				</div>
			</form>
		</div>

		<!-- Table to display search results -->
		<div class="container mt-4">
			<c:if test="${not empty genreList}">
				<table class="table table-bordered table-hover">
					<thead class="thead-dark">
						<tr>
							<th scope="col">Genre Id</th>
							<th scope="col">Genre Name</th>
							<th scope="col">Actions</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="genre" items="${genreList}">
							<tr>
								<td><a href="#" class="genre-update-link"
									data-toggle="modal" data-target="#updateGenreModal"
									data-genid="${genre.genId}" data-genname="${genre.genName}">${genre.genId}</a></td>
								<td>${genre.genName}</td>
								<td>
								<a href="${pageContext.request.contextPath}/deleteGenre?genid=${genre.genId}" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this genre?');">Delete</a>

								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:if>
			<c:if test="${empty genreList}">
				<p class="text-center">No Genre found.</p>
			</c:if>
		</div>
	</div>

	<!-- Bootstrap Modal for Update Genre -->
	<div class="modal fade" id="updateGenreModal" tabindex="-1"
		role="dialog" aria-labelledby="updateGenreModalLabel"
		aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="updateGenreModalLabel">Update
						Genre</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form id="updateGenreForm"
						action="${pageContext.request.contextPath}/updateGenre"
						method="post">
						<div class="form-group">
							<label for="updateGenreId">Genre ID</label> <input type="text"
								class="form-control" id="updateGenreId" name="genId" readonly>
						</div>
						<div class="form-group">
							<label for="updateGenreName">Genre Name</label> <input
								type="text" class="form-control" id="updateGenreName"
								name="genName" required>
						</div>
						<button type="submit" class="btn btn-primary">Save Genre</button>
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">Close</button>
						<a href="${pageContext.request.contextPath}/genre"
							class="btn btn-primary" style="margin-left: 30px">Add New
							Genre</a>
					</form>
				</div>
			</div>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"></script>

	<!-- Script to populate the modal with genre details -->
	<script>
		$(document).ready(function() {
			$('.genre-update-link').on('click', function() {
				var genId = $(this).data('genid');
				var genName = $(this).data('genname');

				$('#updateGenreId').val(genId);
				$('#updateGenreName').val(genName);
			});

			$('#searchGenreForm').on('submit', function(event) {
				var genreName = $('#inputName').val().trim();
				if (genreName === '') {
					alert('Please enter a genre name.');
					event.preventDefault(); // Prevent form submission
				}
			});

			$('#updateGenreForm').on('submit', function(event) {
				var genreName = $('#updateGenreName').val().trim();
				if (genreName === '' || /\s/.test(genreName)) {
					alert('Genre name cannot be empty or contain spaces.');
					event.preventDefault(); // Prevent form submission
				}
			});
		});
	</script>

</body>
</html>
