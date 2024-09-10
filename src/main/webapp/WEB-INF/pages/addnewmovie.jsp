<%@ page import="org.techhub.model.GenreMasterModel"%>
<%@ page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Movie</title>
    <link rel="stylesheet" href="<c:url value='resources/CSS/addmovie.css' />" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" 
          rel="stylesheet" 
          integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" 
          crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" 
            integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" 
            crossorigin="anonymous"></script>
</head>
<body>
    <jsp:include page="superadmin.jsp"></jsp:include>
   <h1 class="text-center" style="margin-top: 30px;">Add New Movie</h1>
    <div class="container">
        
        <div class="form-container" style="background-color: lightgrey; padding: 20px; margin-top: 30px;">
            <form name="frm" id="frm" action="save" method="POST">
                <div class="form-group mb-3">
                    <label for="genreName" class="form-label">Genre</label>
                    <a href='genre' style='text-decoration: none; color: red; font-size: 30px;'>+</a>
                    <select name="genreName" id="genreName" class="form-control">
                        <option>Select Genre</option>
                        <c:forEach var="s" items="${genres}">
                            <option value="${s.getGenId()}">${s.getGenName()}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group mb-3">
                    <label for="movieName" class="form-label">Movie Name</label>
                    <input type="text" name="movieName" id="movieName" 
                           class="form-control" placeholder="Movie Name" required />
                </div>
                <div class="form-group mb-3">
                    <label for="movieReleaseDate" class="form-label">Movie Release Date</label>
                    <input type="date" name="movieReleaseDate" id="movieReleaseDate" 
                           class="form-control" required />
                </div>
                <div class="form-group mb-3">
                    <input type="submit" id="btn" name="s" value="Add Movie" 
                           class="form-control btn btn-primary" />
                </div>
            </form>
        </div>
    </div>
</body>
</html>
