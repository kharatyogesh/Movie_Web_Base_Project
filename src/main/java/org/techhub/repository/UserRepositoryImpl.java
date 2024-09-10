package org.techhub.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import org.techhub.model.GenreMasterModel;
import org.techhub.model.UserModel;

@Repository("userRepo")
public class UserRepositoryImpl implements UserRepository {

	@Autowired
	JdbcTemplate template;
	
	List<GenreMasterModel> list;

	 @Override
	    public UserModel validateUser(UserModel umodel) 
	    {
	        String sql = "select * from usermaster where u_name = ? and password = ?";
	        List<UserModel> userList = template.query(sql, new Object[]{umodel.getUsername(), umodel.getPassword()},
	                new RowMapper<UserModel>() {
	                    @Override
	                    public UserModel mapRow(final ResultSet rs, final int rowNum) throws SQLException {
	                         UserModel model = new UserModel();
	                         model.setUserId(rs.getInt(1));
	                         model.setContact(rs.getString(2));
	                         model.setUsername(rs.getString(3));
	                         model.setCity(rs.getString(4));
	                         model.setPassword(rs.getString(5));
	                       
	                        return model;
	                    }
	                });

	        return userList.isEmpty() ? null : userList.get(0);
	    }

	 @Override
	    public boolean updatePassword(String username, String currentPassword, String newPassword) {
	        
	        String checkPasswordSql = "select count(*) from usermaster where u_name = ? and password = ?";
	        Integer count = template.queryForObject(checkPasswordSql, new Object[]{username, currentPassword}, Integer.class);

	        if (count != null && count > 0) {
	         
	            String updatePasswordSql = "update usermaster set password = ? where u_name = ?";
	            int rowsAffected = template.update(updatePasswordSql, newPassword, username);
	            return rowsAffected > 0;
	        }

	     
	        return false;
	    }

	 @Override
	    public boolean saveUser(UserModel user) {
	        String insertUserSql = "insert into usermaster (contact, u_name, city, password) values (?, ?, ?, ?)";
	        int rowsAffected = template.update(insertUserSql, user.getContact(), user.getUsername(), user.getCity(), user.getPassword());
	        return rowsAffected > 0;
	    }
	 @Override
	    public UserModel getUserByUsernameAndPassword(String username, String password) {
	        String sql = "select * from usermaster where u_name = ? and password = ?";
	        try {
	            return template.queryForObject(sql, new Object[]{username, password}, userRowMapper);
	        } catch (EmptyResultDataAccessException e) {
	         
	            return null;
	        }
	    }

	    private RowMapper<UserModel> userRowMapper = (rs, rowNum) -> {
	        UserModel user = new UserModel();
	        user.setUsername(rs.getString("u_name"));
	        user.setPassword(rs.getString("password")); 
	        return user;
	    };
	

	
}
