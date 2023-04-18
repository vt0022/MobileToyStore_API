package com.mobileprogramming.mobiletoystore.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mobileprogramming.mobiletoystore.entity.Order;

@Repository
public interface IOrderRepository extends JpaRepository<Order, Integer>{

}
