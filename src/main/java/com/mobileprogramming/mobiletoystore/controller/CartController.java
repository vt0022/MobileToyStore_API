package com.mobileprogramming.mobiletoystore.controller;

import java.util.List;
import java.util.Optional;

import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.mobileprogramming.mobiletoystore.entity.Cart;
import com.mobileprogramming.mobiletoystore.entity.CartItem;
import com.mobileprogramming.mobiletoystore.entity.Product;
import com.mobileprogramming.mobiletoystore.model.CartItemModel;
import com.mobileprogramming.mobiletoystore.model.CartModel;
import com.mobileprogramming.mobiletoystore.entity.User;
import com.mobileprogramming.mobiletoystore.service.ICartItemService;
import com.mobileprogramming.mobiletoystore.service.ICartService;
import com.mobileprogramming.mobiletoystore.service.IProductService;
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
	IProductService productService;
	
	@Autowired
	ModelMapper modelMapper;
	
	@GetMapping("")
	public ResponseEntity<?> getCartByID(@RequestParam int cartID){
		Optional<Cart> cart = cartService.findById(cartID);
		if(cart.isPresent()) {
			CartModel cartModel = modelMapper.map(cart.get(), CartModel.class);
			return new ResponseEntity<>(cartModel, HttpStatus.OK);
		}
		return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	}
	
	@PostMapping(path = "/mycart", consumes = "application/x-www-form-urlencoded")
	public ResponseEntity<?> getCartByUserID(@RequestParam(value = "userID", required = true) int userID){
		Optional<User> user = userService.findById(userID);
		if(!user.isPresent()) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		// Get cart 
		Optional<Cart> cart = Optional.of(user.get().getCart());
		if(cart.isPresent()) {
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
	
	@ResponseBody
	@PostMapping(path = "/add", consumes = "application/x-www-form-urlencoded")
	public ResponseEntity<?> addToCart(@RequestParam int productID, @RequestParam int quantity, @RequestParam int userID) {
		// Find product
		Product product = productService.findById(productID).get();
		// Find user
		User user = userService.findById(userID).get();
		List<CartItem> cartItems = user.getCart().getCartItems();
		boolean isExisting = false;
		if (cartItems.isEmpty()) {
			CartItem newCartItem = new CartItem();
			newCartItem.setCart(user.getCart());
			newCartItem.setProduct(product);
			newCartItem.setQuantity(quantity);
			newCartItem = cartItemService.save(newCartItem);
		} else {
			for (CartItem ci : cartItems) {
				if (ci.getProduct().equals(product)) {;
					ci.setQuantity(ci.getQuantity() + quantity);
					ci = cartItemService.save(ci);
					isExisting = true;
					break;
				}
			}	
		}
		if (!isExisting) {
			CartItem newCartItem = new CartItem();
			newCartItem.setCart(user.getCart());
			newCartItem.setProduct(product);
			newCartItem.setQuantity(quantity);
			newCartItem = cartItemService.save(newCartItem);
		}

		Cart myCart = user.getCart();
		// Map to reply
		CartModel myCartModel = modelMapper.map(myCart, CartModel.class);
		return new ResponseEntity<>(modelMapper.map(myCartModel, CartModel.class), HttpStatus.OK);
	}
	
	@ResponseBody
	@PutMapping("/update")
	public ResponseEntity<?> updateCart(@RequestBody CartItemModel cartItemModel) {
		// Find cartitem
		Optional<CartItem> cartItem = cartItemService.findById(cartItemModel.getCartItemID());
		// Find user
		Optional<User> user = userService.findById(cartItem.get().getCart().getUser().getUserID());
		// Update cartitem
		if (cartItemModel.getQuantity() == 0) {
			cartItemService.delete(cartItem.get());
		} else {
			cartItem.get().setQuantity(cartItemModel.getQuantity());
			CartItem thisCartItem = cartItemService.save(cartItem.get());
		}
		Cart myCart = user.get().getCart();
		// Map to reply
		CartModel myCartModel = modelMapper.map(myCart, CartModel.class);
		return new ResponseEntity<>(modelMapper.map(myCartModel, CartModel.class), HttpStatus.OK);
	}
	
	@DeleteMapping(path = "/delete", consumes = "application/x-www-form-urlencoded")
	public ResponseEntity<?> deleteItemFromCart(@RequestParam int cartItemID) {
		// Find cartitem
		Optional<CartItem> cartItem = cartItemService.findById(cartItemID);
		// Find user
		Optional<User> user = userService.findById(cartItem.get().getCart().getUser().getUserID());
		// Delete cartitem
		cartItemService.delete(cartItem.get());
		Cart myCart = user.get().getCart();
		// Map to reply
		CartModel myCartModel = modelMapper.map(myCart, CartModel.class);
		return new ResponseEntity<>(modelMapper.map(myCartModel, CartModel.class), HttpStatus.OK);
	}
	
}
