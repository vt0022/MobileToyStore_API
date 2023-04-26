package com.mobileprogramming.mobiletoystore.service;

import java.util.List;

import com.mobileprogramming.mobiletoystore.entity.Image;
import com.mobileprogramming.mobiletoystore.entity.Product;

public interface IImageService {

	List<Image> findByProduct(Product product);

}
