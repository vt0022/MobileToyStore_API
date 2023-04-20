package com.mobileprogramming.mobiletoystore.entity;

import java.io.Serializable;
import java.sql.Timestamp;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor

@Entity
@Component
public class Review implements Serializable{
	public static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int reviewID;
	
	@NotBlank
	private int star;
	
	private String comment;

	private String images;
	
	@NotNull
	@Temporal(TemporalType.TIMESTAMP)
	private Timestamp createdAt;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Timestamp updatedAt;
	
	// One to one with User
	@OneToOne
	@JoinColumn(name = "userID")
	private User user;
	
	// Many to one with Product
	@ManyToOne
	@JoinColumn(name = "productID")
	private Product product;	
	
	// One to one with OrderItem
	@OneToOne
	@JoinColumn(name = "orderItemID")
	private OrderItem orderItem;
}
