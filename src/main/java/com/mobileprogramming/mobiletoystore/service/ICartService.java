package com.mobileprogramming.mobiletoystore.service;

import java.util.List;
import java.util.Optional;

import com.mobileprogramming.mobiletoystore.entity.Cart;
import com.mobileprogramming.mobiletoystore.entity.User;

public interface ICartService {

	void deleteById(Integer id);

	long count();

	boolean existsById(Integer id);

	Optional<Cart> findById(Integer id);

	<S extends Cart> S save(S entity);

	Optional<Cart> findByUser(User user);

}
