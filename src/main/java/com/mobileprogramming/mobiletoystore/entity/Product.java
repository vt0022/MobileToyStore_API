package com.mobileprogramming.mobiletoystore.entity;

import java.io.Serializable;
import java.util.List;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;

import org.springframework.stereotype.Component;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor

@Entity 
@Component
public class Product implements Serializable{
	
	public static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int productID;
	
	@NotBlank
	private String productName;
	
	private String description;

	private String images;
	
	private boolean status;
	
	private long price;
	// Thiếu quantity
	// Many to one with Category
	@ManyToOne
	@JoinColumn(name = "categoryID")
	private Category category;
	
	// One to many with CartItem
	@OneToMany(mappedBy = "product", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	private List<CartItem> cartItems;
	
	// One to many with OrderItem
	@OneToMany(mappedBy = "product", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	private List<OrderItem> orderItems;
	
	// One to many with Review
	@OneToMany(mappedBy = "product", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	private List<Review> reviews; 
}
