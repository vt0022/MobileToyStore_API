package com.mobileprogramming.mobiletoystore.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.mobileprogramming.mobiletoystore.entity.Product;
import com.mobileprogramming.mobiletoystore.entity.Review;
import com.mobileprogramming.mobiletoystore.entity.User;

@Repository
public interface IReviewRespository extends JpaRepository<Review, Integer> {
	
	@Query("SELECT r FROM Review r WHERE r.user.userID = ?1")
	List<Review> findByUser(Integer userID);
	
	List<Review> findByProduct(Product product);
}
