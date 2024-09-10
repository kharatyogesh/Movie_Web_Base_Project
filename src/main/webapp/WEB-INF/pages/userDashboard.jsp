<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="org.techhub.model.UserModel"%>

<%
UserModel umodel = (UserModel) session.getAttribute("user");
%>
<!DOCTYPE html>

<html>
<head>
    <meta charset="UTF-8">
    <title>Movie Carousel Example</title>

    <!-- Bootstrap CSS -->
    <link
        href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
        rel="stylesheet">
         <!-- Bootstrap CSS -->
  <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

  <!-- jQuery -->
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>

  <!-- Bootstrap JS -->
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        /* General Styles */
        body {
            background-color: #f8f9fa;
            padding: 20px;
        }

        h2 {
            margin-top: 40px;
            margin-bottom: 20px;
            font-weight: bold;
            color: #343a40;
        }

        /* Main Carousel Styles */
        .main-carousel .carousel-item img {
            width: 100%;
            height: 500px;
            object-fit: cover;
            border-radius: 10px;
        }

        .main-carousel .carousel-caption {
            background-color: rgba(0, 0, 0, 0.7);
            padding: 15px;
            border-radius: 10px;
        }

        .main-carousel .carousel-caption .rating {
            font-size: 1.5rem;
            color: #ffd700;
            margin-bottom: 10px;
        }

        .main-carousel .carousel-caption .watch-button {
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 20px;
            padding: 10px 20px;
            font-size: 1rem;
            transition: background-color 0.3s ease;
        }

        .main-carousel .carousel-caption .watch-button:hover {
            background-color: #0056b3;
        }

        /* Movie Carousel Styles */
        .movie-carousel .carousel-item {
            padding: 20px 0;
        }

        .movie-carousel .movie-item {
            text-align: center;
            padding: 2px;
            
            transition: transform 0.3s;
        }

        .movie-carousel .movie-item:hover {
            transform: scale(1.05);
        }

        .movie-carousel .movie-poster {
            width: 100%;
            height: 250px;
            object-fit: cover;
            border-radius: 10px;
            margin-bottom: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
        }

        .movie-carousel .movie-name {
            font-size: 1.1rem;
            font-weight: bold;
            color: #343a40;
            margin-bottom: 5px;
        }

        .movie-carousel .rating {
            font-size: 1.5rem;
            color: #ffd700;
            margin-bottom: 10px;
        }

        .movie-carousel .watch-button {
            background-color:  #007bff;;
            color: #fff;
            border: none;
            border-radius: 20px;
            padding: 5px 15px;
            font-size: 0.9rem;
            transition: background-color 0.3s ease;
        }

        .movie-carousel .watch-button:hover {
            background-color: red;
        }

        /* Modal Styles */
        .modal-header {
            border-bottom: none;
        }

        .modal-footer {
            border-top: none;
        }

        .login-modal .form-control {
            border-radius: 20px;
        }

        .login-modal .btn-login {
            background-color: #007bff;
            color: #fff;
            border-radius: 20px;
            padding: 10px 20px;
            font-size: 1rem;
            border: none;
        }

        .login-modal .btn-login:hover {
            background-color: #0056b3;
        }

    </style>
</head>
<body>



