package com.mobileprogramming.mobiletoystore.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Sort;

import com.mobileprogramming.mobiletoystore.entity.Category;
import com.mobileprogramming.mobiletoystore.entity.Product;

public interface IProductService {

	void deleteAll();

	void deleteById(Integer id);

	long count();

	boolean existsById(Integer id);

	Optional<Product> findById(Integer id);

	List<Product> findAll();

	List<Product> findAll(Sort sort);

	<S extends Product> S save(S entity);

	List<Product> searchForProducts(String searchString);

	List<Product> findByCategory(Category category); 
}
