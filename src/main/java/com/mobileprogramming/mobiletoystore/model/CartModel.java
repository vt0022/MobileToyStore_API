package com.mobileprogramming.mobiletoystore.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CartModel {
	
	private int cartID;
	
	private int userID;
}