<!-- Main Carousel -->
<div id="mainCarousel" class="carousel slide main-carousel" data-ride="carousel">
    <ol class="carousel-indicators">
        <li data-target="#mainCarousel" data-slide-to="0" class="active"></li>
        <li data-target="#mainCarousel" data-slide-to="1"></li>
        <li data-target="#mainCarousel" data-slide-to="2"></li>
    </ol>
    <div class="carousel-inner">
        <!-- Carousel Item 1 -->
        <div class="carousel-item active">
            <img src="resources/images/rockstar.jpg" class="d-block w-100" alt="Rockstar">
            <div class="carousel-caption d-none d-md-block">
                <h5>Rockstar</h5>
                <div class="rating">★★★★☆</div>
                <button class="btn watch-button" data-movie-id="1" data-movie-name="Rockstar" data-user-id="123">Watch</button>
            </div>
        </div>
        <!-- Carousel Item 2 -->
        <div class="carousel-item">
            <img src="resources/images/chennaiexpress.jpg" class="d-block w-100" alt="Chennai Express">
            <div class="carousel-caption d-none d-md-block">
                <h5>Chennai Express</h5>
                <div class="rating">★★★☆☆</div>
                <button class="btn watch-button" data-movie-id="2" data-movie-name="Chennai Express" data-user-id="123">Watch</button>
            </div>
        </div>
        <!-- Carousel Item 3 -->
        <div class="carousel-item">
            <img src="resources/images/kgf.jpg" class="d-block w-100" alt="KGF">
            <div class="carousel-caption d-none d-md-block">
                <h5>kgf-2</h5>
                <div class="rating">★★★★★</div>
                <button class="btn watch-button" data-movie-id="3" data-movie-name="kgf-2" data-user-id="123">Watch</button>
            </div>
        </div>
    </div>
    <a class="carousel-control-prev" href="#mainCarousel" role="button" data-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
    </a>
    <a class="carousel-control-next" href="#mainCarousel" role="button" data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
    </a>
</div>


    <!-- Recommended Movies Section -->
    <h2>Recommended Movies</h2>
    <div id="recommendedCarousel" style="background-color:lightblue"  class="carousel slide movie-carousel" data-ride="carousel">
        <div class="carousel-inner">
            <!-- Carousel Slide 1 -->
            <div class="carousel-item active">
                <div class="row">
                    <div class="col-md-2 col-sm-4 col-6">
                        <div class="movie-item">
                            <img src="resources/images/war.jpg" class="movie-poster" alt="War">
                            <div class="movie-name">War</div>
                            <div class="rating">★★★★☆</div>
                <button class="btn watch-button" data-movie-id="4" data-movie-name="War" data-user-id="123">Watch</button>
                        </div>
                    </div>
                    <div class="col-md-2 col-sm-4 col-6">
                        <div class="movie-item">
                            <img src="resources/images/kala.jpg" class="movie-poster" alt="Kala">
                            <div class="movie-name">Kala</div>
                            <div class="rating">★★★☆☆</div>
                <button class="btn watch-button" data-movie-id="5" data-movie-name="Kala" data-user-id="123">Watch</button>
                        </div>
                    </div>
                    <div class="col-md-2 col-sm-4 col-6">
                        <div class="movie-item">
                            <img src="resources/images/kgf.jpg" class="movie-poster" alt="KGF">
                            <div class="movie-name">Kgf-2</div>
                            <div class="rating">★★★★★</div>
                <button class="btn watch-button" data-movie-id="3" data-movie-name="kgf-2" data-user-id="123">Watch</button>
                        </div>
                    </div>
                    <div class="col-md-2 col-sm-4 col-6">
                        <div class="movie-item">
                            <img src="resources/images/chennaiexpress.jpg" class="movie-poster" alt="Chennai Express">
                            <div class="movie-name">ChennaiExpress</div>
                            <div class="rating">★★★☆☆</div>
                <button class="btn watch-button" data-movie-id="2" data-movie-name="ChennaiExpress" data-user-id="123">Watch</button>
                        </div>
                    </div>
                    <div class="col-md-2 col-sm-4 col-6">
                        <div class="movie-item">
                            <img src="resources/images/bhola.jpg" class="movie-poster" alt="Thor">
                            <div class="movie-name">Bhola</div>
                            <div class="rating">★★★★★</div>
                		<button class="btn watch-button" data-movie-id="6" data-movie-name="Bhola" data-user-id="123">Watch</button>
                        </div>
                    </div>
                    <div class="col-md-2 col-sm-4 col-6">
                        <div class="movie-item">
                            <img src="resources/images/Kalki.jpg" class="movie-poster" alt="Avengers">
                            <div class="movie-name">Kalki</div>
                            <div class="rating">★★★★★</div>
                		<button class="btn watch-button" data-movie-id="16" data-movie-name="Kalki" data-user-id="123">Watch</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Carousel Slide 2 -->
            <div class="carousel-item">
                <div class="row">
                    <div class="col-md-2 col-sm-4 col-6">
                        <div class="movie-item">
                            <img src="resources/images/bhola.jpg" class="movie-poster" alt="Inception">
                            <div class="movie-name">Inception</div>
                            <div class="rating">★★★★★</div>
                            <button class="btn watch-button" data-movie="Inception">Watch</button>
                        </div>
                    </div>
                     <div class="col-md-2 col-sm-4 col-6">
                        <div class="movie-item">
                            <img src="resources/images/bhola.jpg" class="movie-poster" alt="Inception">
                            <div class="movie-name">Inception</div>
                            <div class="rating">★★★★★</div>
                            <button class="btn watch-button" data-movie="Inception">Watch</button>
                        </div>
                    </div>
                     <div class="col-md-2 col-sm-4 col-6">
                        <div class="movie-item">
                            <img src="resources/images/bhola.jpg" class="movie-poster" alt="Inception">
                            <div class="movie-name">Inception</div>
                            <div class="rating">★★★★★</div>
                            <button class="btn watch-button" data-movie="Inception">Watch</button>
                        </div>
                    </div>
                     <div class="col-md-2 col-sm-4 col-6">
                        <div class="movie-item">
                            <img src="resources/images/bhola.jpg" class="movie-poster" alt="Inception">
                            <div class="movie-name">Inception</div>
                            <div class="rating">★★★★★</div>
                            <button class="btn watch-button" data-movie="Inception">Watch</button>
                        </div>
                    </div>
                     <div class="col-md-2 col-sm-4 col-6">
                        <div class="movie-item">
                            <img src="resources/images/bhola.jpg" class="movie-poster" alt="Inception">
                            <div class="movie-name">Inception</div>
                            <div class="rating">★★★★★</div>
                            <button class="btn watch-button" data-movie="Inception">Watch</button>
                        </div>
                    </div>
                     <div class="col-md-2 col-sm-4 col-6">
                        <div class="movie-item">
                            <img src="resources/images/bhola.jpg" class="movie-poster" alt="Inception">
                            <div class="movie-name">Inception</div>
                            <div class="rating">★★★★★</div>
                            <button class="btn watch-button" data-movie="Inception">Watch</button>
                        </div>
                    </div>
                    <!-- Add more movie items as needed -->
                </div>
            </div>
        </div>
        <a class="carousel-control-prev" href="#recommendedCarousel" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon bg-dark rounded-circle p-3" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next" href="#recommendedCarousel" role="button" data-slide="next">
            <span class="carousel-control-next-icon bg-dark rounded-circle p-3" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>
    <h2>Horror Movies</h2>
