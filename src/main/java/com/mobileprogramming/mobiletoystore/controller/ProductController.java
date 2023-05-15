package com.mobileprogramming.mobiletoystore.controller;

import java.util.ArrayList;
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
import com.mobileprogramming.mobiletoystore.model.ImageModel;
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

	@GetMapping("/forsale")
	public ResponseEntity<?> listActiveProducts() {
		List<ProductModel> productModels = productService.findByStatus(true).stream()
				.map(product -> modelMapper.map(product, ProductModel.class)).collect(Collectors.toList());
		return new ResponseEntity<>(productModels, HttpStatus.OK);
	}
	
	@GetMapping("/image")
	public ResponseEntity<?> getImageByProduct(@RequestParam int productID) {
		Optional<Product> product = productService.findById(productID);

		if (product.isPresent()) {
			List<ImageModel> imageModels = modelMapper.map(product.get().getImageList(), 
					new TypeToken<List<ImageModel>>() {}.getType());
			return new ResponseEntity<>(imageModels, HttpStatus.OK);
		}
		return new ResponseEntity<>(Optional.empty(), HttpStatus.NOT_FOUND);
	}

	@GetMapping("/forsale/sort")
	public ResponseEntity<?> getActiveProductsAndSort(@RequestParam int sort) {
		List<Product> products = new ArrayList<>();
		switch (sort) {
		case 1: {
			products = productService.findByStatusOrderByProductNameAsc(true);
			break;
		}
		case 2: {
			products = productService.findByStatusOrderByProductNameDesc(true);
			break;
		}
		case 3: {
			products = productService.findByStatusOrderByPriceAsc(true);
			break;
		}
		case 4: {
			products = productService.findByStatusOrderByPriceDesc(true);
			break;
		}
		default:
			products = productService.findByStatus(true);
			break;
		}
		List<ProductModel> productModels = modelMapper.map(products, new TypeToken<List<ProductModel>>() {
		}.getType());
		return new ResponseEntity<>(productModels, HttpStatus.OK);
	}

	@GetMapping("/forsale/category")
	public ResponseEntity<?> getActiveProductsByCategory(
			@RequestParam(required = false, defaultValue = "0") int categoryID) {
		if (categoryID == 0) { // check if param empty
			List<ProductModel> productModels = productService.findByStatus(true).stream()
					.map(product -> modelMapper.map(product, ProductModel.class)).collect(Collectors.toList());
			return new ResponseEntity<>(productModels, HttpStatus.OK);
		} else {
			Optional<Category> category = categoryService.findById(categoryID);

			if (category.isPresent()) {
				List<Product> products = productService.findByCategoryAndStatus(category.get(), true);
				List<ProductModel> productModels = modelMapper.map(products, new TypeToken<List<ProductModel>>() {
				}.getType());
				return new ResponseEntity<>(productModels, HttpStatus.OK);
			}
		}
		return new ResponseEntity<>(Optional.empty(), HttpStatus.NOT_FOUND);
	}

	@GetMapping("forsale/category/sort")
	public ResponseEntity<?> getActiveProductsByCategoryAndSort(@RequestParam int categoryID, int sort) {
		Optional<Category> category = categoryService.findById(categoryID);
		if (category.isPresent()) {
			List<Product> products = new ArrayList<>();
			switch (sort) {
			case 1: {
				products = productService.findByCategoryAndStatusOrderByProductNameAsc(category.get(), true);
				break;
			}
			case 2: {
				products = productService.findByCategoryAndStatusOrderByProductNameDesc(category.get(), true);
				break;
			}
			case 3: {
				products = productService.findByCategoryAndStatusOrderByPriceAsc(category.get(), true);
				break;
			}
			case 4: {
				products = productService.findByCategoryAndStatusOrderByPriceDesc(category.get(), true);
				break;
			}
			default:
				products = productService.findByCategoryAndStatus(category.get(), true);
				break;
			}
			List<ProductModel> productModels = modelMapper.map(products, new TypeToken<List<ProductModel>>() {}.getType());
			return new ResponseEntity<>(productModels, HttpStatus.OK);
		}
		return new ResponseEntity<>(Optional.empty(), HttpStatus.NOT_FOUND);
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

	@GetMapping("/search")
	public ResponseEntity<?> searchForProducts(
			@RequestParam(value = "q", required = false, defaultValue = "") String searchString) {
		List<Product> foundProducts = productService.searchForProducts(searchString);
		List<ProductModel> gotProducts = modelMapper.map(foundProducts, new TypeToken<List<ProductModel>>() {
		}.getType());
		return new ResponseEntity<>(gotProducts, HttpStatus.OK);
	}
	
	@GetMapping("/search/sort")
	public ResponseEntity<?> searchForProductsAndSort(
			@RequestParam(value = "q", required = false, defaultValue = "") String searchString, @RequestParam int sort) {
		List<Product> foundProducts = productService.searchForProductsAndSort(searchString, sort);
		List<ProductModel> gotProducts = modelMapper.map(foundProducts, new TypeToken<List<ProductModel>>() {
		}.getType());
		return new ResponseEntity<>(gotProducts, HttpStatus.OK);
	}
	
	@GetMapping("/mostpopular")
	public ResponseEntity<?> getMostPopular() {
		List<Product> foundProducts = productService.findTop10Products();
		List<ProductModel> gotProducts = modelMapper.map(foundProducts, new TypeToken<List<ProductModel>>() {
		}.getType());
		return new ResponseEntity<>(gotProducts, HttpStatus.OK);
	}
}
