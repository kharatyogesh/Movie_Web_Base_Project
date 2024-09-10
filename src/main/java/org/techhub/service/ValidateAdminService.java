package org.techhub.service;

import org.techhub.model.AdminModel;

public interface ValidateAdminService {

	public AdminModel isValidateAdmin(AdminModel model);

	public AdminModel getLoggedInAdmin();
	public boolean checkPassword(AdminModel loggedInAdmin, String currentPassword);
	public void updatePassword(AdminModel loggedInAdmin, String newPassword); 
}
