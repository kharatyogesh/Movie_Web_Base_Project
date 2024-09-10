package org.techhub.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.techhub.model.ActorModel;
import org.techhub.model.AdminModel;
import org.techhub.model.GenreMasterModel;
import org.techhub.model.MovieDetail;
import org.techhub.model.MovieMasterModel;
import org.techhub.model.RatingModel;
import org.techhub.model.UserModel;
import org.techhub.service.ActorService;
import org.techhub.service.GenreService;
import org.techhub.service.MovieService;
import org.techhub.service.RatingService;
import org.techhub.service.UserService;
import org.techhub.service.ValidateAdminService;

@Controller
public class MyController {
	@Autowired
	ValidateAdminService validateService;

	@Autowired
	MovieService movieService;

	@Autowired
	GenreService genreService;

	@Autowired
	ActorService actorService;

	@Autowired
	UserService userService;

	@Autowired
	RatingService ratingService;

	@RequestMapping("/")
	public String myHomePage() {
		return "welcome";
	}

	@RequestMapping("/log")
	public String loginPage() {
		return "login";
	}
	
	@RequestMapping("/home")
	public String BackToHomePage() {
		return "welcome";
	}

//
//	@RequestMapping(value = "/view", method = RequestMethod.POST)
//	public String isValidate(@ModelAttribute("adminModel") AdminModel model, Map<String, Object> map,
//			HttpSession session) {
//		if (model != null) {
//			AdminModel validatedAdmin = validateService.isValidateAdmin(model);
//
//			if (validatedAdmin != null) {
//				session.setAttribute("loggedInAdmin", validatedAdmin);
//				return "superadmin";
//			} else {
//				map.put("msg", "Login failed. Please check your credentials.");
//				return "login";
//			}
//		} else {
//			map.put("msg", "No data received. Please fill in the login form.");
//			return "login";
//		}
//	}

	@RequestMapping(value = "/adminLogin", method = RequestMethod.POST)
	public String adminLogin(@ModelAttribute("adminModel") AdminModel model, HttpSession session, Map<String, Object> map) {
	    AdminModel validatedAdmin = validateService.isValidateAdmin(model);
	    if (validatedAdmin != null) {
	        session.setAttribute("loggedInAdmin", validatedAdmin);
	        return "superadmin";  
	    } else {	       
	        map.put("msg", "Invalid username or password.");
	        return "login"; 
	    }
	}


	@GetMapping("/adminLogin")
	public String showAdminLoginPage() {
	    return "adminLogin";
	}

	@GetMapping("/adminLogout")
	public String logoutAdmin(HttpSession session) {
		session.invalidate();
		System.out.println("logout.....");
		return "welcome";
	}
	
   
	    
	    @PostMapping("/updateAdminPassword")
	    public String updateAdminPassword(@RequestParam("currentPassword") String currentPassword,
	                                      @RequestParam("newPassword") String newPassword,
	                                      @RequestParam("confirmPassword") String confirmPassword,
	                                      Model model, RedirectAttributes redirectAttributes) {
	     
	        AdminModel loggedInAdmin = validateService.getLoggedInAdmin();

	     
	        if (!validateService.checkPassword(loggedInAdmin, currentPassword)) {
	            redirectAttributes.addFlashAttribute("error", "Current password is incorrect.");
	            return "superadmin";  
	        }

	    
	        if (!newPassword.equals(confirmPassword)) {
	            redirectAttributes.addFlashAttribute("error", "New password and confirm password do not match.");
	            return "superadmin";
	        }


	        validateService.updatePassword(loggedInAdmin, newPassword);
	        redirectAttributes.addFlashAttribute("success", "Password updated successfully.");

	        return "welcome";
	    }
	

	
	
	@RequestMapping(value = "/fetchmovies", method = RequestMethod.GET)
	public String viewAllMovies(Map<String, Object> map) {
		List<MovieMasterModel> list = movieService.getMovieList();
		map.put("movies", list);
		return "viewmovie";
	}

	@RequestMapping(value = "/fetchGenre", method = RequestMethod.GET)
	public String viewAllGenre(Map<String, Object> map) {
		List<GenreMasterModel> list = genreService.getAllGenres();

		map.put("record", list);
		return "viewgenre";
	}

	@RequestMapping(value = "/fetchActor", method = RequestMethod.GET)
	public String viewAllActors(Map<String, Object> map) {
		List<ActorModel> list = actorService.getAllActors();

		map.put("actors", list);
		return "viewactor";
	}

