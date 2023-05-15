package com.mobileprogramming.mobiletoystore.service;

import java.util.List;
import java.util.Optional;

import com.mobileprogramming.mobiletoystore.entity.Order;
import com.mobileprogramming.mobiletoystore.entity.User;

public interface IOrderService {

	long count();

	Optional<Order> findById(Integer id);

	List<Order> findAll();

	<S extends Order> S save(S entity);

	List<Order>findByUserOrderByOrderedDateDesc(User user);

	List<Order> findByStatusAndDateOrderByOrderedDateDesc(int status, int month, int year);

	List<Order> findByStatusOrderByOrderedDateDesc(int status);

	List<Order> findAllByOrderByOrderedDateDesc();

	List<Order> findByDateOrderByOrderedDateDesc(int month, int year);

	List<Order> findAllDesc();
}