<div id="horrorCarousel" style="background-color:lightblue" class="carousel slide movie-carousel" data-ride="carousel">
    <div class="carousel-inner">
        <!-- Carousel Slide 1 -->
        <div class="carousel-item active">
            <div class="row">
                <div class="col-md-2 col-sm-4 col-6">
                    <div class="movie-item">
                        <img src="resources/images/bhoot.jpg" class="movie-poster" alt="The Conjuring">
                        <div class="movie-name">Bhoot</div>
                        <div class="rating">★★★★★</div>
                		<button class="btn watch-button" data-movie-id="7" data-movie-name="Bhoot" data-user-id="123">Watch</button>
                    </div>
                </div>
                <div class="col-md-2 col-sm-4 col-6">
                    <div class="movie-item">
                        <img src="resources/images/theconjuring.jpg" class="movie-poster" alt="Insidious">
                        <div class="movie-name">The Conjuring</div>
                        <div class="rating">★★★★☆</div>
                		<button class="btn watch-button" data-movie-id="8" data-movie-name="The Conjuring" data-user-id="123">Watch</button>
                    </div>
                </div>
                <div class="col-md-2 col-sm-4 col-6">
                    <div class="movie-item">
                        <img src="resources/images/28dayalater.jpg" class="movie-poster" alt="Annabelle">
                        <div class="movie-name">28-Days-Later</div>
                        <div class="rating">★★★☆☆</div>
                		<button class="btn watch-button" data-movie-id="9" data-movie-name="28-Days-Later" data-user-id="123">Watch</button>
                    </div>
                </div>
                <div class="col-md-2 col-sm-4 col-6">
                    <div class="movie-item">
                        <img src="resources/images/theexorcist.jpg" class="movie-poster" alt="It">
                        <div class="movie-name">The Exorcist</div>
                        <div class="rating">★★★★★</div>
                		<button class="btn watch-button" data-movie-id="10" data-movie-name="The Exorcist" data-user-id="123">Watch</button>
                    </div>
                </div>
                <div class="col-md-2 col-sm-4 col-6">
                    <div class="movie-item">
                        <img src="resources/images/it.jpg" class="movie-poster" alt="Hereditary">
                        <div class="movie-name">It</div>
                        <div class="rating">★★★★☆</div>
                		<button class="btn watch-button" data-movie-id="11" data-movie-name="It" data-user-id="123">Watch</button>
                    </div>
                </div>
                <div class="col-md-2 col-sm-4 col-6">
                    <div class="movie-item">
                        <img src="resources/images/theshining.jpg" class="movie-poster" alt="Get Out">
                        <div class="movie-name">The Shining</div>
                        <div class="rating">★★★★☆</div>
                		<button class="btn watch-button" data-movie-id="12" data-movie-name="The Shining" data-user-id="123">Watch</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Carousel Slide 2 -->
        <div class="carousel-item">
            <div class="row">
                <div class="col-md-2 col-sm-4 col-6">
                    <div class="movie-item">
                        <img src="resources/images/psycho.jpg" class="movie-poster" alt="A Quiet Place">
                        <div class="movie-name">Psycho</div>
                        <div class="rating">★★★★★</div>
                		<button class="btn watch-button" data-movie-id="13" data-movie-name="Psycho" data-user-id="123">Watch</button>
                    </div>
                </div>
                <div class="col-md-2 col-sm-4 col-6">
                    <div class="movie-item">
                        <img src="resources/images/saw.jpg" class="movie-poster" alt="Psycho">
                        <div class="movie-name">Saw</div>
                        <div class="rating">★★★★★</div>
                		<button class="btn watch-button" data-movie-id="14" data-movie-name="Saw" data-user-id="123">Watch</button>
                    </div>
                </div>
                <div class="col-md-2 col-sm-4 col-6">
                    <div class="movie-item">
                        <img src="resources/images/thering.jpg" class="movie-poster" alt="The Shining">
                        <div class="movie-name">The Ring</div>
                        <div class="rating">★★★★★</div>
                		<button class="btn watch-button" data-movie-id="15" data-movie-name="The Ring" data-user-id="123">Watch</button>
                    </div>
                </div>
                <div class="col-md-2 col-sm-4 col-6">
                    <div class="movie-item">
                        <img src="resources/images/hereditary.jpg" class="movie-poster" alt="Saw">
                        <div class="movie-name">Hereditary</div>
                        <div class="rating">★★★★☆</div>
                		<button class="btn watch-button" data-movie-id="17" data-movie-name="Hereditary" data-user-id="123">Watch</button>
                    </div>
                </div>
                <div class="col-md-2 col-sm-4 col-6">
                    <div class="movie-item">
                        <img src="resources/images/itchaptertwo.jpg" class="movie-poster" alt="Carrie">
                        <div class="movie-name">It Chapter Two</div>
                        <div class="rating">★★★★☆</div>
                		<button class="btn watch-button" data-movie-id="18" data-movie-name="It Chapter Two" data-user-id="123">Watch</button>
                    </div>
                </div>
                <div class="col-md-2 col-sm-4 col-6">
                    <div class="movie-item">
                        <img src="resources/images/us.jpg" class="movie-poster" alt="Us">
                        <div class="movie-name">Us</div>
                        <div class="rating">★★★★☆</div>
                		<button class="btn watch-button" data-movie-id="19" data-movie-name="Us" data-user-id="123">Watch</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <a class="carousel-control-prev" href="#horrorCarousel" role="button" data-slide="prev">
        <span class="carousel-control-prev-icon bg-dark rounded-circle p-3" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
    </a>
    <a class="carousel-control-next" href="#horrorCarousel" role="button" data-slide="next">
        <span class="carousel-control-next-icon bg-dark rounded-circle p-3" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
    </a>
