<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title class="page-title">Admin Login</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        body {
            background-image: url('resources/images/back.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .container {
            background-color: rgba(0, 0, 0, 0.8);
            padding: 30px;
            border-radius: 15px;
            max-width: 400px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
            color: white;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
            font-family: 'Arial', sans-serif;
            color: #fff;
            font-weight: bold;
        }
        .form-group label {
            font-weight: bold;
            font-size: 16px;
            color: #ff9f00;
        }
        .form-control {
            background-color: #1c1c1c;
            border: none;
            border-radius: 5px;
            padding-left: 10px;
            color: white;
        }
        .form-control::placeholder {
            color: #888;
        }
        .btn-primary {
            background-color: #ff9f00;
            border: none;
            width: 100%;
            margin-top: 20px;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #ff7f00;
        }
        .btn-secondary {
            background-color: gray;
            width: 100%;
            margin-top: 10px;
            border: none;
        }
        .error-text {
            color: red;
            font-size: 16px;
            text-align: center;
            margin-bottom: 15px;
        }
        .form-control.invalid {
            border: 2px solid red;
        }
    </style>

</head>
<body>

<div class="container">
    <h2>Admin Login</h2>

    <c:if test="${not empty msg}">
        <span class="error-text">${msg}</span>
    </c:if>

    <form action="adminLogin" method="post" onsubmit="return validateForm();">
        <div class="form-group">
            <label for="username">Username:</label>
            <input type="text" class="form-control" id="username" name="username" placeholder="Enter username" required>
        </div>
        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" class="form-control" id="password" name="password" placeholder="Enter password" required>
        </div>
        <div id="error-message" class="error-text"></div>
        <div>
            <button type="submit" class="btn btn-primary">Login</button>
            <a href="home" class="btn btn-secondary">Back</a>
        </div>
    </form>
</div>

<script>
    function validateForm() {
        const username = document.getElementById('username');
        const password = document.getElementById('password');
        let valid = true;

        if (username.value.trim() === "") {
            username.classList.add('invalid');
            valid = false;
        } else {
            username.classList.remove('invalid');
        }

        if (password.value.trim() === "") {
            password.classList.add('invalid');
            valid = false;
        } else {
            password.classList.remove('invalid');
        }

        if (!valid) {
            document.getElementById('error-message').textContent = "Please fill out all fields.";
        }

        return valid;
    }
</script>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
