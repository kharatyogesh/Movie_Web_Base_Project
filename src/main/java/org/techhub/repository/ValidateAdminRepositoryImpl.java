package org.techhub.repository;



import java.sql.ResultSet;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import org.techhub.model.AdminModel;


@Repository("regRepo")
public class ValidateAdminRepositoryImpl implements ValidateAdminRepository {

    @Autowired
    private JdbcTemplate template;
    
  


    
    public AdminModel isValidateAdmin(AdminModel model) {
        String sql = "select * from admin where username = ? and password = ?";
        List<AdminModel> list = template.query(sql, new Object[]{model.getUsername(), model.getPassword()},
            new RowMapper<AdminModel>() {
                @Override
                public AdminModel mapRow(ResultSet rs, int rowNum) throws SQLException {
                    AdminModel admin = new AdminModel();
                    admin.setUsername(rs.getString("username"));
                    admin.setPassword(rs.getString("password"));
                    return admin;
                }
            }
        );
        return list.isEmpty() ? null : list.get(0);
    }



 
    @Override
    public AdminModel getLoggedInAdmin() {
       
        String sql = "select * from admin where username = ?"; 
        String loggedInUsername = "admin"; 
        List<AdminModel> list = template.query(sql, new Object[]{loggedInUsername},
            new RowMapper<AdminModel>() {
                @Override
                public AdminModel mapRow(ResultSet rs, int rowNum) throws SQLException {
                    AdminModel admin = new AdminModel();
                    admin.setUsername(rs.getString("username"));
                    admin.setPassword(rs.getString("password"));
                    return admin;
                }
            }
        );
        return list.isEmpty() ? null : list.get(0);
    }
    @Override
    public boolean checkPassword(AdminModel loggedInAdmin, String currentPassword) {
        return loggedInAdmin.getPassword().equals(currentPassword);
    }
    @Override
    public void updatePassword(AdminModel loggedInAdmin, String newPassword) {
        String sql = "update admin set password = ? where username = ?";
        template.update(sql, newPassword, loggedInAdmin.getUsername());
    }


}








	

