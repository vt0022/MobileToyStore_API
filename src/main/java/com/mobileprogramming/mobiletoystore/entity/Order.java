package com.mobileprogramming.mobiletoystore.entity;

import java.sql.Timestamp;
import java.util.List;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.validation.constraints.NotNull;

import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor

@Component
@Entity
public class Order {

	public static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
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
	
	// Many to one with User
	@ManyToOne
	@JoinColumn(name = "userID")
	private User user;
	
	// One to many with OrderItem
	@OneToMany(mappedBy = "order")
	private List<OrderItem> orderItems;
}
