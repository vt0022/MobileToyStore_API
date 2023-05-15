package com.mobileprogramming.mobiletoystore.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
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
	public List<Order> findByUserOrderByOrderedDateDesc(User user) {
		return orderRepository.findByUserOrderByOrderedDateDesc(user);
	}

	@Override
	public List<Order> findByStatusOrderByOrderedDateDesc(int status) {
		return orderRepository.findByStatusOrderByOrderedDateDesc(status);
	}

	@Override
	public List<Order> findByStatusAndDateOrderByOrderedDateDesc(int status, int month, int year) {
		return orderRepository.findByStatusAndDateOrderByOrderedDateDesc(status, month, year);
	}
	
	@Override
	public List<Order> findAllByOrderByOrderedDateDesc() {
		return orderRepository.findAllByOrderByOrderedDateDesc();
	}

	@Override
	public List<Order> findByDateOrderByOrderedDateDesc(int month, int year) {
		return orderRepository.findByDateOrderByOrderedDateDesc(month, year);
	}
	
	@Override
	public List<Order>findAllDesc() {
		Sort sort = Sort.by(Sort.Direction.DESC, "orderedDate");
		return orderRepository.findAll(sort);
	}
	
}
