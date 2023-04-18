package com.mobileprogramming.mobiletoystore.model;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.mobileprogramming.mobiletoystore.entity.Category;

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
	
	private long price;
	
	private String images;
	
	private MultipartFile imageFiles;
	
	private CategoryModel category;
}
