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
                <th>GENRE ID</th>
                <th>GENRE NAME</th>
                <th>DELETE</th>
                <th>UPDATE</th>
            </tr>
        </thead>
        <tbody>
            <% 
                List<GenreMasterModel> genreList = (List<GenreMasterModel>) request.getAttribute("record");
                if (genreList != null) {
                    for (GenreMasterModel genre : genreList) {
            %>
                <tr>
                    <td><%= genre.getGenId() %></td>
                    <td><%= genre.getGenName() %></td>
                   <td><a href="delGenById?genid=<%= genre.getGenId() %>">DELETE</a></td>
                    <td><a href="updateGenre?id=<%= genre.getGenId() %>">UPDATE</a></td>
                </tr>
            <% 
                    }
                } else {
            %>
                <tr>
                    <td colspan="4">No genres available</td>
                </tr>
            <% 
                }
            %>
        </tbody>
    </table>
</body>
</html>
