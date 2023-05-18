package com.mobileprogramming.mobiletoystore.model;

import java.sql.Timestamp;

import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.mobileprogramming.mobiletoystore.entity.OrderItem;
import com.mobileprogramming.mobiletoystore.entity.Product;
import com.mobileprogramming.mobiletoystore.entity.User;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReviewModel {

	private int reviewID;
	
	@NotNull
	private int star;
	
	private String comment;

	private String images;
	
	@NotNull
	@Temporal(TemporalType.TIMESTAMP)
	private Timestamp createdAt;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Timestamp updatedAt;
	
	private UserModel user;

	private ProductModel product;	

	private OrderItemModel orderItem;
}
