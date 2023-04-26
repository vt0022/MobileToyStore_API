package com.mobileprogramming.mobiletoystore.entity;

import java.io.Serializable;
import java.util.List;

import jakarta.annotation.Generated;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

import org.hibernate.annotations.Comment;
import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor

@Component
@Entity
public class Image implements Serializable{
	
	public static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int imageID;
	
	private String imageName;
	
	private String url;
	
	// Many to one with Product
	@ManyToOne
	@JoinColumn(name = "productID")
	private Product product;
}
