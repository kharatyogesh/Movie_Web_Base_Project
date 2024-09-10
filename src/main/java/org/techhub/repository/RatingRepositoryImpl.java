package org.techhub.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.techhub.model.RatingModel;

@Repository("ratingRepo")
public class RatingRepositoryImpl implements RatingRepository{

	@Autowired
	JdbcTemplate template;

	
	 @Override
	    public void saveRating(RatingModel rating) {
	        String sql = "insert into rating (rating, text,mov_id,u_id) values (?, ?, ?, ?)";

	        template.update(sql,rating.getRating(),rating.getText(), rating.getMovId(), rating.getuId());
	    }

	
}
