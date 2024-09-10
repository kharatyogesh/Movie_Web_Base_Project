<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
 <title class="page-title">User Registration</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
    
        body {
            background-color: #f8f9fa;
             background-image: url('resources/images/back.jpg'); 
        }
        .container {
            margin-top: 50px;
            max-width: 600px;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            background-color:#131311 ;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        .form-group label {
            font-weight: bold;
            color: white;
            margin-left: 110px;
        }
         .form-group input
         {
         	width: 60%;
         	margin-left: 110px;
         }
        .btn-primary {
            background-color: #007bff;
            border: none;
            border-radius: 0.3rem;
            padding: 0.75rem 1.25rem;
            font-size: 1rem;
            font-weight: bold;
            transition: background-color 0.3s ease;
            margin-left: 220px;
          
            height: 50px;
           
        }
        .btn-primary:hover {
            background-color: orange;
        }
    </style>
</head>
<body>

<div class="container">
    <h2 style="color: white;margin-left: 150px">User Registration</h2>
    <form action="saveUser" method="post" style="margin-top: 20px">
        <!-- u_id will be auto-generated, so no input field for it -->
        <div class="form-group">
            <label for="contact">Contact:</label>
            <input type="text" class="form-control" id="contact" name="contact" required>
        </div>
        <div class="form-group">
            <label for="u_name">Username:</label>
            <input type="text" class="form-control" id="u_name" name="u_name" required>
        </div>
        <div class="form-group">
            <label for="city">City:</label>
            <input type="text" class="form-control" id="city" name="city" required>
        </div>
        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" class="form-control" id="password" name="password" required>
        </div>
        <button type="submit" class="btn btn-primary">Register</button>
    </form>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
