package com.mobileprogramming.mobiletoystore.model;

import com.fasterxml.jackson.annotation.JsonView;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserAuthenticationModel {

	private String message;
	
	private UserModel data;	
}
