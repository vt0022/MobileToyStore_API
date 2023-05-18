package com.mobileprogramming.mobiletoystore.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mobileprogramming.mobiletoystore.entity.Product;
import com.mobileprogramming.mobiletoystore.entity.Review;
import com.mobileprogramming.mobiletoystore.repository.IReviewRespository;
import com.mobileprogramming.mobiletoystore.service.IReviewService;

@Service
public class ReviewServiceImpl implements IReviewService {
	
	@Autowired
	IReviewRespository reviewRespository;

	@Override
	public <S extends Review> S save(S entity) {
		return reviewRespository.save(entity);
	}

	@Override
	public List<Review> findAll() {
		return reviewRespository.findAll();
	}

	@Override
	public Optional<Review> findById(Integer id) {
		return reviewRespository.findById(id);
	}

	@Override
	public void deleteById(Integer id) {
		reviewRespository.deleteById(id);
	}
	
	@Override 
	public List<Review> findByUser(Integer userID) {
		return reviewRespository.findByUser(userID);
	}

	@Override
	public List<Review> findByProduct(Product product) {
		return reviewRespository.findByProduct(product);
	}

	@Override
	public List<Review> findByOrderByCreatedAtDesc() {
		return reviewRespository.findByOrderByCreatedAtDesc();
	}

	@Override
	public List<Review> findByStarOrderByCreatedAtDesc(Integer star) {
		return reviewRespository.findByStarOrderByCreatedAtDesc(star);
	}
}
