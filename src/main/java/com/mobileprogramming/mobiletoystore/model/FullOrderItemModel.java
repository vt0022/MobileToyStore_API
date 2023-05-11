package com.mobileprogramming.mobiletoystore.model;

import java.sql.Timestamp;

import jakarta.annotation.Nullable;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class FullOrderItemModel {
	
	// Order
	private int orderItemID;
	
	private int quantity;
	
	private long price;
	
	// Product
	private int productID;
	
	private String productName;
	
	private String productImage;
	
	// Review	
	private int reviewID;

	private int star;

	private String comment;

	private String reviewImage;
	
	private Timestamp createdAt;
	
	private Timestamp updatedAt;
	
	// User
	private int userID;

	private String firstname;
}
