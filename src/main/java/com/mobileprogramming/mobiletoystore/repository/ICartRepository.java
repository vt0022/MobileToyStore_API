package com.mobileprogramming.mobiletoystore.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mobileprogramming.mobiletoystore.entity.Cart;

@Repository
public interface ICartRepository extends JpaRepository<Cart, Integer>{

}
