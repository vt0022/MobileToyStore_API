package com.mobileprogramming.mobiletoystore.service;

import java.util.List;
import java.util.Optional;

import com.mobileprogramming.mobiletoystore.entity.Order;

public interface IOrderService {

	long count();

	Optional<Order> findById(Integer id);

	List<Order> findAll();

	<S extends Order> S save(S entity);

}
