package org.techhub.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import org.techhub.model.ActorModel;
import org.techhub.model.GenreMasterModel;
import org.techhub.model.MovieMasterModel;




@Repository("actorRepo")
public class ActorRepositoryImpl implements ActorRepository{

	@Autowired
	JdbcTemplate template;
	
	List<ActorModel> list;
	
	@Override
	public boolean isAddNewGenre(ActorModel model) {
		 String sql = "INSERT INTO actor (act_name) VALUES (?)";
	        int result = template.update(sql, model.getActName());
	        return result > 0;
	}

	@Override
	public List<ActorModel> getAllActors() {
		 String sql = "SELECT * FROM actor";
	        return template.query(sql, new RowMapper<ActorModel>() {
	            @Override
	            public ActorModel mapRow(ResultSet rs, int rowNum) throws SQLException {
	            	ActorModel gm = new ActorModel();
	                gm.setActId(rs.getInt(1)); 
	                gm.setActName(rs.getString(2)); 
	                return gm;
	            }
	        });
	}

	 @Override
	    public void isDeleteActorById(int aid) {
	        try {
	            template.update("DELETE FROM actor WHERE act_id=?", aid);
	        } catch (DataAccessException e) {
	            throw new RuntimeException("Error deleting actor", e);
	        }
	    }

	    @Override
	    public List<ActorModel> searchActors(String actName) {
	        StringBuilder sql = new StringBuilder("SELECT act_id, act_name FROM actor WHERE 1=1");
	        List<Object> params = new ArrayList<>();
	        
	        if (actName != null && !actName.isEmpty()) {
	            sql.append(" AND act_name LIKE ?");
	            params.add("%" + actName + "%");
	        }
	        
	        sql.append(" ORDER BY act_id");
	        
	        return template.query(sql.toString(), params.toArray(), new ActorRowMapper());
	    }

	    private static class ActorRowMapper implements RowMapper<ActorModel> {
	        @Override
	        public ActorModel mapRow(ResultSet rs, int rowNum) throws SQLException {
	            ActorModel actor = new ActorModel();
	            actor.setActId(rs.getInt("act_id"));
	            actor.setActName(rs.getString("act_name"));
	            return actor;
	        }
	    }

	    @Override
	    public ActorModel getActorById(int actId) {
	        String sql = "SELECT act_id AS actorId, act_name AS actorName FROM actor WHERE act_id = ?";
	        return template.queryForObject(sql, new Object[]{actId}, (rs, rowNum) -> {
	            ActorModel actor = new ActorModel();
	            actor.setActId(rs.getInt("actorId"));        
	            actor.setActName(rs.getString("actorName"));
	            return actor;
	        });
	    }

	    @Override
	    public void updateActor(ActorModel actor) {
	        String updateSql = "UPDATE actor SET act_name = ? WHERE act_id = ?";
	        template.update(updateSql, actor.getActName(), actor.getActId());
	    }

}
