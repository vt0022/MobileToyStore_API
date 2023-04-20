package com.mobileprogramming.mobiletoystore.entity;

import java.io.Serializable;
import java.util.List;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor

@Component
@Entity
public class Category implements Serializable {
	
	public static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int categoryID;
	
	//@Column(columnDefinition = "NVARCHAR(200) NOT NULL")
	@NotBlank
	private String categoryName;
	
	//@Column(columnDefinition = "NVARCHAR(200)")
	private String image;
	
	//@Column
	private boolean status;
	
	@JsonIgnore
	// One to many with Product
	@OneToMany(mappedBy = "category", cascade = CascadeType.ALL)
	private List<Product> products;

}
