package com.mobileprogramming.mobiletoystore.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.mobileprogramming.mobiletoystore.entity.Order;
import com.mobileprogramming.mobiletoystore.entity.Product;

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
	
	@JsonIgnore
	private Order order;
	
	@JsonIgnore
	private Product product;
}
