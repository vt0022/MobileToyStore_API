package com.mobileprogramming.mobiletoystore.controller;

import java.util.List;
import java.util.Optional;

import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.mobileprogramming.mobiletoystore.entity.Order;
import com.mobileprogramming.mobiletoystore.entity.OrderItem;
import com.mobileprogramming.mobiletoystore.entity.Review;
import com.mobileprogramming.mobiletoystore.model.OrderItemModel;
import com.mobileprogramming.mobiletoystore.model.ProductModel;
import com.mobileprogramming.mobiletoystore.model.ReviewModel;
import com.mobileprogramming.mobiletoystore.service.IOrderItemService;
import com.mobileprogramming.mobiletoystore.service.IOrderService;
import com.mobileprogramming.mobiletoystore.service.IReviewService;

@RestController
@RequestMapping("/toystoreapp/orderitem")
public class OrderItemController {
	
	@Autowired
	ModelMapper modelMapper;
	
	@Autowired
	IReviewService reviewService;
	
	@Autowired
	IOrderItemService orderItemService;
	
	@Autowired
	IOrderService orderService;
	
	@GetMapping("/review")
	public ResponseEntity<?> getOrderItemByReview(@RequestParam int reviewID) {
		Review review = reviewService.findById(reviewID).get();
		OrderItem orderItem = review.getOrderItem();
		OrderItemModel orderItemModel = modelMapper.map(orderItem, OrderItemModel.class);
		return new ResponseEntity<>(orderItemModel, HttpStatus.OK);
	}
	
	@GetMapping("")
	public ResponseEntity<?> getOrderItemByOrder(@RequestParam int orderID) {
		Order order = orderService.findById(orderID).get();
		List<OrderItem> orderItems = order.getOrderItems();
		List<OrderItemModel> orderItemModels = modelMapper.map(orderItems, new TypeToken<List<OrderItemModel>>() {}.getType());
		return new ResponseEntity<>(orderItemModels, HttpStatus.OK);
	}

}
