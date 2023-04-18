package com.mobileprogramming.mobiletoystore.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderItemModel {

	private int orderItemID;
	
	private int quantity;
	
	private long price;
	
	private OrderModel order;
	
	private ProductModel product;
}
