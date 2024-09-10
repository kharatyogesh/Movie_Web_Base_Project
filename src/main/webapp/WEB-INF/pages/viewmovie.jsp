<%@page import="org.techhub.model.MovieMasterModel"%>
<%@ page import="org.techhub.model.GenreMasterModel" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
  
     <link  rel="stylesheet"  href="<c:url value="resources/CSS/genre.css" />" />
</head>
<body>
<jsp:include page="superadmin.jsp"></jsp:include>
    
    <table>
        <thead>
            <tr>
                <th>Movie  ID</th>
                <th>Movie NAME</th>
                <th>Movie Genre</th>
                 <th>Movie Date</th>
                <th>DELETE</th>
                <th>UPDATE</th>
            </tr>
        </thead>
        <tbody>
            <% 
                List<MovieMasterModel> movieList = (List<MovieMasterModel>) request.getAttribute("movies");
                if (movieList != null) {
                    for (MovieMasterModel movie : movieList) {
            %>
                <tr>
                    <td><%= movie.getMovieId() %></td>
                    <td><%= movie.getMovTitle()%></td>
                    <td><%= movie.getGenName() %></td>
                    <td><%= movie.getMovDate() %></td>
                   <td><a href="delGenById?id=<%= movie.getMovieId() %>">DELETE</a></td>
                    <td><a href="updateGenre?id=<%= movie.getMovieId() %>">UPDATE</a></td>
                </tr>
            <% 
                    }
                } else {
            %>
                <tr>
                    <td colspan="4">No Movies available</td>
                </tr>
            <% 
                }
            %>
        </tbody>
    </table>
</body>
</html>
