package com.mobileprogramming.mobiletoystore.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mobileprogramming.mobiletoystore.entity.Cart;
import com.mobileprogramming.mobiletoystore.entity.User;

@Repository
public interface ICartRepository extends JpaRepository<Cart, Integer>{

	Optional<Cart> findByUser(User user);
}
