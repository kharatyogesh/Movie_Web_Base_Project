<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.techhub.model.MovieDetail" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recommended Movies</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <style>
        .card {
            border-radius: 20px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
        }
        .card-img-top {
            border-radius: 20px;
            height: 400px;
            object-fit: cover;
            padding: 10px;
        }
    </style>
</head>
<body>
    <div class="container-fluid mt-5" style="background-color: #f0f0f0;">
        <h1 class="text-center mb-4">Recommended Movies</h1>

        <div class="row">
            <%
                List<MovieDetail> topRatedMovies = (List<MovieDetail>) request.getAttribute("topRatedMovies");
                if (topRatedMovies != null) {
                    for (MovieDetail movie : topRatedMovies) {
                        String movieId = String.valueOf(movie.getMovie().getMovieId());
                        String movieTitle = movie.getMovie().getMovTitle();
                        String imageUrl = request.getContextPath() + "/resources/images/" + movieTitle.replaceAll(" ", "").toLowerCase() + ".jpg";
                       
                        float rating = movie.getOverallRating();
            %>
                <div class="col-6 col-md-3 mb-3">
                    <div class="card">
                        <a href="clickMovie?id=<%= movieId %>">
                            <img src="<%= imageUrl %>" class="card-img-top" alt="<%= movieTitle %>">
                        </a>
                        <div class="card-body text-center">
                            <h5 class="card-title"><%= rating %></h5>
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
