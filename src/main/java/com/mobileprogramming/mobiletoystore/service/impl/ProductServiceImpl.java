package com.mobileprogramming.mobiletoystore.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.mobileprogramming.mobiletoystore.entity.Category;
import com.mobileprogramming.mobiletoystore.entity.Product;
import com.mobileprogramming.mobiletoystore.entity.Review;
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
		List<Product> allProducts = productRepository.findByStatus(true);
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
	public List<Product>searchForProductsAndSort(String searchString, int sort) {
		List<Product> allProducts = new ArrayList<>();
		switch (sort) {
		case 1: {
			allProducts = productRepository.findByStatusOrderByProductNameAsc(true);
			break;
		}
		case 2: {
			allProducts = productRepository.findByStatusOrderByProductNameDesc(true);
			break;
		}
		case 3: {
			allProducts = productRepository.findByStatusOrderByPriceAsc(true);
			break;
		}
		case 4: {
			allProducts = productRepository.findByStatusOrderByPriceDesc(true);
			break;
		}
		default:
			allProducts = productRepository.findByStatus(true);
			break;
		}

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
	
	@Override
	public List<Product> findByCategory(Category category) {
		return productRepository.findByCategory(category);
	}

	@Override
	public List<Product> findByStatus(boolean status) {
		return productRepository.findByStatus(status);
	}

	@Override
	public List<Product> findByCategoryAndStatus(Category category, boolean status) {
		return productRepository.findByCategoryAndStatus(category, status);
	}

	@Override
	public List<Product> findByCategoryAndStatusOrderByProductNameAsc(Category category, boolean status) {
		return productRepository.findByCategoryAndStatusOrderByProductNameAsc(category, status);
	}

	@Override
	public List<Product> findByCategoryAndStatusOrderByProductNameDesc(Category category, boolean status) {
		return productRepository.findByCategoryAndStatusOrderByProductNameDesc(category, status);
	}

	@Override
	public List<Product> findByCategoryAndStatusOrderByPriceAsc(Category category, boolean status) {
		return productRepository.findByCategoryAndStatusOrderByPriceAsc(category, status);
	}

	@Override
	public List<Product> findByCategoryAndStatusOrderByPriceDesc(Category category, boolean status) {
		return productRepository.findByCategoryAndStatusOrderByPriceDesc(category, status);
	}

	@Override
	public List<Product> findByStatusOrderByProductNameAsc(boolean status) {
		return productRepository.findByStatusOrderByProductNameAsc(status);
	}

	@Override
	public List<Product> findByStatusOrderByProductNameDesc(boolean status) {
		return productRepository.findByStatusOrderByProductNameDesc(status);
	}

	@Override
	public List<Product> findByStatusOrderByPriceAsc(boolean status) {
		return productRepository.findByStatusOrderByPriceAsc(status);
	}

	@Override
	public List<Product> findByStatusOrderByPriceDesc(boolean status) {
		return productRepository.findByStatusOrderByPriceDesc(status);
	}	
}
