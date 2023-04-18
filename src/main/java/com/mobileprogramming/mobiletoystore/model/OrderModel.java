package com.mobileprogramming.mobiletoystore.model;

import java.sql.Timestamp;
import java.util.List;

import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.mobileprogramming.mobiletoystore.entity.OrderItem;
import com.mobileprogramming.mobiletoystore.entity.User;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderModel {

	private int orderID;
	
	@NotNull
	private Timestamp orderedDate;
	
	private Timestamp receivedDate;
	
	private Timestamp cancelledDate;
	
	private int status; // 0 for pending pay; 1 for delivering; 2 for received; 3 for cancelled
	
	private String receiverName;
	
	private String phone;
	
	private String address;
	
	private long total;

	private UserModel user;
	
	private List<OrderItemModel> orderItems;
}
