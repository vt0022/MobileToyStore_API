package com.mobileprogramming.mobiletoystore.model;

import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.FetchType;
import jakarta.persistence.OneToMany;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonView;
import com.mobileprogramming.mobiletoystore.entity.CartItem;
import com.mobileprogramming.mobiletoystore.entity.Category;
import com.mobileprogramming.mobiletoystore.entity.OrderItem;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductModel {
	
	private int productID;
	
	private String productName;
	
	private String description;
	
	private int quantity;
	
	private long price;
	
	private String images;

	private boolean status;
	
	@JsonIgnore
	private CategoryModel category;
	
	@JsonIgnore
	private List<CartItemModel> cartItems;

	@JsonIgnore
	private List<OrderItemModel> orderItems;
	
	private List<ImageModel> imageList;

	@JsonIgnore
	private List<ReviewModel> reviews;
}
