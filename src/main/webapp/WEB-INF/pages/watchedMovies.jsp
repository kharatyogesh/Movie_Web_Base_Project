<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.techhub.model.MovieMasterModel" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Watched Movies</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <style>
        .card {
            border-radius: 20px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            margin-bottom: 20px;
        }
        .card-img-top {
            border-radius: 20px;
            height: 200px;
            object-fit: cover;
        }
    </style>
</head>
<body style="background-color: grey;">
    <div class="container mt-5" style="background-color: #f0f0f0; padding: 20px;">
        <h1 class="text-center mb-4">Watched Movies</h1>
        
        <div class="row">
            <% 
                // Retrieve the watched movies list from the request attribute
                List<MovieMasterModel> watchedMovies = (List<MovieMasterModel>) request.getAttribute("watchedMovies");
                
                if (watchedMovies != null) {
                    for (MovieMasterModel movie : watchedMovies) {
                        String movieTitle = movie.getMovTitle();
                        String imageUrl = request.getContextPath() + "/resources/images/" + movieTitle.replaceAll(" ", "").toLowerCase() + ".jpg";
                        String movieId = String.valueOf(movie.getMovieId());
            %>
                <div class="col-6 col-md-3">
                    <div class="card">
                        <a href="movieDetails?id=<%= movieId %>">
                            <img src="<%= imageUrl %>" class="card-img-top" alt="<%= movieTitle %>">
                        </a>
                        <div class="card-body text-center">
                            <h5 class="card-title"><%= movieTitle %></h5>
                            <p class="card-text">Release Date: <%= movie.getMovDate() %></p>
                        </div>
                    </div>
                </div>
            <% 
                    } 
                } 
            %>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>