	@RequestMapping("/genre")
	public String genreAdd() {
		return "addgenre";

	}

	@RequestMapping("/saveGenre")
	public String saveGenreData(GenreMasterModel model, Map<String, Object> map) {
		boolean b = genreService.isAddNewGenre(model);

		if (b) {

			List<GenreMasterModel> list = genreService.getAllGenres();

			map.put("record", list);
			return "genre";
		} else {
			System.out.println("Genre not added");
			return "superadmin";
		}
	}

	@RequestMapping("/deleteGenre")
	public String deleteGenreById(@RequestParam("genid") Integer genid, Map<String, Object> map) {
	    if (genid == null) {
	        throw new IllegalArgumentException("Genre ID cannot be null");
	    }
	    
	    genreService.isDeleteGenreById(genid);
	    List<GenreMasterModel> list = genreService.getAllGenres();
	    map.put("record", list);
	    return "genre";
	}



	@RequestMapping("/delMovById")
	public String deleteMovieById(@RequestParam("movieId") Integer movieId, Map<String, Object> map) {

		movieService.isDeleteMovieById(movieId);
		List<MovieMasterModel> list = movieService.getMovieList();

		map.put("movies", list);
		return "redirect:/searchMovie";

	}

	@GetMapping("/searchMovie")
	public String searchMovie(@RequestParam(value = "movieTitle", required = false) String movieTitle,
			@RequestParam(value = "movieGenre", required = false) String movieGenre,
			@RequestParam(value = "yearFrom", required = false) String yearFrom,
			@RequestParam(value = "yearTo", required = false) String yearTo,
			@RequestParam(value = "movieActor", required = false) String movieActor, Model model,
			Map<String, Object> map) {

		List<MovieMasterModel> movieList = movieService.searchMovies(movieTitle, movieGenre, yearFrom, yearTo,
				movieActor);
		System.out.println("Search results: " + movieList);

		model.addAttribute("movieList", movieList);
		return "demo";
	}

	@GetMapping("/updateMoviePage")
	public String updateMoviePage(@RequestParam("movieId") int movieId, Model model) {
		MovieMasterModel movie = movieService.getMovieById(movieId);
		model.addAttribute("movie", movie);
		return "updateMovie";
	}

	@RequestMapping(value = "/updateMovie", method = RequestMethod.POST)
	public String updateMovie(@ModelAttribute("movie") MovieMasterModel movie, RedirectAttributes redirectAttributes) {
		movieService.updateMovie(movie);
		redirectAttributes.addFlashAttribute("successMessage", "Movie updated successfully!");

		return "redirect:/searchMovie";
	}



	@GetMapping("/searchGenre")
	public String searchGenre(@RequestParam(value = "genName", required = false) String genName, Model model) {
	    List<GenreMasterModel> genreList = genreService.searchGenres(genName);
	    System.out.println("Search results: " + genreList); // Debug output

	    model.addAttribute("genreList", genreList);
	    return "genre";
	}

	@GetMapping("/updateGenrePage")
	public String updateGenrePage(@RequestParam("genId") int genId, Model model) {
	    GenreMasterModel genre = genreService.getGenreById(genId);
	    model.addAttribute("genre", genre);
	    return "UpdateGenre"; // Ensure this matches your JSP view name
	}

	@RequestMapping(value = "/updateGenre", method = RequestMethod.POST)
	public String updateGenre(@ModelAttribute("genre") GenreMasterModel genre, RedirectAttributes redirectAttributes) {
	    genreService.updateGenre(genre);
	    redirectAttributes.addFlashAttribute("successMessage", "Genre updated successfully!");

	    return "redirect:/searchGenre";
	}


	@RequestMapping("/add")
	public String movieAdd(Map<String, Object> map) {
		List<GenreMasterModel> list = genreService.getAllGenres();
		
		
		if (list != null && !list.isEmpty()) {
			map.put("genres", list);
		} else {
			System.out.println("No genres found");
		}
		
		Integer maxMovieId = movieService.getMaxMovieId();
	    map.put("maxMovieId", maxMovieId);
		
		return "AddMovie";
	}

