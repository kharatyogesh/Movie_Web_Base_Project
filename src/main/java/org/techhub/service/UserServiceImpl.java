package org.techhub.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.techhub.model.UserModel;
import org.techhub.repository.UserRepository;


@Service("userService")
public class UserServiceImpl implements UserService{

	@Autowired
	UserRepository userRepo;
	
	@Override
    public UserModel validateUser(UserModel umodel) 
	{
        return userRepo.validateUser(umodel);
    }
	 public boolean updatePassword(String username, String currentPassword, String newPassword) {
		return  userRepo.updatePassword(username, currentPassword, newPassword);
}
	@Override
	public boolean saveUser(UserModel user) {
		// TODO Auto-generated method stub
		return userRepo.saveUser(user);
	}
	@Override
	public UserModel getUserByUsernameAndPassword(String username, String password) {
		// TODO Auto-generated method stub
		return userRepo.getUserByUsernameAndPassword(username, password);
	}
	
	 
}
