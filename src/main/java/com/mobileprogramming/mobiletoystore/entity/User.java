package com.mobileprogramming.mobiletoystore.entity;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;
import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor

@Entity
@Component
public class User implements Serializable{

	public static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int userID;
	
	@NotBlank(message = "Không được để trống tên!")
	private String firstname;

	private String lastname;
	
	private int Gender; // 0 for male; 1 for female; 2 for other
	
	@Temporal(TemporalType.TIMESTAMP)
	private Timestamp birthDay;
	
	@Column(unique = true)
	@NotBlank(message = "Không được để trống email!")
	private String email;
	
	private String address;
	
	private String phone;
	
	private String image;
	
	private boolean role; // 0 for manager; 1 for customer
	
	private boolean status; // 0 for inactive; 1 for active
	
	@Column(unique = true)
	@NotBlank(message = "Không được để trống tên người dùng!")
	private String username;
	
	@NotBlank(message = "Không được để trống mật khẩu!")
	private String password;
	
	@NotNull
	@Temporal(TemporalType.TIMESTAMP)
	private Timestamp createdAt;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Timestamp updatedAt;
	
	// One to one with Cart
	@OneToOne(mappedBy = "user", cascade = CascadeType.ALL)
	private Cart cart;
	
	// One to many with Order
	@OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
	private List<Order> orders;
	
	// One to many with Review
	@OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
	private List<Review> reviews;
}
