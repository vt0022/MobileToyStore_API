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
	
	@Query("SELECT COUNT(ci) > 0 FROM CartItem ci "
			+ "WHERE ci.cart.cartID = :cartId AND ci.product.productID = :productId")
	boolean existByProduct(int cartID, int productID);
}
