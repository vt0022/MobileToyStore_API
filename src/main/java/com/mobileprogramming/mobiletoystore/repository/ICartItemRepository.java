package com.mobileprogramming.mobiletoystore.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.mobileprogramming.mobiletoystore.entity.Cart;
import com.mobileprogramming.mobiletoystore.entity.CartItem;
import com.mobileprogramming.mobiletoystore.entity.Product;

@Repository
public interface ICartItemRepository extends JpaRepository<CartItem, Integer>{

	List<CartItem> findByCart(Cart cart);
	
	Optional<CartItem> findByProduct(Product product);
}
