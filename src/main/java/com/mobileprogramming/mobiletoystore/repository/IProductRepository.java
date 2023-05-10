package com.mobileprogramming.mobiletoystore.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.mobileprogramming.mobiletoystore.entity.Category;
import com.mobileprogramming.mobiletoystore.entity.Product;
import com.mobileprogramming.mobiletoystore.entity.Review;

@Repository
public interface IProductRepository extends JpaRepository<Product, Integer>{
	List<Product> findByCategory(Category category);
	
	List<Product> findByStatus(boolean status);
	
	@Query("SELECT p FROM Product p WHERE p.category = :category AND p.status = :status")
	List<Product> findByCategoryAndStatus(Category category, boolean status); 
	
	@Query("SELECT p FROM Product p WHERE p.category = :category AND p.status = :status ORDER BY :field ASC")
	List<Product> findByCategoryAndStatusAndSortAsc(Category category, boolean status, String field); 
}