	@RequestMapping("/save")
	public String saveData(MovieMasterModel model, Model mod) {
	    // Check if the movie release date is null or empty
	    if (model.getMovDate() == null || model.getMovDate().isEmpty()) {
	        return "AddMovie";
	    }

	    // Regular expression to check for only spaces
	    String onlySpacesPattern = "^\\s*$";

	    // Check if the movie title or actor name is empty or contains only spaces
	    if (model.getMovTitle().matches(onlySpacesPattern) || model.getActName().matches(onlySpacesPattern)) {
	        mod.addAttribute("errorMessage", "Movie Name and Actor fields cannot be empty or contain only spaces.");
	        return "AddMovie";
	    }

	    boolean result = movieService.isAddNewMovie(model);

	    if (result) {
	        return "AddMovie";
	    } else {
	        return "demo";
	    }
	}


	@RequestMapping("/addA")
	public String ActorAdd() {
		return "addactor";

	}

	@RequestMapping("/saveActor")
	public String saveActorData(ActorModel model, Map<String, Object> map) {
		boolean b = actorService.isAddNewActor(model);
		if (b) {
			List<ActorModel> list = actorService.getAllActors();
			map.put("record", list);
			return "actor";
		} else {
			System.out.println("Actor not added");
			return "superadmin";
		}
	}

	 @RequestMapping("/deleteActor")
	    public String deleteActorById(@RequestParam("actid") Integer actid, RedirectAttributes redirectAttributes) {
	        try {
	            actorService.isDeleteActorById(actid);
	            redirectAttributes.addFlashAttribute("successMessage", "Actor deleted successfully!");
	        } catch (Exception e) {
	            redirectAttributes.addFlashAttribute("errorMessage", "Error deleting actor!");
	        }
	        return "redirect:/searchActor";
	    }

	    @GetMapping("/searchActor")
	    public String searchActor(@RequestParam(value = "actName", required = false) String actName, Model model) {
	        List<ActorModel> actorList = actorService.searchActors(actName);
	        model.addAttribute("actorList", actorList);
	        return "actor";
	    }

	    @GetMapping("/updateActorPage")
	    public String updateActorPage(@RequestParam("actId") int actId, Model model) {
	        ActorModel actor = actorService.getActorById(actId);
	        model.addAttribute("actor", actor);
	        return "UpdateActor";
	    }

	    @PostMapping("/updateActor")
	    public String updateActor(@ModelAttribute("actor") ActorModel actor, RedirectAttributes redirectAttributes) {
	        try {
	            actorService.updateActor(actor);
	            redirectAttributes.addFlashAttribute("successMessage", "Actor updated successfully!");
	        } catch (Exception e) {
	            redirectAttributes.addFlashAttribute("errorMessage", "Error updating actor!");
	        }
	        return "redirect:/searchActor";
	    }
	

//	@PostMapping("/userLogin")
//	public String userLogin(@RequestParam("username") String username, @RequestParam("password") String password,
//			Model model, HttpSession session) {
//		boolean userExists = userService.validateUser(username, password);
//		if (userExists) {
//			session.setAttribute("username", username);
//			System.out.println("User logged in: " + username);
//			return "userlogin";
//		} else {
//			model.addAttribute("error", "Invalid username or password.");
//			System.out.println("Login failed for user: " + username);
//			return "welcome";
//		}
//	}
//	@RequestMapping("/userdashboard")
//	public String userDashboardPage(HttpSession session, Model model) {
//		String username = (String) session.getAttribute("username");
//		if (username == null) {
//			System.out.println("No username found in session. Redirecting to login.");
//			return "redirect:/userlogin";
//		}
//		model.addAttribute("username", username);
//		System.out.println("Username found in session: " + username);
//		return "userDashboard";
//	}
//	
	
	@RequestMapping("/userdashboard")
	public String userDashboardPage(HttpSession session, Model model) {
	    
	    UserModel user = (UserModel) session.getAttribute("user");
	    
	    if (user == null) {
	        System.out.println("No user found in session. Redirecting to login.");
	        return "redirect:/userlogin";
	    }
	    
	  
	    String username = user.getUsername();  
	    model.addAttribute("username", username);
	    System.out.println("Username found in session: " + username);
	    
	  
	    return "userDashboard";
	}

	
	
	@PostMapping("/userLogin")
	public String userLogin(UserModel umodel,  Map<String, Object> map,HttpServletRequest request) {
		
		 HttpSession session = request.getSession(true);
         session.setAttribute("Login", umodel);
		
		
		UserModel userExists = userService.validateUser(umodel);
		if (userExists!=null) {
		    session = request.getSession();
            session.setAttribute("user", userExists);
            map.put("message", "Login successful!");
          
			return "userlogin";
		} else {
			  map.put("message", "Invalid username or password. Please try again.");
	          
		
			return "welcome";
		}
	}
	@GetMapping("/userlogin")
	public String showLoginPage() {
		return "userlogin";
	}