</div>
<h2>Comedy Movies</h2>
<div id="comedyCarousel" style="background-color:lightblue"  class="carousel slide movie-carousel" data-ride="carousel">
    <div class="carousel-inner">
        <!-- Carousel Slide 1 -->
        <div class="carousel-item active">
            <div class="row">
                <div class="col-md-2 col-sm-4 col-6">
                    <div class="movie-item">
                        <img src="resources/images/dhamaal.jpg" class="movie-poster" alt="Superbad">
                        <div class="movie-name">Dhamaal</div>
                        <div class="rating">★★★★☆</div>
                		<button class="btn watch-button" data-movie-id="20" data-movie-name="Dhamaal" data-user-id="123">Watch</button>
                    </div>
                </div>
                <div class="col-md-2 col-sm-4 col-6">
                    <div class="movie-item">
                        <img src="resources/images/3idiots.jpg" class="movie-poster" alt="The Office">
                        <div class="movie-name">3 idiots</div>
                        <div class="rating">★★★★★</div>
                		<button class="btn watch-button" data-movie-id="21" data-movie-name="3 idiots" data-user-id="123">Watch</button>
                    </div>
                </div>
                <div class="col-md-2 col-sm-4 col-6">
                    <div class="movie-item">
                        <img src="resources/images/herapheri.jpg" class="movie-poster" alt="Step Brothers">
                        <div class="movie-name">Hera Pheri</div>
                        <div class="rating">★★★★☆</div>
                		<button class="btn watch-button" data-movie-id="22" data-movie-name="Hera Pheri" data-user-id="123">Watch</button>
                    </div>
                </div>
                <div class="col-md-2 col-sm-4 col-6">
                    <div class="movie-item">
                        <img src="resources/images/fukrey.jpg" class="movie-poster" alt="Anchorman">
                        <div class="movie-name">Fukrey</div>
                        <div class="rating">★★★★★</div>
                		<button class="btn watch-button" data-movie-id="23" data-movie-name="Fukrey" data-user-id="123">Watch</button>
                    </div>
                </div>
                <div class="col-md-2 col-sm-4 col-6">
                    <div class="movie-item">
                        <img src="resources/images/pagalpanti.jpg" class="movie-poster" alt="Borat">
                        <div class="movie-name">Pagal Panti</div>
                        <div class="rating">★★★★☆</div>
                		<button class="btn watch-button" data-movie-id="24" data-movie-name="Pagal Panti" data-user-id="123">Watch</button>
                    </div>
                </div>
                <div class="col-md-2 col-sm-4 col-6">
                    <div class="movie-item">
                        <img src="resources/images/welcome.jpg" class="movie-poster" alt="The Hangover">
                        <div class="movie-name">Welcome</div>
                        <div class="rating">★★★★★</div>
                		<button class="btn watch-button" data-movie-id="25" data-movie-name="Welcome" data-user-id="123">Watch</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Carousel Slide 2 -->
        <div class="carousel-item">
            <div class="row">
                <div class="col-md-2 col-sm-4 col-6">
                    <div class="movie-item">
                        <img src="resources/images/bhoolbhulaiya.jpg" class="movie-poster" alt="Dumb and Dumber">
                        <div class="movie-name">Bhool Bhulaiya</div>
                        <div class="rating">★★★★★</div>
                		<button class="btn watch-button" data-movie-id="26" data-movie-name="Bhool Bhulaiya" data-user-id="123">Watch</button>
                    </div>
                </div>
                <div class="col-md-2 col-sm-4 col-6">
                    <div class="movie-item">
                        <img src="resources/images/golmaal.jpg" class="movie-poster" alt="Ted">
                        <div class="movie-name">Golmaal</div>
                        <div class="rating">★★★★☆</div>
                		<button class="btn watch-button" data-movie-id="27" data-movie-name="GolmaaL" data-user-id="123">Watch</button>
                    </div>
                </div>
                <div class="col-md-2 col-sm-4 col-6">
                    <div class="movie-item">
                        <img src="resources/images/thehangover.jpg" class="movie-poster" alt="The 40-Year-Old Virgin">
                        <div class="movie-name">The Hangover</div>
                        <div class="rating">★★★★★</div>
                		<button class="btn watch-button" data-movie-id="28" data-movie-name="The Hangover" data-user-id="123">Watch</button>
                    </div>
                </div>
                <div class="col-md-2 col-sm-4 col-6">
                    <div class="movie-item">
                        <img src="resources/images/borat.jpg" class="movie-poster" alt="Meet the Parents">
                        <div class="movie-name">Borat</div>
                        <div class="rating">★★★★☆</div>
                		<button class="btn watch-button" data-movie-id="29" data-movie-name="Borat" data-user-id="123">Watch</button>
                    </div>
                </div>
                <div class="col-md-2 col-sm-4 col-6">
                    <div class="movie-item">
                        <img src="resources/images/hotfuzz.jpg" class="movie-poster" alt="Zoolander">
                        <div class="movie-name">Hot Fuzz</div>
                        <div class="rating">★★★★☆</div>
                		<button class="btn watch-button" data-movie-id="30" data-movie-name="Hot Fuzz" data-user-id="123">Watch</button>
                    </div>
                </div>
                <div class="col-md-2 col-sm-4 col-6">
                    <div class="movie-item">
                        <img src="resources/images/jojorabbit.jpg" class="movie-poster" alt="Elf">
                        <div class="movie-name">Jojo Rabbit</div>
                        <div class="rating">★★★★★</div>
                		<button class="btn watch-button" data-movie-id="31" data-movie-name="Jojo Rabbit" data-user-id="123">Watch</button>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <a class="carousel-control-prev" href="#comedyCarousel" role="button" data-slide="prev">
        <span class="carousel-control-prev-icon bg-dark rounded-circle p-3" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
    </a>
    <a class="carousel-control-next" href="#comedyCarousel" role="button" data-slide="next">
        <span class="carousel-control-next-icon bg-dark rounded-circle p-3" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
    </a>
