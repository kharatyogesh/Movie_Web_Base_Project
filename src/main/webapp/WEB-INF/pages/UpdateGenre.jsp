<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Genre</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<jsp:include page="superadmin.jsp"></jsp:include>
    <div class="container mt-4" style="margin-top: 20px;background-color:lightgrey">
        <h2 class="text-center">Update Genre</h2>
        <form action="${pageContext.request.contextPath}/updateGenre" method="post" >
            
             <div class="form-group">
                <label for="updateGenreId">Genre ID</label>
                <input type="text" class="form-control" id="updateGenreId" name="genId" value="${genre.genId}" readonly>
            </div>
            <div class="form-group">
                <label for="updateGenreName">Genre Name</label>
                <input type="text" class="form-control" id="updateGenreName" name="genName" value="${genre.genName}" required>
            </div>
           
            <button type="submit" class="btn btn-primary" style="background-color: blue;margin-left: 500px;margin-bottom: 20px" >Save Genre</button>
        </form>
    </div>
</body>
</html>
