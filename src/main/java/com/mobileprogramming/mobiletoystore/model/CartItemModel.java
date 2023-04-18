package com.mobileprogramming.mobiletoystore.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CartItemModel {

	private int cartItemID;
	
	private int quantity;
	
	private int cartID;
	
	private int productID;
}
