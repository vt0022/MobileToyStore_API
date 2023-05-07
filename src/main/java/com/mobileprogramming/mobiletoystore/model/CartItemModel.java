package com.mobileprogramming.mobiletoystore.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CartItemModel {

	private int cartItemID;
	
	private int quantity;
	
	private ProductModel product;
	
	@JsonIgnore
	private CartModel cart;
}
