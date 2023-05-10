package com.mobileprogramming.mobiletoystore.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.mobileprogramming.mobiletoystore.entity.OrderItem;
import com.mobileprogramming.mobiletoystore.entity.Review;
import com.mobileprogramming.mobiletoystore.repository.IOrderItemRepository;
import com.mobileprogramming.mobiletoystore.service.IOrderItemService;

@Service
public class OrderItemServiceImpl implements IOrderItemService{
	@Autowired
	IOrderItemRepository orderItemRepository;

	@Override
	public <S extends OrderItem> S save(S entity) {
		return orderItemRepository.save(entity);
	}

	@Override
	public List<OrderItem> findAll(Sort sort) {
		return orderItemRepository.findAll(sort);
	}

	@Override
	public List<OrderItem> findAll() {
		return orderItemRepository.findAll();
	}

	@Override
	public Optional<OrderItem> findById(Integer id) {
		return orderItemRepository.findById(id);
	}

	@Override
	public long count() {
		return orderItemRepository.count();
	}

	@Override
	public void deleteById(Integer id) {
		orderItemRepository.deleteById(id);
	}

	@Override
	public void delete(OrderItem entity) {
		orderItemRepository.delete(entity);
	}

	@Override
	public void deleteAll() {
		orderItemRepository.deleteAll();
	}

	@Override
	public Optional<OrderItem> findByReview(Review review) {
		return orderItemRepository.findByReview(review);
	}	
	
	
}
