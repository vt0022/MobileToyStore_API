package com.mobileprogramming.mobiletoystore.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mobileprogramming.mobiletoystore.entity.OrderItem;

@Repository
public interface IOrderItemRepository extends JpaRepository<OrderItem, Integer>{

}
