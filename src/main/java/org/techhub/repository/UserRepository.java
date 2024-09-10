package org.techhub.repository;

import org.techhub.model.UserModel;

public interface UserRepository {
	 public UserModel validateUser(UserModel umodel);
    public boolean updatePassword(String username, String currentPassword, String newPassword);
    public boolean saveUser(UserModel user);
    public UserModel getUserByUsernameAndPassword(String username, String password);
}
