package com.mobileprogramming.mobiletoystore.controller;

import java.awt.PageAttributes.MediaType;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.Map;
import java.util.Optional;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.MultipartBodyBuilder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.cloudinary.Cloudinary;
import com.cloudinary.Transformation;
import com.cloudinary.utils.ObjectUtils;
import com.fasterxml.jackson.annotation.JsonView;
import com.mobileprogramming.mobiletoystore.entity.User;
import com.mobileprogramming.mobiletoystore.model.MessageModel;
import com.mobileprogramming.mobiletoystore.model.UserResponseModel;
import com.mobileprogramming.mobiletoystore.model.UserModel;
import com.mobileprogramming.mobiletoystore.service.IUserService;
import com.mobileprogramming.mobiletoystore.utility.SHA512Hash;

@RestController
@RequestMapping("/toystoreapp/user")
public class UserController {

	@Autowired
	ModelMapper modelMapper;

	@Autowired
	IUserService userService;

	@Autowired
	Cloudinary cloudinary;

	@GetMapping("/me/{userID}")
	public ResponseEntity<UserModel> getUserByID(@PathVariable int userID) {
		Optional<User> user = userService.findById(userID);
		if (user.isPresent()) {
			UserModel userModel = modelMapper.map(user.get(), UserModel.class);
			return new ResponseEntity<UserModel>(userModel, HttpStatus.OK);
		}
		return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	}

	@PostMapping(path = "/login", consumes = "application/x-www-form-urlencoded")
	public ResponseEntity<?> loginUser(@RequestParam String username, @RequestParam String password) {
		password = SHA512Hash.encryptThis(password);
		System.out.print(password);
		Optional<User> user = userService.login(username, password);
		if (user.isPresent()) {
			UserModel userModel = modelMapper.map(user.get(), UserModel.class);
			// Set message and data
			UserResponseModel userLogin = new UserResponseModel();
			userLogin.setMessage("Login successfully.");
			userLogin.setData(userModel);

			return new ResponseEntity<>(userLogin, HttpStatus.OK);
		}
		return new ResponseEntity<>(new MessageModel("Invalid username or password."), HttpStatus.NOT_FOUND);
	}

	@PostMapping(path = "/signup", consumes = "application/x-www-form-urlencoded")
	public ResponseEntity<?> signupUser(@RequestParam(required = true) String username,
			@RequestParam(required = true) String password, @RequestParam(required = true) String firstname,
			@RequestParam String lastname, @RequestParam(required = true) String email,
			@RequestParam(required = true) String phone) {
		if (userService.checkEmailExists(email)) {
			return new ResponseEntity<>(new MessageModel("Email has been already registered."), HttpStatus.IM_USED);
		} else if (userService.checkUsernameExists(username)) {
			return new ResponseEntity<>(new MessageModel("Username has been already taken."), HttpStatus.IM_USED);
		}
		// Create a new user
		User newUser = userService.signup(username, password, firstname, lastname, email, phone);
		// Create a response model
		UserResponseModel newUserResponse = new UserResponseModel();
		newUserResponse.setMessage("Sign up successfully.");
		// Map and set
		newUserResponse.setData(modelMapper.map(newUser, UserModel.class));
		return new ResponseEntity<>(newUserResponse, HttpStatus.OK);
	}

	@PutMapping("/update/profile")
	public ResponseEntity<?> updateProfile(@RequestBody UserModel userModel) {
		Optional<User> currentUser = userService.findById(userModel.getUserID());
		if (currentUser.isPresent()) {
			User updatedUser = currentUser.get();

			if (userService.checkEmailExists(userModel.getEmail())
					&& !userModel.getEmail().equals(updatedUser.getEmail())) {
				return new ResponseEntity<>(new MessageModel("Email has been already registered."), HttpStatus.IM_USED);
			} else if (userService.checkUsernameExists(userModel.getUsername())
					&& !userModel.getUsername().equals(updatedUser.getUsername())) {
				return new ResponseEntity<>(new MessageModel("Username has been already taken."), HttpStatus.IM_USED);
			}
			// Update
			updatedUser = modelMapper.map(userModel, User.class);
			updatedUser.setUpdatedAt(new Timestamp(System.currentTimeMillis()));
			// Set password again
			updatedUser.setPassword(currentUser.get().getPassword());
			// Commit
			updatedUser = userService.save(updatedUser);
			// Map to get updated user
			userModel = modelMapper.map(updatedUser, UserModel.class);
			UserResponseModel usModel = new UserResponseModel("Update profile successfully!", userModel);
			return new ResponseEntity<>(usModel, HttpStatus.OK);
		}
		return new ResponseEntity<>(new MessageModel("Failed to update profile."), HttpStatus.NOT_MODIFIED);
	}

	@PutMapping(path = "/update/image")
	public ResponseEntity<?> updateProfileImage(@RequestParam int userID, @RequestPart MultipartFile image)
			throws IOException {
		//int ID =  userID;//Integer.parseInt(userID.toString());
		Optional<User>user = userService.findById(userID);
		if(!user.isPresent())
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		try {
			// Upload image
			Map u = cloudinary.uploader().upload(image.getBytes(), ObjectUtils.asMap("public_id", "profile_" + String.valueOf(userID)));
			// public_id: a unique identifier that you can assign to each image to help you manage your media assets
			// Crop image
			String url = cloudinary.url().publicId(u.get("public_id").toString()).
					transformation(new Transformation().width(100).height(100).crop("fill")).generate();
			// Update image
			User updatedUser = user.get();
			updatedUser.setImage(url);
			updatedUser.setUpdatedAt(new Timestamp(System.currentTimeMillis()));
			updatedUser = userService.save(updatedUser);
			// Create response model
			UserResponseModel usModel = new UserResponseModel();
			usModel.setMessage("Profile image was updated sucessfully!");
			usModel.setData(modelMapper.map(updatedUser, UserModel.class));
			return new ResponseEntity<>(usModel, HttpStatus.OK);
		} catch (IOException exception) {
			System.out.println(exception.getMessage());
		}
		return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	}
}