</div>

    
<!-- Rating Modal -->
<div class="modal fade" id="ratingModal" tabindex="-1" role="dialog" aria-labelledby="ratingModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="ratingModalLabel">Rate the Movie</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <!-- Action points to the controller URL to handle the form submission -->
        <form action="submitRating" method="post">
          <input type="hidden" id="movieId" name="movieId">
          <div class="form-group">
            <label for="rating">Rating</label>
            <select id="rating" name="rating" class="form-control">
              <option value="1">1</option>
              <option value="2">2</option>
              <option value="3">3</option>
              <option value="4">4</option>
              <option value="5">5</option>
            </select>
          </div>
          <div class="form-group">
            <label for="review">Review</label>
            <textarea id="review" name="review" class="form-control" rows="3"></textarea>
          </div>
           <input type="hidden" value="<%=umodel.getUserId() %>" id="userId" name="userId">
          <button type="submit" class="btn btn-primary" >Submit Rating</button>
        </form>
      </div>
    </div>
  </div>
</div>

<!-- Watch Button on Movie List -->
<button class="btn watch-button" data-movie-id="1">Watch</button>

<script>
  document.querySelectorAll('.watch-button').forEach(button => {
    button.addEventListener('click', function() {
      const movieId = this.getAttribute('data-movie-id');
      document.getElementById('movieId').value = movieId;
      $('#ratingModal').modal('show');
    });
  });
</script>
</body>
</html>