package com.mobileprogramming.mobiletoystore.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Sort;

import com.mobileprogramming.mobiletoystore.entity.User;

public interface IUserService {

	void deleteById(Integer id);

	long count();

	Optional<User> findById(Integer id);

	List<User> findAll();

	List<User> findAll(Sort sort);

	<S extends User> S save(S entity);
	
	Optional<User> login(String username, String password);

	boolean checkUsernameExists(String username);

	boolean checkEmailExists(String email);

	User signup(String username, String password, String firstname, String lastname, String email, String phone);

	List<User>getUser();
}
