<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Movie</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <style>
        body {
            background-color: #f0f4f7;
        }

        .form-container {
            background-color: #003366;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h1 {
            font-size: 24px;
            color: #ffcc00; /* Change the heading color here */
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.2);
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
        .btn {
            margin-top: 10px;
            padding: 10px 20px;
            font-size: 16px;
        }
        .btn-danger {
            background-color: #ff6b6b;
            border: none;
        }
        .btn-danger:hover {
            background-color: #ff4b4b;
        }
        .btn-new {
            background-color: #4caf50;
            color: white;
            border: none;
        }
        .btn-new:hover {
            background-color: #45a049;
        }
        table {
            margin-top: 20px;
        }
        .table {
            background-color: #ffffff;
            border-radius: 10px;
            overflow: hidden;
        }
        .table thead {
            background-color: #003366;
            color: #ffcc00;
        }
        .table tbody tr:hover {
            background-color: #e9f5ff;
        }
        /* Updated styling for sticky navbar */
        .navbar {
            background-image: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            padding: 15px 30px;
        }
        .navbar-brand {
            color: #fff;
            font-weight: bold;
        }
        .navbar-nav .nav-item .nav-link {
            color: #fff;
            margin-right: 15px;
        }
        .navbar-nav .nav-item .nav-link:hover {
            background-color: #ffffff;
            color: #2575fc;
            border-radius: 10px;
        }
        .sticky-top {
            position: -webkit-sticky;
            position: sticky;
            top: 0;
            z-index: 1020;
        }
    </style>
</head>
<body>

<jsp:include page="superadmin.jsp"></jsp:include>

<div class="container-fluid text-center">
    <h1>Search Movie</h1>
    <div class="form-container container">
        <!-- Form -->
        <form action="searchMovie" method="get">
            <div class="form-row">
                <!-- Movie Title and Genre with 6*6 column layout -->
                <div class="form-group col-md-6" style="width: 30%;margin-left: 170px">
                    <label for="inputName">Movie Title</label>
                    <input type="text" class="form-control" id="inputName" name="movieTitle" placeholder="Enter Movie Title">
                </div>
                <div class="form-group col-md-6" style="width: 30%;margin-left: 90px">
                    <label for="inputLang">Movie Genre</label>
                    <input type="text" class="form-control" id="inputLang" name="movieGenre" placeholder="Enter Movie Genre">
                </div>
            </div>

            <div class="form-row">
                <div class="form-group col-md-4" style="width: 25%;margin-left: 140px">
                    <label for="inputYearFrom">Year from</label>
                    <input type="date" class="form-control" id="inputYearFrom" name="yearFrom">
                </div>
                <div class="form-group col-md-4" style="width: 25%">
                    <label for="inputYearTo">Year to</label>
                    <input type="date" class="form-control" id="inputYearTo" name="yearTo">
                </div>
                <div class="form-group col-md-4" style="width: 25%">
                    <label for="inputActor">Actor</label>
                    <input type="text" class="form-control" id="inputActor" name="movieActor" placeholder="Enter Actor Name">
                </div>
            </div>

            <button type="submit" class="btn btn-danger">Search</button>
            <button type="button" class="btn btn-danger">
                <a href="${pageContext.request.contextPath}/add" class="text-white" style="text-decoration: none;">New</a>
            </button>
        </form>
    </div>
    <!-- Table to display search results -->
    <div class="container mt-4">
        <c:if test="${not empty movieList}">
            <table class="table table-bordered table-hover">
                <thead class="table-dark">
                    <tr>
                        <th scope="col">Movie Id</th>
                        <th scope="col">Movie Name</th>
                        <th scope="col">Movie Genre</th>
                        <th scope="col">Movie Release Date</th>
                        <th scope="col">Movie Actor</th>
                        <th scope="col">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="movie" items="${movieList}">
                        <tr>
                            <td><a href="${pageContext.request.contextPath}/updateMoviePage?movieId=${movie.movieId}">${movie.movieId}</a></td>
                            <td>${movie.movTitle}</td>
                            <td>${movie.genName}</td>
                            <td>${movie.movDate}</td>
                            <td>${movie.actName}</td>
                            <td>
                                <form action="${pageContext.request.contextPath}/delMovById" method="post" onsubmit="return confirm('Are you sure you want to delete this movie?');">
                                    <input type="hidden" name="movieId" value="${movie.movieId}">
                                    <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
        <c:if test="${empty movieList}">
            <p class="text-center">No movies found.</p>
        </c:if>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
        integrity="sha384-KJ3o2DKtIkv3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
        integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7HUbX39j7fakFPskvXusvfa0b4Q"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
        integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFwEzPbC2ec/xjxUrwxN5R"
        crossorigin="anonymous"></script>
</body>
</html>
