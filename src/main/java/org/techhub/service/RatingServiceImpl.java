package org.techhub.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.techhub.model.RatingModel;
import org.techhub.repository.RatingRepository;


@Service("ratingService")
public class RatingServiceImpl implements RatingService {

	@Autowired
	RatingRepository ratingRepo;


    public void saveRating(RatingModel rating) {
    	ratingRepo.saveRating(rating); 
    }
}
