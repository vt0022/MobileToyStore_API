package com.mobileprogramming.mobiletoystore.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.mobileprogramming.mobiletoystore.entity.Order;
import com.mobileprogramming.mobiletoystore.entity.User;

@Repository
public interface IOrderRepository extends JpaRepository<Order, Integer>{

	@Query("SELECT o FROM Order o WHERE o.user = :user ORDER BY o.orderedDate DESC")
	List<Order> findAllByUserByOrderedDateDesc(User user);
}
