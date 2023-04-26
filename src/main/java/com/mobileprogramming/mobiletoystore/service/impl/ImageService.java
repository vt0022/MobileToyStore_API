package com.mobileprogramming.mobiletoystore.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mobileprogramming.mobiletoystore.entity.Image;
import com.mobileprogramming.mobiletoystore.entity.Product;
import com.mobileprogramming.mobiletoystore.repository.IImageRepository;
import com.mobileprogramming.mobiletoystore.service.IImageService;

@Service
public class ImageService implements IImageService{
	@Autowired
	IImageRepository imageRepository;

	@Override
	public List<Image> findByProduct(Product product) {
		return imageRepository.findByProduct(product);
	}
	
	

}
