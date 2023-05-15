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
	List<Order> findByUserOrderByOrderedDateDesc(User user);
	
	List<Order> findByStatusOrderByOrderedDateDesc(int status); 
	
	List<Order> findAllByOrderByOrderedDateDesc();
	
	@Query("SELECT o FROM Order o WHERE FUNCTION('MONTH', o.orderedDate) = :month "
			+ "AND FUNCTION('YEAR', o.orderedDate) = :year ORDER BY o.orderedDate DESC")
	List<Order> findByDateOrderByOrderedDateDesc(int month, int year);
	
	@Query("SELECT o FROM Order o WHERE o.status = :status "
			+ "AND FUNCTION('MONTH', o.orderedDate) = :month "
			+ "AND FUNCTION('YEAR', o.orderedDate) = :year ORDER BY o.orderedDate DESC")
	List<Order> findByStatusAndDateOrderByOrderedDateDesc(int status, int month, int year); 
}
