package com.mobileprogramming.mobiletoystore.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotBlank;

import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor

@Component
@Entity
@Table(name = "CartItem")
public class CartItem {

	public static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "cartItemID")
	private int cartItemID;
	
	@NotBlank
	private int quantity;
	
	// Many to one with Cart
	@ManyToOne
	@JoinColumn(name = "cartID")
	private Cart cart;
	
	// Many to one with Product
	@ManyToOne
	@JoinColumn(name = "productID")
	private Product product;
	
}
