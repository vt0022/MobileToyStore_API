package com.mobileprogramming.mobiletoystore.model;

import java.util.List;

import jakarta.validation.constraints.NotEmpty;

import org.hibernate.validator.constraints.Length;
import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CategoryModel {
	
	private int categoryID;
	
	@NotEmpty
	@Length(min = 5)
	private String categoryName;
	
	private String image;
	
	private MultipartFile imageFile;
	
	private boolean status;
	
	private List<ProductModel> products;
}
