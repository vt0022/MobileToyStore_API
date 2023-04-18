package com.mobileprogramming.mobiletoystore.entity;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor

@Component
@Entity
@Table(name = "OrderItem")
public class OrderItem {

	public static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "orderItemID")
	private int orderItemID;
	
	private int quantity;
	
	private long price;
	
	// Many to one with Order
	@ManyToOne
	@JoinColumn(name = "orderID")
	private Order order;
	
	// Many to one with Product
	@ManyToOne
	@JoinColumn(name = "productID")
	private Product product;
	
	// One to one with review
	@OneToOne(mappedBy = "orderItem", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	private Review review;
}
