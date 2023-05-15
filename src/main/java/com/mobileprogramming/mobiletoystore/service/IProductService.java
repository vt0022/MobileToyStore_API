package com.mobileprogramming.mobiletoystore.service;

import java.awt.print.Pageable;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Sort;

import com.mobileprogramming.mobiletoystore.entity.Category;
import com.mobileprogramming.mobiletoystore.entity.Product;
import com.mobileprogramming.mobiletoystore.entity.Review;

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

	List<Product> findByStatus(boolean status);

	List<Product> findByCategoryAndStatus(Category category, boolean status);

	List<Product> findByCategoryAndStatusOrderByPriceDesc(Category category, boolean status);

	List<Product> findByCategoryAndStatusOrderByPriceAsc(Category category, boolean status);

	List<Product> findByCategoryAndStatusOrderByProductNameDesc(Category category, boolean status);

	List<Product> findByCategoryAndStatusOrderByProductNameAsc(Category category, boolean status);

	List<Product> findByStatusOrderByPriceDesc(boolean status);

	List<Product> findByStatusOrderByPriceAsc(boolean status);

	List<Product> findByStatusOrderByProductNameDesc(boolean status);

	List<Product> findByStatusOrderByProductNameAsc(boolean status);

	List<Product> searchForProductsAndSort(String searchString, int sort);

	List<Product> findTop10Products();

}
