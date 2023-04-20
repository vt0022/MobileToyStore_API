package com.mobileprogramming.mobiletoystore.controller;

import java.sql.Timestamp;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collector;
import java.util.stream.Collectors;

import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.validation.constraints.NotNull;

import org.aspectj.weaver.NewConstructorTypeMunger;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.mobileprogramming.mobiletoystore.entity.OrderItem;
import com.mobileprogramming.mobiletoystore.entity.Product;
import com.mobileprogramming.mobiletoystore.entity.Review;
import com.mobileprogramming.mobiletoystore.entity.User;
import com.mobileprogramming.mobiletoystore.model.ProductModel;
import com.mobileprogramming.mobiletoystore.model.ReviewModel;
import com.mobileprogramming.mobiletoystore.service.IOrderItemService;
import com.mobileprogramming.mobiletoystore.service.IProductService;
import com.mobileprogramming.mobiletoystore.service.IReviewService;
import com.mobileprogramming.mobiletoystore.service.IUserService;
import com.mobileprogramming.mobiletoystore.service.impl.ReviewServiceImpl;

@RestController
@RequestMapping("/toystoreapp/review")
public class ReviewController {
	
	@Autowired
	ModelMapper modelMapper;
	
	@Autowired
	IReviewService reviewService;
	
	@Autowired
	IProductService productService;
	
	@Autowired
	IUserService userService;
	
	@Autowired
	IOrderItemService orderItemService;
	
	@GetMapping("/all")
	public ResponseEntity<?> listReviews() {
		List<ReviewModel> reviewModels = reviewService.findAll().stream().map(review -> modelMapper
				.map(review, ReviewModel.class)).collect(Collectors.toList());
		return new ResponseEntity<>(reviewModels, HttpStatus.OK);
	}
	
	@GetMapping("/my")
	public ResponseEntity<?> getReviewByUser(@RequestParam int userID) {
		List<Review> reviews = reviewService.findByUser(userID);
		List<ReviewModel> reviewModels = modelMapper.map(reviews, new TypeToken<List<ReviewModel>>(){}.getType());
		return new ResponseEntity<>(reviewModels, HttpStatus.OK);
	}
	
	@GetMapping("/my/{reviewID}")
	public ResponseEntity<?> getReviewByID(@PathVariable int reviewID) {
		Optional<Review> review = reviewService.findById(reviewID);
		if(review.isPresent()) {
			ReviewModel reviewModel = modelMapper.map(review, ReviewModel.class);
			return new ResponseEntity<>(reviewModel, HttpStatus.OK);
		}
		return new ResponseEntity<>(Optional.empty(), HttpStatus.OK);	
	}
	
	@PostMapping("/create")
	public ResponseEntity<?> reviewProduct(@RequestBody ReviewModel reviewModel, 
											@RequestParam int orderItemID,
											@RequestParam int userID,
											@RequestParam int productID) {
		OrderItem orderItem = orderItemService.findById(orderItemID).get();
		Product product = productService.findById(productID).get();
		User user = userService.findById(userID).get();
		
		Review review = modelMapper.map(reviewModel, Review.class);
		review.setProduct(product);
		review.setOrderItem(orderItem);
		review.setUser(user);
		review.setUpdatedAt(new Timestamp(System.currentTimeMillis()));
		review = reviewService.save(review);
		
		reviewModel = modelMapper.map(review, ReviewModel.class);
		return new ResponseEntity<> (reviewModel, HttpStatus.CREATED);
	}
	
	@PutMapping("/update")
	public ResponseEntity<?> updateReview(@RequestParam int reviewID, 
											@RequestParam int star,
											@RequestParam String comment,
											@RequestParam String images) {
		Review review = reviewService.findById(reviewID).get();
		review.setStar(star);
		review.setComment(comment);
		review.setImages(images);
		review.setUpdatedAt(new Timestamp(System.currentTimeMillis()));
		review = reviewService.save(review);
		
		ReviewModel reviewModel = modelMapper.map(review, ReviewModel.class);
		return new ResponseEntity<> (reviewModel, HttpStatus.CREATED);
	}
}
