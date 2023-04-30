package com.mobileprogramming.mobiletoystore.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Sort;

import com.mobileprogramming.mobiletoystore.entity.Cart;
import com.mobileprogramming.mobiletoystore.entity.CartItem;

public interface ICartItemService {

	void deleteAll();

	void delete(CartItem entity);

	void deleteById(Integer id);

	long count();

	Optional<CartItem> findById(Integer id);

	List<CartItem> findAll();

	List<CartItem> findAll(Sort sort);

	<S extends CartItem> S save(S entity);

	List<CartItem> getItemsByCart(int cartID);

	List<CartItem> findByCart(Cart cart);
}
