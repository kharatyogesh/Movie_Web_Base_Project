package org.techhub.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.techhub.model.AdminModel;
import org.techhub.repository.ValidateAdminRepositoryImpl;


@Service("validateService")
public class ValidateAdminServiceImpl implements ValidateAdminService{

	@Autowired
	ValidateAdminRepositoryImpl regRepo;


	@Autowired
	private HttpSession session;  
	
	
	@Override
	public AdminModel isValidateAdmin(AdminModel model) {
		
		return regRepo.isValidateAdmin(model);
	}

	@Override
	public AdminModel getLoggedInAdmin() {
	    // Retrieve the logged-in admin from the session
	    return (AdminModel) session.getAttribute("loggedInAdmin");
	}

	@Override
	public boolean checkPassword(AdminModel loggedInAdmin, String currentPassword) {
		// TODO Auto-generated method stub
		return regRepo.checkPassword(loggedInAdmin, currentPassword);
	}

	@Override
	public void updatePassword(AdminModel loggedInAdmin, String newPassword) {
		// TODO Auto-generated method stub
		regRepo.updatePassword(loggedInAdmin, newPassword);
		
	}

	
	
}
