<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Movie</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<jsp:include page="superadmin.jsp"></jsp:include>
 <h2 class="text-center" style="font-size: 20px">Update Movie</h2>
    <div class="container mt-4" style="background-color:lightgrey;width: 60%">
       
        <form action="${pageContext.request.contextPath}/updateMovie" method="post" >
            
             <div class="form-group">
                <label for="updateMovieId">Movie ID</label>
                <input type="text" class="form-control" id="updateMovieId" name="movieId" value="${movie.movieId}" readonly>
            </div>
            <div class="form-group">
                <label for="updateTitle">Movie Title</label>
                <input type="text" class="form-control" id="updateTitle" name="movTitle" value="${movie.movTitle}" required>
            </div>
            <div class="form-group">
                <label for="updateGenre">Movie Genre</label>
                <input type="text" class="form-control" id="updateGenre" name="genName" value="${movie.genName}" required>
            </div>
            <div class="form-group">
                <label for="updateDate">Release Date</label>
                <input type="date" class="form-control" id="updateDate" name="movDate" value="${movie.movDate}" required>
            </div>
              <div class="form-group">
                <label for="updateActor">Movie Actor</label>
                <input type="text" class="form-control" id="updateActor" name="actName" value="${movie.actName}" required>
            </div>
           
            <button type="submit" class="btn btn-primary" style="background-color: blue;margin-left: 320px;margin-bottom: 20px" >Save Movie</button>
        </form>
    </div>
</body>
</html>
