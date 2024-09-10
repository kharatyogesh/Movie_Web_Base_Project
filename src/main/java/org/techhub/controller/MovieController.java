package org.techhub.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.techhub.model.GenreMasterModel;
import org.techhub.model.MovieMasterModel;
import org.techhub.service.GenreService;
import org.techhub.service.MovieService;
import org.techhub.service.ValidateAdminService;

@Controller
public class MovieController {

	@Autowired
	ValidateAdminService validateService;
	
	@Autowired
	MovieService movieService;
	
	@Autowired
	GenreService genreService;
	
//	@RequestMapping("/movieSearch")
//	public String movieAdd(Map<String, Object> map) 
//	{
//		List<GenreMasterModel> list = genreService.getAllGenres();
//	    if (list != null && !list.isEmpty()) {
//	        map.put("genres", list);
//	    } else {
//	        System.out.println("No genres found");
//	    }
//	    return "movies";
//	}
//	
//	
//	@RequestMapping("/searchMovie")
//	public String saveData(MovieMasterModel model) 
//	{
//		boolean b=movieService.isAddNewMovie(model);
//		
//		if(b) 
//		{
//			return "movies";
//		}
//		else 
//		{
//			return "superadmin";
//		}
//	}
	
}
