package com.mobileprogramming.mobiletoystore.repository;

import java.awt.print.Pageable;
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
	
	//@Query("SELECT p FROM Product p WHERE p.category = :category AND p.status = :status")
	List<Product> findByCategoryAndStatus(Category category, boolean status); 
	
//	@Query("SELECT p FROM Product p WHERE p.category = :category AND p.status = :status ORDER BY :field ASC")
//	List<Product> findByCategoryAndStatusAndSortAsc(Category category, boolean status, String field); 
	List<Product>findByCategoryAndStatusOrderByProductNameAsc(Category category, boolean status);
	
	List<Product>findByCategoryAndStatusOrderByProductNameDesc(Category category, boolean status);
	
	List<Product>findByCategoryAndStatusOrderByPriceAsc(Category category, boolean status);
	
	List<Product>findByCategoryAndStatusOrderByPriceDesc(Category category, boolean status);
	
	List<Product> findByStatusOrderByProductNameAsc(boolean status);
	
	List<Product> findByStatusOrderByProductNameDesc(boolean status);
	
	List<Product> findByStatusOrderByPriceAsc(boolean status);
	
	List<Product> findByStatusOrderByPriceDesc(boolean status);
	
	@Query("SELECT p FROM Product p LEFT JOIN p.orderItems oi WHERE p.status = 1 GROUP BY p.productID ORDER BY COUNT(oi) DESC")
    List<Product> findTop10Products();
}
