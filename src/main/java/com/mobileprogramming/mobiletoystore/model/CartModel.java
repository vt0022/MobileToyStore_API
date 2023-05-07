package com.mobileprogramming.mobiletoystore.model;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CartModel {
	
	private int cartID;
	
	private UserModel user;
	
	private List<CartItemModel> cartItems;
}
