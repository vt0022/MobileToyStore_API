package com.mobileprogramming.mobiletoystore.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mobileprogramming.mobiletoystore.entity.CartItem;

@Repository
public interface ICartItemRepository extends JpaRepository<CartItem, Integer>{

}
