package com.mobileprogramming.mobiletoystore.service;

import java.util.List;
import java.util.Optional;

import com.mobileprogramming.mobiletoystore.entity.Review;
import com.mobileprogramming.mobiletoystore.entity.User;

public interface IReviewService {

	void deleteById(Integer id);

	Optional<Review> findById(Integer id);

	List<Review> findAll();

	<S extends Review> S save(S entity);

	List<Review> findByUser(Integer userID);

}
