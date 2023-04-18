package com.mobileprogramming.mobiletoystore.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import com.mobileprogramming.mobiletoystore.entity.Category;

public interface ICategoryService {

	void deleteAll();

	void delete(Category entity);

	void deleteById(Integer id);

	long count();

	Optional<Category> findById(Integer id);

	List<Category> findAllById(Iterable<Integer> ids);

	List<Category> findAll();

	Page<Category> findAll(Pageable pageable);

	List<Category> findAll(Sort sort);

	<S extends Category> S save(S entity);
}
