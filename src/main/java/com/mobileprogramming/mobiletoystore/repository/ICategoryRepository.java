package com.mobileprogramming.mobiletoystore.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mobileprogramming.mobiletoystore.entity.Category;

@Repository
public interface ICategoryRepository extends JpaRepository<Category, Integer>{
	List<Category> findByStatus(boolean status);
}
