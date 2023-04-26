package com.mobileprogramming.mobiletoystore.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mobileprogramming.mobiletoystore.entity.Category;
import com.mobileprogramming.mobiletoystore.entity.Product;

@Repository
public interface IProductRepository extends JpaRepository<Product, Integer>{
	List<Product> findByCategory(Category category);
}
