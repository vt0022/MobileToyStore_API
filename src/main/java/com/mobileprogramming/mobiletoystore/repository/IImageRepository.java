package com.mobileprogramming.mobiletoystore.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mobileprogramming.mobiletoystore.entity.Image;
import com.mobileprogramming.mobiletoystore.entity.Product;

@Repository
public interface IImageRepository extends JpaRepository<Image, Integer>{

	List<Image> findByProduct(Product product);
}
