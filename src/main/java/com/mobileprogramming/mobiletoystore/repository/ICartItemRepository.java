package com.mobileprogramming.mobiletoystore.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.mobileprogramming.mobiletoystore.entity.Cart;
import com.mobileprogramming.mobiletoystore.entity.CartItem;

@Repository
public interface ICartItemRepository extends JpaRepository<CartItem, Integer>{

	List<CartItem> findByCart(Cart cart);
}
