package com.mobileprogramming.mobiletoystore.controller;

import java.util.List;
import java.util.Optional;

import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mobileprogramming.mobiletoystore.entity.Image;
import com.mobileprogramming.mobiletoystore.entity.Product;
import com.mobileprogramming.mobiletoystore.model.ImageModel;
import com.mobileprogramming.mobiletoystore.service.IImageService;
import com.mobileprogramming.mobiletoystore.service.IProductService;

@RestController
@RequestMapping("/toystoreapp/product")
public class ImageController {

	@Autowired 
	ModelMapper modelMapper;
	
	@Autowired
	IImageService imageService;
	
	@Autowired
	IProductService productService;
	
	
	@GetMapping("/{productID}/images")
	public ResponseEntity<?> getImagesOfProduct(@PathVariable int productID) {
		Optional<Product> product = productService.findById(productID);

		if (product.isPresent()) {
			List<Image> images = product.get().getImageList();
			List<ImageModel> imageModels = modelMapper.map(images, new TypeToken<List<ImageModel>>() {}.getType());
			return new ResponseEntity<>(imageModels, HttpStatus.OK);
		}
		return new ResponseEntity<>(Optional.empty(), HttpStatus.NOT_FOUND);
	}
}
