package com.mobileprogramming.mobiletoystore.controller;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collector;
import java.util.stream.Collectors;

import org.modelmapper.ModelMapper;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mobileprogramming.mobiletoystore.entity.Category;
import com.mobileprogramming.mobiletoystore.model.CategoryModel;
import com.mobileprogramming.mobiletoystore.service.ICategoryService;

@RestController
@RequestMapping("/toystoreapp/category")
public class CategoryController {

	@Autowired
	ModelMapper modelMapper;
	
	@Autowired
	ICategoryService categoryService;
	
	@GetMapping(path = {"/all", ""})
	public List<CategoryModel> listCategories() {
		return categoryService.findAll().stream().map(category -> modelMapper
				.map(category, CategoryModel.class)).collect(Collectors.toList());
	}
	
	@GetMapping("/forsale")
	public List<CategoryModel> listActiveCategories() {
		return categoryService.findByStatus(true).stream().map(category -> modelMapper
				.map(category, CategoryModel.class)).collect(Collectors.toList());
	}
	
	@GetMapping("/{categoryID}")
	public ResponseEntity<CategoryModel> getCategoryByID(@PathVariable int categoryID) {
		Optional<Category> category = categoryService.findById(categoryID);
		
		if(category.isPresent()) {		
			CategoryModel categoryModel = modelMapper.map(category.get(), CategoryModel.class);
			return new ResponseEntity<>(categoryModel, HttpStatus.OK);
		}
		
		return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	}
	
	@PostMapping("/create")
	public ResponseEntity<CategoryModel> createCategory(@RequestBody CategoryModel category) {
		Category newCategory = modelMapper.map(category, Category.class);
		newCategory = categoryService.save(newCategory);
		return new ResponseEntity<>(modelMapper.map(newCategory, CategoryModel.class), HttpStatus.CREATED);
	}
	
	@PutMapping("/update/{categoryID}")
	public ResponseEntity<CategoryModel> updateCategory(@PathVariable int categoryID, @RequestBody CategoryModel category){
		Optional<Category> oldCategory = categoryService.findById(categoryID);
		
		if(oldCategory.isPresent()) {
			Category newCategory = oldCategory.get();
			newCategory = modelMapper.map(category, Category.class);
			newCategory = categoryService.save(newCategory);
			return new ResponseEntity<>(modelMapper.map(newCategory, CategoryModel.class), HttpStatus.OK);
		}	
		return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	}
	
	@DeleteMapping("/delete/{categoryID}")
	public ResponseEntity<Void> deleteCategory(@PathVariable int categoryID){
		categoryService.deleteById(categoryID);
		return new ResponseEntity<>(HttpStatus.OK);
	}
}
