<%@ page import="org.techhub.model.GenreMasterModel" %>
<%@ page import="java.util.List" %>
<%@ page import="org.techhub.model.MovieMasterModel" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Movie</title>
    <link rel="stylesheet" href="<c:url value='resources/CSS/addmovie.css' />">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
            crossorigin="anonymous"></script>
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
    </style>
    <script>
    function validateForm() {
        const movieName = document.getElementById('movieName').value.trim();
        const movieActor = document.getElementById('movieActor').value.trim();

        // Regular expression to match only spaces
        const isOnlySpaces = str => /^\s*$/.test(str);

        if (isOnlySpaces(movieName) || isOnlySpaces(movieActor)) {
            alert("Movie Name and Actor fields cannot be empty or contain only spaces.");
            return false;
        }

        return true;
    }

    </script>
</head>
<body>
    <jsp:include page="superadmin.jsp"></jsp:include>
    <h1>Add New Movie</h1>
    <div class="form-container">
       <form name="frm" id="frm" action="save" method="POST" onsubmit="return validateForm();">

            <div class="row">
                <div class="form-group col-md-4 mb-3">
                    <label for="movieId" class="form-label">Movie ID</label>
                    <input type="text" name="movieId" id="movieId" class="form-control"
                           value="${maxMovieId + 1}" readonly />
                    <input type="hidden" name="movieIdHidden" value="${maxMovieId + 1}" />
                </div>
                <div class="form-group col-md-4 mb-3">
                    <label for="genreName" class="form-label">Genre</label>
                    <select name="genName" id="genreName" class="form-control" required>
                        <option value="">Select Genre</option>
                        <c:forEach var="s" items="${genres}">
                            <option value="${s.getGenName()}">${s.getGenName()}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group col-md-4 mb-3">
                    <label for="movieName" class="form-label">Movie Name</label>
                    <input type="text" name="movTitle" id="movieName" class="form-control"
                           placeholder="Movie Name" required />
                </div>
            </div>
            <div class="row" style="margin-top: 20px">
                <div class="form-group col-md-6 mb-3">
                    <label for="movieReleaseDate" class="form-label">Movie Release Date</label>
                    <input type="date" name="movDate" id="movieReleaseDate" class="form-control" required />
                </div>
                <div class="form-group col-md-6 mb-3">
                    <label for="movieActor" class="form-label">Movie Actor</label>
                    <input type="text" name="actName" id="movieActor" class="form-control"
                           placeholder="Movie Actor" required />
                </div>
            </div>
            <div class="form-group text-center mb-3">
                <input type="submit" id="btn" name="s" value="Add Movie" class="btn btn-primary" />
            </div>
        </form>
    </div>
</body>
</html>
