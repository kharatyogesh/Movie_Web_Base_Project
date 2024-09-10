<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search Actor</title>
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
        .btn-danger {
            background-color: #dc3545;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
        }
        .btn-danger:hover {
            background-color: #c82333;
        }
        .table {
            background-color: #f9f9f9;
        }
        .thead-dark {
            background-color: #000000;
            color: #ffcc00;
        }
        .modal-content {
            background-color: #003366;
            color: #ffcc00;
        }
    </style>
</head>
<body>
    <jsp:include page="superadmin.jsp"></jsp:include>

    <div class="container-fluid">
        <h1 class="text-center">Search Actor</h1>
        <div class="container form-container">
            <!-- Form -->
            <form id="searchActorForm" action="${pageContext.request.contextPath}/searchActor" method="get">
                <div class="form-row" style="width: 50%;margin-left: 280px">
                    <div class="form-group col-md-6 mx-auto">
                        <label for="inputName" style="margin-left: 80px">Actor Name</label>
                        <input type="text" class="form-control" id="inputName" name="actName" placeholder="Actor Name">
                    </div>
                </div>
                <div class="text-center">
                    <!-- Submit button -->
                    <button type="submit" class="btn btn-danger">Search</button>
                    <button type="button" class="btn btn-danger">
                        <a href="${pageContext.request.contextPath}/addA" class="text-white" style="text-decoration: none;">New</a>
                    </button>
                </div>
            </form>
        </div>

        <!-- Table to display search results -->
        <div class="container mt-4">
            <c:if test="${not empty actorList}">
                <table class="table table-bordered table-hover">
                    <thead class="thead-dark">
                        <tr>
                            <th scope="col">Actor Id</th>
                            <th scope="col">Actor Name</th>
                            <th scope="col">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="actor" items="${actorList}">
                            <tr>
                                <td><a href="#" class="actor-update-link" data-toggle="modal" data-target="#updateActorModal"
                                       data-actid="${actor.actId}" data-actname="${actor.actName}">${actor.actId}</a></td>
                                <td>${actor.actName}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/deleteActor?actid=${actor.actId}" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this actor?');">Delete</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
            <c:if test="${empty actorList}">
                <p class="text-center">No Actor found.</p>
            </c:if>
        </div>
    </div>

    <!-- Bootstrap Modal for Update Actor -->
    <div class="modal fade" id="updateActorModal" tabindex="-1" role="dialog" aria-labelledby="updateActorModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="updateActorModalLabel">Update Actor</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="updateActorForm" action="${pageContext.request.contextPath}/updateActor" method="post">
                        <input type="hidden" id="actorId" name="actId">
                        <div class="form-group">
                            <label for="updateActorName">Actor Name</label>
                            <input type="text" class="form-control" id="updateActorName" name="actName" required>
                        </div>
                        <button type="submit" class="btn btn-danger">Save changes</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KyZXEAg3QhqLMpG8r+Knujsl5/3lCz5/Kx5hlYXIaZlA4jYbF7T27+7ME6kbJfY3F" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-rsA2AtjKCXYM1dmF/Xx6ZTX6qU7xZLZZX7GZonVZ2pR7a8j0v7DffgBr5pPmo7x" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8Q7i4s6K3mtr98A9xF9F4QPyjB0DEqk2FwVRaM9o8nF3tKNv0" crossorigin="anonymous"></script>
    <script>
        $('#updateActorModal').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget); 
            var actId = button.data('actid'); 
            var actName = button.data('actname'); 
            
            var modal = $(this);
            modal.find('.modal-body #actorId').val(actId);
            modal.find('.modal-body #updateActorName').val(actName);
        });
    </script>
</body>
</html>
