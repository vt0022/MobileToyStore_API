package com.mobileprogramming.mobiletoystore.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mobileprogramming.mobiletoystore.entity.Cart;
import com.mobileprogramming.mobiletoystore.entity.CartItem;
import com.mobileprogramming.mobiletoystore.entity.User;
import com.mobileprogramming.mobiletoystore.model.CartItemModel;
import com.mobileprogramming.mobiletoystore.model.CartModel;
import com.mobileprogramming.mobiletoystore.model.ProductModel;
import com.mobileprogramming.mobiletoystore.service.ICartItemService;
import com.mobileprogramming.mobiletoystore.service.ICartService;
import com.mobileprogramming.mobiletoystore.service.IUserService;

@RestController
@RequestMapping("/cart")
public class CartItemController {

	@Autowired
	ICartItemService cartItemService;
	
	@Autowired
	ICartService cartService;
	
	@Autowired
	IUserService userService;
	
	@Autowired
	ModelMapper modelMapper;
	
	@GetMapping("")
	public ResponseEntity<List<CartItemModel>> getItemOfCart(@PathVariable int userID) {
		Optional<User> user = userService.findById(userID);
		if(!user.isPresent()) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		// Get cart 
		Optional<Cart> cart = Optional.of(user.get().getCart());
		if(cart.isPresent()) {
			List<CartItem> cartItemList = cartItemService.getItemsByCart(cart.get().getCartID());
			// Catch null with empty
			cartItemList = Optional.ofNullable(cartItemList).orElse(Collections.emptyList());
			// Mapping and return
			List<CartItemModel> cartItems = modelMapper.map(cartItemList, new TypeToken<List<CartItemModel>>(){}.getType());
			return new ResponseEntity<>(cartItems, HttpStatus.OK);
		} else {
			Cart newCart = new Cart();
			newCart = cartService.save(newCart);
			// No things in Cart
			List<CartItemModel> cartItems = Collections.emptyList();
			// Return empty collections
			return new ResponseEntity<>(cartItems, HttpStatus.OK);
		}
	}
}
