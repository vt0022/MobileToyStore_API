package com.mobileprogramming.mobiletoystore.service.impl;

import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.Set;

import jakarta.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.mobileprogramming.mobiletoystore.entity.Cart;
import com.mobileprogramming.mobiletoystore.entity.CartItem;
import com.mobileprogramming.mobiletoystore.entity.Product;
import com.mobileprogramming.mobiletoystore.repository.ICartItemRepository;
import com.mobileprogramming.mobiletoystore.repository.ICartRepository;
import com.mobileprogramming.mobiletoystore.service.ICartItemService;

@Service
public class CartItemServiceImpl implements ICartItemService{
	// Inject repository
	@Autowired
	ICartItemRepository cartItemRepository;
	
	@Autowired
	ICartRepository cartRepository;

	@Override
	public <S extends CartItem> S save(S entity) {
		return cartItemRepository.save(entity);
	}

	@Override
	public List<CartItem> findAll(Sort sort) {
		return cartItemRepository.findAll(sort);
	}

	@Override
	public List<CartItem> findAll() {
		return cartItemRepository.findAll();
	}

	@Override
	public Optional<CartItem> findById(Integer id) {
		return cartItemRepository.findById(id);
	}

	@Override
	public long count() {
		return cartItemRepository.count();
	}

	@Override
	public void deleteById(Integer id) {
		cartItemRepository.deleteById(id);
	}
	
	@Override
	public void delete(CartItem entity) {
		cartItemRepository.delete(entity);
	}

	@Override
	public void deleteAll() {
		cartItemRepository.deleteAll();
	}
	
	@Override
	public List<CartItem> getItemsByCart(int cartID) {
		Optional<Cart>cart = cartRepository.findById(cartID);
		List<CartItem> cartItemList = cart.get().getCartItems();
		cartItemList = Optional.ofNullable(cartItemList).orElse(Collections.emptyList());
		return cartItemList;
	}

	@Override
	public List<CartItem> findByCart(Cart cart) {
		return cartItemRepository.findByCart(cart);
	}

	@Override
	public Optional<CartItem> findByProduct(Product product) {
		return cartItemRepository.findByProduct(product);
	}
	
	
}