	@PostMapping("/updatePassword")
	public ModelAndView updatePassword(@RequestParam("currentPassword") String currentPassword,
	                                   @RequestParam("newPassword") String newPassword,
	                                   @RequestParam("confirmPassword") String confirmPassword,
	                                   HttpSession session) {
	    
	    UserModel user = (UserModel) session.getAttribute("user");	   
	    if (user == null) {
	        return new ModelAndView("redirect:/userlogin");
	    }
	    String username = user.getUsername(); 
	    if (!newPassword.equals(confirmPassword)) {
	        return new ModelAndView("userDashboard", "error", "New password and confirm password do not match.");
	    }	
	    boolean isUpdated = userService.updatePassword(username, currentPassword, newPassword);

	
	    if (isUpdated) {
	        return new ModelAndView("userlogin", "message", "Password updated successfully.");
	    } else {
	        return new ModelAndView("userDashboard", "error", "Failed to update password. Please check your current password.");
	    }
	}


	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		System.out.println("logout.....");
		return "welcome";
	}

	@RequestMapping("/userRegister")
	public String showRegistrationForm() {
		return "register";
	}

	@RequestMapping(value = "/saveUser", method = RequestMethod.POST)
	public String saveUser(@RequestParam("contact") String contact, @RequestParam("u_name") String username,
			@RequestParam("city") String city, @RequestParam("password") String password, Model model) {

		UserModel user = new UserModel();
		user.setContact(contact);
		user.setUsername(username);
		user.setCity(city);
		user.setPassword(password);

		boolean result = userService.saveUser(user);

		if (result) {
			return "welcome";
		} else {

			model.addAttribute("error", "Registration failed. Please try again.");
			return "register";
		}
	}


	@GetMapping("/login")
	public String showLoginPage1() {
	    return "login";
	}


	@PostMapping("/submitRating")
	public String submitRating(
			@RequestParam("userId") int userId,
	        @RequestParam("movieId") int movieId,
	        @RequestParam("rating") int rating,
	        @RequestParam("review") String review,
	        HttpSession session) {
		
		System.out.println(userId);
		System.out.println(movieId);
		System.out.println(rating);
		System.out.println(review);
//
//	    // Check if the user is in the session
//	    UserModel user = (UserModel) session.getAttribute("loggedInUser");
//	    
//	    if (user == null) {
//	     
//	        return "userDashboard"; 
//	    }

	
	    RatingModel ratingObj = new RatingModel();
	    ratingObj.setMovId(movieId);
	    ratingObj.setuId(userId); 
	    ratingObj.setRating(rating);
	    ratingObj.setText(review);

	    ratingService.saveRating(ratingObj); 

	    System.out.println(ratingObj.getMovId());
	    return "userDashboard"; 
	}
	@GetMapping("/getMovieId")
	@ResponseBody
	public int getMovieIdByName(@RequestParam("movieName") String movieName) {
	 
	    MovieMasterModel movie = movieService.findByName(movieName);
	    return movie != null ? movie.getMovieId() : -1; 
	}


	@RequestMapping(value = "/watchedMovies", method = RequestMethod.GET)
    public String getWatchedMoviesByUser(HttpSession session, Model model) {
        UserModel user = (UserModel) session.getAttribute("user");
        if (user != null) {
            List<MovieMasterModel> watchedMovies = movieService.getWatchedMoviesByUser(user.getUserId());
            model.addAttribute("watchedMovies", watchedMovies);
        }
        return "watchedMovies";
    }
	
	@RequestMapping("/recommendations")
	public String getTopRatedMovies(Model model) {
	  
	    List<MovieDetail> topRatedMovies = movieService.getTopRatedMovies();
	    
	   
	    System.out.println("Top Rated Movies:");
	    System.out.println("------------------------------------------------------");
	    for (MovieDetail movie : topRatedMovies) {
	        System.out.println("Movie Name: " + movie.getMovie().getMovTitle());
	        System.out.println("Genre: " + movie.getGenre().getGenName());
	        System.out.println("Actor: " + movie.getActor().getActName());
	        System.out.println("Release Year: " + movie.getMovie().getMovDate());
	        System.out.println("Overall Rating: " + movie.getOverallRating());
	        System.out.println("------------------------------------------------------");
	    }
	    
	    
	    
	    model.addAttribute("topRatedMovies", topRatedMovies);

	    
	    return "recommendations"; 
	}


}
