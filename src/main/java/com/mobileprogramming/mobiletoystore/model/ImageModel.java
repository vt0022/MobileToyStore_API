package com.mobileprogramming.mobiletoystore.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ImageModel {
	
	private int imageID;
	
	private String imageName;
	
	private String url;
	
	@JsonIgnore
	private ProductModel productModel;
}
