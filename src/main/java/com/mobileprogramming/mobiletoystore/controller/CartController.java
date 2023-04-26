package com.mobileprogramming.mobiletoystore.controller;

import java.util.List;
import java.util.Optional;

import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.mobileprogramming.mobiletoystore.entity.Cart;
import com.mobileprogramming.mobiletoystore.entity.CartItem;
import com.mobileprogramming.mobiletoystore.model.CartItemModel;
import com.mobileprogramming.mobiletoystore.model.CartModel;
import com.mobileprogramming.mobiletoystore.entity.User;
import com.mobileprogramming.mobiletoystore.service.ICartItemService;
import com.mobileprogramming.mobiletoystore.service.ICartService;
import com.mobileprogramming.mobiletoystore.service.IUserService;

@RestController
@RequestMapping("/toystoreapp/cart")
public class CartController {
	@Autowired 
	ICartService cartService;
	
	@Autowired
	IUserService userService;
	
	@Autowired
	ICartItemService cartItemService;
	
	@Autowired
	ModelMapper modelMapper;
	
	@GetMapping("")
	public ResponseEntity<CartModel> getCartByID(@RequestParam int cartID){
		Optional<Cart> cart = cartService.findById(cartID);
		if(cart.isPresent()) {
			CartModel cartModel = modelMapper.map(cart, CartModel.class);
			return new ResponseEntity<>(cartModel, HttpStatus.OK);
		}
		return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	}
	
	@GetMapping(path = "/mycart", consumes = "application/x-www-form-urlencoded")
	public ResponseEntity<?> getCartByUserID(@RequestParam int userID){
		Optional<User> user = userService.findById(userID);
		if(!user.isPresent()) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		// Get cart 
		Optional<Cart> cart = Optional.of(user.get().getCart());
		if(cart.isPresent()) {
			//List<CartItem> cartItems = cartItemService.findByCart(cart.get());
			//List<CartItemModel> cartItemModels = modelMapper.map(cartItems, new TypeToken<List<CartItemModel>>() {}.getType());
			//return new ResponseEntity<>(cartItemModels, HttpStatus.OK);
			CartModel cartModel = modelMapper.map(cart.get(), CartModel.class);
			return new ResponseEntity<>(cartModel, HttpStatus.OK);
		} else
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	}
	
	@PostMapping(path = "/create", consumes = "application/x-www-form-urlencoded")
	public ResponseEntity<?> createCart(@RequestParam int userID) {
		Optional<User> user = userService.findById(userID);
		if(!user.isPresent())
			return ResponseEntity.notFound().build();
		Cart newCart = new Cart();
		newCart.setUser(user.get());
		newCart = cartService.save(newCart);
		return new ResponseEntity<>(modelMapper.map(newCart, CartModel.class), HttpStatus.CREATED);
	}
	
	@PutMapping("/update/{cartID}")
	public ResponseEntity<CartModel> updateCart(@PathVariable int cartID, @RequestBody CartModel cart) {
		// Find old cart
		Optional<Cart> oldCart = cartService.findById(cartID);
		if(oldCart.isPresent()) {
			Cart newCart = oldCart.get();
			// Map from new cart to old cart
			newCart = modelMapper.map(cart, Cart.class);
			// Save it and get new one
			newCart = cartService.save(newCart);
			return new ResponseEntity<>(modelMapper.map(newCart, CartModel.class), HttpStatus.OK);
		}
		return new ResponseEntity<>(HttpStatus.OK);
	}
}
