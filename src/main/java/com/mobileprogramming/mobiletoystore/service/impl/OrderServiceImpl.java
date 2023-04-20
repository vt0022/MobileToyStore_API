package com.mobileprogramming.mobiletoystore.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mobileprogramming.mobiletoystore.entity.Order;
import com.mobileprogramming.mobiletoystore.entity.User;
import com.mobileprogramming.mobiletoystore.repository.IOrderRepository;
import com.mobileprogramming.mobiletoystore.service.IOrderService;

@Service
public class OrderServiceImpl implements IOrderService {
	@Autowired
	IOrderRepository orderRepository;

	@Override
	public <S extends Order> S save(S entity) {
		return orderRepository.save(entity);
	}

	@Override
	public List<Order> findAll() {
		return orderRepository.findAll();
	}

	@Override
	public Optional<Order> findById(Integer id) {
		return orderRepository.findById(id);
	}

	@Override
	public long count() {
		return orderRepository.count();
	}
	
	@Override
	public List<Order> findByUser(User user) {
		return orderRepository.findByUser(user);
	}
	
}
