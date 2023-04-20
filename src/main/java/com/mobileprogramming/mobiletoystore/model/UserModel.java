package com.mobileprogramming.mobiletoystore.model;

import java.sql.Timestamp;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonView;
import com.mobileprogramming.mobiletoystore.entity.Cart;
import com.mobileprogramming.mobiletoystore.entity.Order;
import com.mobileprogramming.mobiletoystore.entity.User;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserModel {

	private int userID;
	
	private String firstname;

	private String lastname;
	
	private int Gender; // 0 for male; 1 for female; 2 for other
	
	@Temporal(TemporalType.TIMESTAMP)
	private Timestamp birthDay;

	@NotBlank(message = "Không được để trống email!")
	private String email;
	
	private String address;
	
	private String phone;
	
	private String image;
	
	private boolean role; // 0 for manager; 1 for customer
	
	private boolean status; // 0 for inactive; 1 for active

	@NotBlank(message = "Không được để trống tên người dùng!")
	private String username;
	
	@JsonView(UserModel.class)
	@NotBlank(message = "Không được để trống mật khẩu!")
	@Length(min = 8, message = "Mật khẩu cần chứa ít nhất 8 ký tự!")
	private String password;
	
	@NotNull
	@Temporal(TemporalType.TIMESTAMP)
	private Timestamp createdAt;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Timestamp updatedAt;
	
	@JsonView(UserModel.class)
	private Cart cart;
	
	@JsonView(UserModel.class)
	private List<Order> orders;
}
