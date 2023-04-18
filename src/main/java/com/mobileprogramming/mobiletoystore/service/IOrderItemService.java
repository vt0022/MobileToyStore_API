package com.mobileprogramming.mobiletoystore.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Sort;

import com.mobileprogramming.mobiletoystore.entity.OrderItem;

public interface IOrderItemService {

	void deleteAll();

	void delete(OrderItem entity);

	void deleteById(Integer id);

	long count();

	Optional<OrderItem> findById(Integer id);

	List<OrderItem> findAll();

	List<OrderItem> findAll(Sort sort);

	<S extends OrderItem> S save(S entity);

}
