package com.mobileprogramming.mobiletoystore.controller.customer;

import java.sql.Timestamp;
import java.util.Optional;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.mobileprogramming.mobiletoystore.entity.User;
import com.mobileprogramming.mobiletoystore.model.MessageModel;
import com.mobileprogramming.mobiletoystore.model.UserAuthenticationModel;
import com.mobileprogramming.mobiletoystore.model.UserModel;
import com.mobileprogramming.mobiletoystore.service.IUserService;

import lombok.ToString;

@RestController
@RequestMapping("/toystoreapp/user")
public class UserController {

	@Autowired
	ModelMapper modelMapper;
	
	@Autowired
	IUserService userService;
	
	@GetMapping("/me")
	public ResponseEntity<UserModel> getUserByID(@PathVariable int userID) {
		Optional<User> user = userService.findById(userID);
		if(user.isPresent()) {
			UserModel userModel = modelMapper.map(user.get(), UserModel.class);
			return new ResponseEntity<UserModel>(userModel, HttpStatus.OK);
		}
		return new ResponseEntity<>(HttpStatus.NOT_FOUND);	
	}
	
	@PostMapping("/login")
	public ResponseEntity<?> loginUser(@RequestParam String username, @RequestParam String password) {
		Optional<User> user = userService.login(username, password);
		if(user.isPresent()) {
			UserModel userModel = modelMapper.map(user.get(), UserModel.class);
			// Set message and data
			UserAuthenticationModel userLogin = new UserAuthenticationModel();
			userLogin.setMessage("Login successfully.");
			userLogin.setUserModel(userModel);
			
			return new ResponseEntity<>(userLogin, HttpStatus.OK);
		}
		return new ResponseEntity<>(new MessageModel("Invalid username or password."), HttpStatus.NO_CONTENT);	
	}
	
	@PostMapping("/signup")
	public ResponseEntity<?> signupUser(@RequestParam(required = true) String username, 
										@RequestParam(required = true) String password,
										@RequestParam(required = true) String firstname,
										@RequestParam String lastname,
										@RequestParam(required = true) String email,
										@RequestParam(required = true) String phone) {
		if(userService.checkEmailExists(email)) {
			return new ResponseEntity<>(new MessageModel("Email has been already registered."), HttpStatus.IM_USED);	
		}
		else if(userService.checkUsernameExists(username)) {
			return new ResponseEntity<>(new MessageModel("Username has been already taken."), HttpStatus.IM_USED);	
		}
		// Create a new user
		User newUser = userService.signup(username, password, firstname, lastname, email, phone);
		newUser = userService.save(newUser);
		// Create a response model
		UserAuthenticationModel newUserResponse = new UserAuthenticationModel();
		newUserResponse.setMessage("Sign up successfully.");
		// Map and set
		newUserResponse.setUserModel(modelMapper.map(newUserResponse, UserModel.class));
		return new ResponseEntity<>(newUserResponse, HttpStatus.OK);
	}
	
	@PostMapping("/update/profile")
	public ResponseEntity<?> updateProfile(@RequestBody UserModel userModel) {
		if(userService.checkEmailExists(userModel.getEmail())) {
			return new ResponseEntity<>(new MessageModel("Email has been already registered."), HttpStatus.IM_USED);	
		}
		else if(userService.checkUsernameExists(userModel.getUsername())) {
			return new ResponseEntity<>(new MessageModel("Username has been already taken."), HttpStatus.IM_USED);	
		}
		Optional<User> currentUser = userService.findById(userModel.getUserID());
		if(currentUser.isPresent()) {
			// Update
			User updatedUser = currentUser.get();
			updatedUser = modelMapper.map(userModel, User.class);
			updatedUser.setUpdatedAt(new Timestamp(System.currentTimeMillis()));
			updatedUser = userService.save(updatedUser);
			// Map to get updated user
			userModel = modelMapper.map(updatedUser, UserModel.class);
			return new ResponseEntity<>(userModel, HttpStatus.OK);
		}
		return new ResponseEntity<>(new MessageModel("Failed to update profile."), HttpStatus.NOT_MODIFIED);
	}
}
