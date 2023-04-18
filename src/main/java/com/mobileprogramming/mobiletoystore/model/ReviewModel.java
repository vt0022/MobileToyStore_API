package com.mobileprogramming.mobiletoystore.model;

import java.sql.Timestamp;

import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.validation.constraints.NotNull;

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
	
	private int star;
	
	private String comment;

	private String images;
	
	@NotNull
	@Temporal(TemporalType.TIMESTAMP)
	private Timestamp createdAt;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Timestamp updatedAt;
	
	private User user;

	private Product product;	
	
	private OrderItem orderItem;
}
