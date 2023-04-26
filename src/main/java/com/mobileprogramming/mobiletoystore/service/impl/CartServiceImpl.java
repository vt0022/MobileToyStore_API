package com.mobileprogramming.mobiletoystore.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mobileprogramming.mobiletoystore.entity.Cart;
import com.mobileprogramming.mobiletoystore.entity.User;
import com.mobileprogramming.mobiletoystore.repository.ICartRepository;
import com.mobileprogramming.mobiletoystore.service.ICartService;

@Service
public class CartServiceImpl implements ICartService{
	// Inject repository
	@Autowired
	ICartRepository cartRepository;

	@Override
	public <S extends Cart> S save(S entity) {
		return cartRepository.save(entity);
	}

	@Override
	public Optional<Cart> findById(Integer id) {
		return cartRepository.findById(id);
	}

	@Override
	public boolean existsById(Integer id) {
		return cartRepository.existsById(id);
	}

	@Override
	public long count() {
		return cartRepository.count();
	}

	@Override
	public void deleteById(Integer id) {
		cartRepository.deleteById(id);
	}

	@Override
	public Optional<Cart> findByUser(User user) {
		return cartRepository.findByUser(user);
	}
	
}
