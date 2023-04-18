package com.mobileprogramming.mobiletoystore.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.mobileprogramming.mobiletoystore.entity.Product;
import com.mobileprogramming.mobiletoystore.model.ProductModel;
import com.mobileprogramming.mobiletoystore.repository.IProductRepository;
import com.mobileprogramming.mobiletoystore.service.IProductService;

@Service
public class ProductServiceImpl implements IProductService {
	@Autowired
	IProductRepository productRepository;

	@Override
	public <S extends Product> S save(S entity) {
		return productRepository.save(entity);
	}

	@Override
	public List<Product> findAll(Sort sort) {
		return productRepository.findAll(sort);
	}

	@Override
	public List<Product> findAll() {
		return productRepository.findAll();
	}

	@Override
	public Optional<Product> findById(Integer id) {
		return productRepository.findById(id);
	}
	
	@Override
	public List<Product>searchForProducts(String searchString) {
		List<Product> allProducts = productRepository.findAll();
		List<Product> foundProducts = new ArrayList<>();
		for (Product product : allProducts) {
			if (product.getProductName().toLowerCase().contains(searchString.toLowerCase())
					|| product.getDescription().toLowerCase().contains(searchString.toLowerCase())) {
				foundProducts.add(product);
			}
		}
		return foundProducts;
	}

	@Override
	public boolean existsById(Integer id) {
		return productRepository.existsById(id);
	}

	@Override
	public long count() {
		return productRepository.count();
	}

	@Override
	public void deleteById(Integer id) {
		productRepository.deleteById(id);
	}

	@Override
	public void deleteAll() {
		productRepository.deleteAll();
	}
	
	
}
