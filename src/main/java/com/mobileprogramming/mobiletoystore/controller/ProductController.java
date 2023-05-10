package com.mobileprogramming.mobiletoystore.controller;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.mobileprogramming.mobiletoystore.entity.Category;
import com.mobileprogramming.mobiletoystore.entity.OrderItem;
import com.mobileprogramming.mobiletoystore.entity.Product;
import com.mobileprogramming.mobiletoystore.entity.Review;
import com.mobileprogramming.mobiletoystore.model.ProductModel;
import com.mobileprogramming.mobiletoystore.model.ReviewModel;
import com.mobileprogramming.mobiletoystore.service.ICategoryService;
import com.mobileprogramming.mobiletoystore.service.IOrderItemService;
import com.mobileprogramming.mobiletoystore.service.IProductService;
import com.mobileprogramming.mobiletoystore.service.IReviewService;

@RestController
@RequestMapping("/toystoreapp/product")
public class ProductController {

	@Autowired
	ModelMapper modelMapper;

	@Autowired
	IProductService productService;

	@Autowired
	ICategoryService categoryService;
	
	@Autowired
	IReviewService reviewService;
	
	@Autowired
	IOrderItemService orderItemService;

	@GetMapping("/all")
	public ResponseEntity<?> listProducts() {
		List<ProductModel> productModels = productService.findAll().stream()
				.map(product -> modelMapper.map(product, ProductModel.class)).collect(Collectors.toList());
		return new ResponseEntity<>(productModels, HttpStatus.OK);
	}

	@GetMapping("/{productID}")
	public ResponseEntity<?> getProductsByID(@PathVariable int productID) {
		Optional<Product> product = productService.findById(productID);

		if (product.isPresent()) {
			ProductModel productModel = modelMapper.map(product.get(), ProductModel.class);
			return new ResponseEntity<>(productModel, HttpStatus.OK);
		}
		return new ResponseEntity<>(Optional.empty(), HttpStatus.NOT_FOUND);
	}
	
	@GetMapping("/review")
	public ResponseEntity<?> getProductByReview(@RequestParam int reviewID) {
		Review review = reviewService.findById(reviewID).get();
		Product product = review.getProduct();
		ProductModel productModel = modelMapper.map(product, ProductModel.class);
		return new ResponseEntity<>(productModel, HttpStatus.OK);
	}
	
	@GetMapping("/orderitem")
	public ResponseEntity<?> getProductByOrderItem(@RequestParam int orderItemID) {
		OrderItem orderItem = orderItemService.findById(orderItemID).get();
		Product product = orderItem.getProduct();
		ProductModel productModel = modelMapper.map(product, ProductModel.class);
		return new ResponseEntity<>(productModel, HttpStatus.OK);
	}

	@GetMapping()
	public ResponseEntity<?> getProductsByCategory(@RequestParam(required = false, defaultValue = "0") int categoryID) {
		if (categoryID == 0) { // check if param empty
			List<ProductModel> productModels = productService.findAll().stream()
					.map(product -> modelMapper.map(product, ProductModel.class)).collect(Collectors.toList());
			return new ResponseEntity<>(productModels, HttpStatus.OK);
		} else {
			Optional<Category> category = categoryService.findById(categoryID);

			if (category.isPresent()) {
				List<Product> products = productService.findByCategory(category.get());
				List<ProductModel> productModels = modelMapper.map(products, new TypeToken<List<ProductModel>>() {}.getType());
				return new ResponseEntity<>(productModels, HttpStatus.OK);
			}
		}
		return new ResponseEntity<>(Optional.empty(), HttpStatus.NOT_FOUND);
	}

	@GetMapping("/search")
	public ResponseEntity<?> searchForProducts(
			@RequestParam(value = "q", required = false, defaultValue = "") String searchString) {
		List<Product> foundProducts = productService.searchForProducts(searchString);
		List<ProductModel> gotProducts = modelMapper.map(foundProducts, new TypeToken<List<ProductModel>>() {
		}.getType());
		return new ResponseEntity<>(gotProducts, HttpStatus.OK);
	}

	// Update quantity
}
