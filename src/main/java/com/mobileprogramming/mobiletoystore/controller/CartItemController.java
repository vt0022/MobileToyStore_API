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
import com.mobileprogramming.mobiletoystore.entity.User;
import com.mobileprogramming.mobiletoystore.model.CartItemModel;
import com.mobileprogramming.mobiletoystore.model.CartModel;
import com.mobileprogramming.mobiletoystore.model.MessageModel;
import com.mobileprogramming.mobiletoystore.model.ProductModel;
import com.mobileprogramming.mobiletoystore.service.ICartItemService;
import com.mobileprogramming.mobiletoystore.service.ICartService;
import com.mobileprogramming.mobiletoystore.service.IProductService;
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
	IProductService productService;

	@Autowired
	ModelMapper modelMapper;

	@PostMapping(path = "/add", consumes = "application/x-www-form-urlencoded")
	public ResponseEntity<?> addItemToCart(@RequestParam int userID, @RequestParam int productID,
			@RequestParam int quantity) {
		// Check user
		Optional<User> user = userService.findById(userID);
		if (!user.isPresent())
			return ResponseEntity.badRequest().build();
		User currentUser = user.get();
		// Check product
		Optional<Product> product = productService.findById(productID);
		if (!product.isPresent())
			return ResponseEntity.badRequest().build();
		// Get cart
		Optional<Cart> cart = cartService.findByUser(currentUser);
		Cart myCart = cart.get();
//		// Non-exist
//		if(!cart.isPresent()) {
//			// Create a cart
//			Cart newCart = new Cart();
//			newCart.setUser(currentUser);
//			newCart = cartService.save(newCart);
//			// Set cart
//			currentUser.setCart(newCart);
//			currentUser = userService.save(currentUser);
//		}
		List<CartItem> cartItems = cartItemService.findByCart(cart.get());
		// Already exist
		boolean checked = false;
		for (CartItem cartItem : cartItems) {
			if (cartItem.getProduct().getProductID() == productID) {
				checked = true;
				// Out of stock
				if (product.get().getQuantity() == 0)
					return new ResponseEntity<>(new MessageModel("Out of stock."), HttpStatus.BAD_REQUEST);
				// Lack of products
				else if (product.get().getQuantity() < quantity)
					return new ResponseEntity<>(new MessageModel("Not enough products."), HttpStatus.BAD_REQUEST);
				// Add new products
				else {
					cartItem.setQuantity(cartItem.getQuantity() + quantity);
					cartItem = cartItemService.save(cartItem);
					myCart.setCartItems(cartItems);
					myCart = cartService.save(myCart);
					break;
				}
			}
		}
		if (checked == false) {
			// New
			CartItem newCartItem = new CartItem();
			newCartItem.setCart(cart.get());
			newCartItem.setProduct(product.get());
			// Out of stock
			if (product.get().getQuantity() == 0)
				return new ResponseEntity<>(new MessageModel("Out of stock."), HttpStatus.BAD_REQUEST);
			// Lack of products
			else if (product.get().getQuantity() < quantity)
				return new ResponseEntity<>(new MessageModel("Not enough products."), HttpStatus.BAD_REQUEST);
			// Add new products
			else {
				newCartItem.setQuantity(quantity);
				newCartItem = cartItemService.save(newCartItem);
				myCart.setCartItems(cartItems);
				myCart = cartService.save(myCart);
				cartItems.add(newCartItem);
			}
		}

		List<CartItemModel> cartItemModels = modelMapper.map(cartItems, new TypeToken<List<CartItemModel>>() {
		}.getType());
		return new ResponseEntity<>(cartItemModels, HttpStatus.OK);
	}

}
