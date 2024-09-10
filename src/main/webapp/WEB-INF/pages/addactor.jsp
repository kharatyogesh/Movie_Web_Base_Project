<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add New Actor</title>
     <link  rel="stylesheet"  href="<c:url value="resources/CSS/addactor.css" />" />

</head>
<body>
<jsp:include page="superadmin.jsp"></jsp:include>
<div class="container">
    <div class="form-container">
        <h2>Add New Actor</h2>
        <form name='frm' id="frm" action='saveActor' method="POST">
            <div class="form-group">
                <input type='text' name='actName' value='' id="actorName"
                    class="form-control" placeholder="Actor Name" required />
            </div>
            <div class="form-group">
                <input type='submit' id="btn" name='s' value='Add New Actor'
                    class="form-control" />
            </div>
        </form>
    </div>
</div>
</body>
</html>
