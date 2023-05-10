package com.mobileprogramming.mobiletoystore.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.mobileprogramming.mobiletoystore.entity.Review;
import com.mobileprogramming.mobiletoystore.entity.User;

@Repository
public interface IUserRepository extends JpaRepository<User, Integer>{

	@Query("SELECT u FROM User u WHERE u.username = :username AND u.password = :password")
	Optional<User> findUserByUsernameAndPassword(String username, String password);
	
	@Query("SELECT u FROM User u")
	List<User> findUser();
	
	//List<User> findByUsername(String username);

	//@Query("SELECT EXISTS(SELECT u FROM User u WHERE u.email = ?1")
	boolean existsByEmail(String email);
	
	//@Query("SELECT EXISTS(SELECT u FROM User u WHERE u.username = ?1")
	boolean existsByUsername(String username);
}
