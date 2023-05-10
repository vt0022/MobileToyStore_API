package com.mobileprogramming.mobiletoystore.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mobileprogramming.mobiletoystore.entity.OrderItem;
import com.mobileprogramming.mobiletoystore.entity.Review;

@Repository
public interface IOrderItemRepository extends JpaRepository<OrderItem, Integer>{

	Optional<OrderItem> findByReview(Review review);
}
