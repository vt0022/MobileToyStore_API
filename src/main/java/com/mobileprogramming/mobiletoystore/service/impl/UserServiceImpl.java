package com.mobileprogramming.mobiletoystore.service.impl;

import java.sql.Timestamp;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.AfterDomainEventPublication;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.mobileprogramming.mobiletoystore.entity.Review;
import com.mobileprogramming.mobiletoystore.entity.User;
import com.mobileprogramming.mobiletoystore.repository.IUserRepository;
import com.mobileprogramming.mobiletoystore.service.IUserService;
import com.mobileprogramming.mobiletoystore.utility.SHA512Hash;

@Service
public class UserServiceImpl implements IUserService{
	@Autowired
	IUserRepository userRepository;

	@Override
	public <S extends User> S save(S entity) {
		return userRepository.save(entity);
	}

	@Override
	public List<User> findAll(Sort sort) {
		return userRepository.findAll(sort);
	}

	@Override
	public List<User> findAll() {
		return userRepository.findAll();
	}

	@Override
	public Optional<User> findById(Integer id) {
		return userRepository.findById(id);
	}

	@Override
	public long count() {
		return userRepository.count();
	}

	@Override
	public void deleteById(Integer id) {
		userRepository.deleteById(id);
	}
	
	@Override
	public Optional<User> login(String username, String password) {
		return userRepository.findUserByUsernameAndPassword(username, password);
	}	
	
	@Override
	public boolean checkEmailExists(String email) {
		return userRepository.existsByEmail(email);
	}
	
	@Override
	public boolean checkUsernameExists(String username) {
		return userRepository.existsByUsername(username);
	}
	
	@Override
	public User signup(String username, String password, 
			String firstname, String lastname, String email, String phone) {
		User newUser = new User();
		newUser.setUsername(username);
		String hashedPassword = SHA512Hash.encryptThis(password.concat("hihi"));
		newUser.setPassword(hashedPassword);
		newUser.setFirstname(firstname);
		newUser.setLastname(lastname);
		newUser.setEmail(email);
		newUser.setPhone(phone);
		newUser.setCreatedAt(new Timestamp(System.currentTimeMillis()));
		newUser.setUpdatedAt(new Timestamp(System.currentTimeMillis()));
		newUser.setStatus(true);
		newUser.setRole(true);
		newUser = userRepository.save(newUser);
		return newUser;
	}
	
	@Override
	public List<User>getUser() {
		return userRepository.findUser();
	}	
	
}
