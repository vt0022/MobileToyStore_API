package com.mobileprogramming.mobiletoystore;

import java.util.HashMap;
import java.util.Map;

import org.hibernate.boot.model.naming.ImplicitNamingStrategy;
import org.hibernate.boot.model.naming.ImplicitNamingStrategyLegacyJpaImpl;
import org.hibernate.boot.model.naming.PhysicalNamingStrategy;
import org.hibernate.boot.model.naming.PhysicalNamingStrategyStandardImpl;
import org.modelmapper.ModelMapper;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

@SpringBootApplication
public class MobileToyStoreApplication {

	@Bean
    public ModelMapper modelMapper() {
        return new ModelMapper();
    }
	
	@Bean
	public PhysicalNamingStrategy physical() {
	    return new PhysicalNamingStrategyStandardImpl();
	}

	@Bean
	public Cloudinary cloudinary() {
		// Configure
		Map<String, String> config = new HashMap<String, String>();
		config.put("cloud_name", "dx8k8cjdq");
		config.put("api_key", "495478988912747");
		config.put("api_secret", "90xd1xw4Ck3qlCaitFDUBMzM4e4");
		Cloudinary cloudinary = new Cloudinary(config);
		return cloudinary;
	}
	
	
	public static void main(String[] args) {
		SpringApplication.run(MobileToyStoreApplication.class, args);
	}

}
