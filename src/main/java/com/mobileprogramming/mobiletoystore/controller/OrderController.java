package com.mobileprogramming.mobiletoystore.controller;

import java.sql.Timestamp;
import java.util.List;
import java.util.Optional;

import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
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

import com.mobileprogramming.mobiletoystore.entity.Order;
import com.mobileprogramming.mobiletoystore.entity.OrderItem;
import com.mobileprogramming.mobiletoystore.entity.User;
import com.mobileprogramming.mobiletoystore.model.CartItemModel;
import com.mobileprogramming.mobiletoystore.model.CartModel;
import com.mobileprogramming.mobiletoystore.model.OrderItemModel;
import com.mobileprogramming.mobiletoystore.model.OrderModel;
import com.mobileprogramming.mobiletoystore.model.ProductModel;
import com.mobileprogramming.mobiletoystore.model.UserModel;
import com.mobileprogramming.mobiletoystore.service.IOrderService;
import com.mobileprogramming.mobiletoystore.service.IUserService;

@RestController
@RequestMapping("/toystoreapp/order")
public class OrderController {
	
	@Autowired
	IOrderService orderService;
	
	@Autowired
	IUserService userService;
	
	@Autowired
	ModelMapper modelMapper;
	
	@GetMapping({"", "/all"})
	public ResponseEntity<?> getAllOrders() {
		List<Order> orderList = orderService.findAll();
		// Mapping
		List<OrderModel> orderModels = modelMapper.map(orderList, new TypeToken<List<OrderModel>>(){}.getType());
//		for (OrderModel orderModel : orderModels) {
//			for (OrderItemModel o : orderModel.getOrderItems())
//				System.out.println(o.getOrderItemID());
//		}
		return new ResponseEntity<>(orderModels, HttpStatus.OK);
	}
	
	@GetMapping("/{orderID}")
	public ResponseEntity<?> getOrderByID(@PathVariable int orderID) {
		Optional<Order>order = orderService.findById(orderID);
		if(order.isPresent()) {
			OrderModel orderModel = modelMapper.map(order.get(), OrderModel.class);
			return new ResponseEntity<>(orderModel, HttpStatus.OK);
		}
		return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	}
	
	@PostMapping(path = "/my", consumes = "application/x-www-form-urlencoded")
	public ResponseEntity<?> getOrderByUser(@RequestParam(required=true) int userID) {
		Optional<User> user = userService.findById(userID);
		if(user.isPresent()) {
			List<Order>orders = orderService.findByUser(user.get());
			List<OrderModel> orderModel = modelMapper.map(orders, new TypeToken<List<OrderModel>>() {}.getType());
			return new ResponseEntity<>(orderModel, HttpStatus.OK);
		}
		return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	}
	
	@PostMapping("/placeOrder")
	public ResponseEntity<?> placeOrder(@RequestBody OrderModel orderModel) {
		// Map and save order from request
		Order newOrder = modelMapper.map(orderModel, Order.class);
		// Create a list of order items
		List<OrderItem> orderItems = newOrder.getOrderItems();
		// Save order from request
		newOrder.setOrderedDate(new Timestamp(System.currentTimeMillis()));
		// Set for order item
		// Remove products with quantity
		long total = 0;
		for (OrderItem orderItem : orderItems) {
			orderItem.setPrice(orderItem.getProduct().getPrice());
			orderItem.setOrder(newOrder);
			total += orderItem.getProduct().getPrice();
			// Update quantity
			orderItem.getProduct().setQuantity(orderItem.getProduct().getQuantity() - orderItem.getQuantity());
		}
		// Set status and total
		// Shipping fee //
		newOrder.setTotal(total);
		newOrder.setOrderItems(orderItems);
		newOrder = orderService.save(newOrder);
		// Map
		OrderModel newOrderModel = modelMapper.map(newOrder, OrderModel.class);
		return new ResponseEntity<>(newOrderModel, HttpStatus.CREATED);
	}

	@PostMapping("/update_status")
	public ResponseEntity<?> updateStatus(@RequestParam int orderID, @RequestParam int status) {
		Optional<Order> order = orderService.findById(orderID);
		if(order.isPresent()) {
			Order myOrder = order.get();
			myOrder.setStatus(status);
			// Cancel so return all product
			if(status == 3)
				myOrder.setCancelledDate(new Timestamp(System.currentTimeMillis()));
			myOrder = orderService.save(myOrder);
			OrderModel orderModel = modelMapper.map(myOrder, OrderModel.class);
			return new ResponseEntity<>(orderModel, HttpStatus.OK);
		}
		return new ResponseEntity<>(HttpStatus.NOT_MODIFIED);
	}
}
