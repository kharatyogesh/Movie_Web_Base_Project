package org.techhub.repository;

import org.techhub.model.AdminModel;

public interface ValidateAdminRepository {

	public AdminModel isValidateAdmin(AdminModel model); 
	public AdminModel getLoggedInAdmin();
	public boolean checkPassword(AdminModel loggedInAdmin, String currentPassword);
	public void updatePassword(AdminModel loggedInAdmin, String newPassword); 
}
