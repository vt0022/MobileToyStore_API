package com.mobileprogramming.mobiletoystore.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mobileprogramming.mobiletoystore.entity.Category;

@Repository
public interface ICategoryRepository extends JpaRepository<Category, Integer>{

}
