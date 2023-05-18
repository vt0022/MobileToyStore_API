package com.mobileprogramming.mobiletoystore.controller;

import java.sql.Timestamp;
import java.util.*;

import com.mobileprogramming.mobiletoystore.model.*;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.mobileprogramming.mobiletoystore.entity.Order;
import com.mobileprogramming.mobiletoystore.entity.OrderItem;
import com.mobileprogramming.mobiletoystore.entity.Review;
import com.mobileprogramming.mobiletoystore.service.IOrderItemService;
import com.mobileprogramming.mobiletoystore.service.IOrderService;
import com.mobileprogramming.mobiletoystore.service.IReviewService;

@RestController
@RequestMapping("/toystoreapp/orderitem")
public class OrderItemController {

    @Autowired
    ModelMapper modelMapper;

    @Autowired
    IReviewService reviewService;

    @Autowired
    IOrderItemService orderItemService;

    @Autowired
    IOrderService orderService;

    @GetMapping("/review")
    public ResponseEntity<?> getOrderItemByReview(@RequestParam int reviewID) {
        Review review = reviewService.findById(reviewID).get();
        OrderItem orderItem = review.getOrderItem();
        OrderItemModel orderItemModel = modelMapper.map(orderItem, OrderItemModel.class);
        return new ResponseEntity<>(orderItemModel, HttpStatus.OK);
    }

    @GetMapping("")
    public ResponseEntity<?> getOrderItemByOrder(@RequestParam int orderID) {
        Order order = orderService.findById(orderID).get();
        List<OrderItem> orderItems = order.getOrderItems();
        List<OrderItemModel> orderItemModels = modelMapper.map(orderItems, new TypeToken<List<OrderItemModel>>() {
        }.getType());
        return new ResponseEntity<>(orderItemModels, HttpStatus.OK);
    }

    @GetMapping("/full")
    public ResponseEntity<?> getFullOrderItemByOrder(@RequestParam int orderID) {
        Order order = orderService.findById(orderID).get();
        List<OrderItem> orderItems = order.getOrderItems();
        List<FullOrderItemModel> orderItemModels = new ArrayList<>();
        for (OrderItem oi : orderItems) {
            if (oi.getReview() != null) {
                FullOrderItemModel fullOrderItemModel = new FullOrderItemModel(oi.getOrderItemID(), oi.getQuantity(),
                        oi.getPrice(), oi.getProduct().getProductID(), oi.getProduct().getProductName(),
                        oi.getProduct().getImages(), oi.getReview().getReviewID(), oi.getReview().getStar(),
                        oi.getReview().getComment(), oi.getReview().getImages(), oi.getReview().getCreatedAt(), oi.getReview().getUpdatedAt(),
                        oi.getReview().getUser().getUserID(), oi.getReview().getUser().getFirstname());
                orderItemModels.add(fullOrderItemModel);
            } else {
                FullOrderItemModel fullOrderItemModel = new FullOrderItemModel();
                fullOrderItemModel.setOrderItemID(oi.getOrderItemID());
                fullOrderItemModel.setQuantity(oi.getQuantity());
                fullOrderItemModel.setPrice(oi.getPrice());
                fullOrderItemModel.setProductID(oi.getProduct().getProductID());
                fullOrderItemModel.setProductName(oi.getProduct().getProductName());
                fullOrderItemModel.setProductImage(oi.getProduct().getImages());
                fullOrderItemModel.setReviewID(0);
                fullOrderItemModel.setStar(0);
                fullOrderItemModel.setComment(null);
                fullOrderItemModel.setReviewImage(null);
                fullOrderItemModel.setCreatedAt(null);
                fullOrderItemModel.setUpdatedAt(null);
                fullOrderItemModel.setUserID(0);
                fullOrderItemModel.setFirstname(null);

                orderItemModels.add(fullOrderItemModel);
            }
        }
        return new ResponseEntity<>(orderItemModels, HttpStatus.OK);
    }

    @GetMapping("/revenue/byproduct")
    public ResponseEntity<?> getOrderItemByProduct(@RequestParam int month, @RequestParam int year) {
        List<Order> orders = new ArrayList<>();
        if (month == 0 && year == 0) {
            orders = orderService.findByStatusOrderByOrderedDateDesc(4);
        } else {
            orders = orderService.findByStatusAndDateOrderByOrderedDateDesc(4, month, year);
        }
        List<OrderItem> orderItems = new ArrayList<>();
        for (Order o : orders) {
            orderItems.addAll(o.getOrderItems());
        }
        boolean isAdded = false;
        List<ItemProductModel> itemProductModels = new ArrayList<>();
        for (OrderItem oi : orderItems) {
            for (ItemProductModel i : itemProductModels) {
                if (oi.getProduct().getProductID() == i.getProductID()) {
                    i.setQuantity(oi.getQuantity() + i.getQuantity());
                    i.setTotal(i.getTotal() + oi.getPrice() * oi.getQuantity());
                    isAdded = true;
                    break;
                }
            }
            if (isAdded == false) {
                ItemProductModel itemProductModel = new ItemProductModel(oi.getProduct().getProductID(),
                        oi.getProduct().getProductName(), oi.getProduct().getImages(), oi.getQuantity(), oi.getQuantity() * oi.getPrice());
                itemProductModels.add(itemProductModel);
            }
        }
		// Sort
		Collections.sort(itemProductModels, new Comparator<ItemProductModel>() {
			@Override
			public int compare(ItemProductModel ip1, ItemProductModel ip2) {
				// Compare the total of two orders
				// Assuming the total is a double or float value
				return Long.compare(ip2.getTotal(), ip1.getTotal());
			}
		});

		return new ResponseEntity<>(itemProductModels, HttpStatus.OK);
    }

}
