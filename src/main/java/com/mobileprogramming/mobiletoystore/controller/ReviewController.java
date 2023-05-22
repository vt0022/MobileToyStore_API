package com.mobileprogramming.mobiletoystore.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collector;
import java.util.stream.Collectors;

import com.cloudinary.Cloudinary;
import com.cloudinary.Transformation;
import com.cloudinary.utils.ObjectUtils;
import com.mobileprogramming.mobiletoystore.model.UserModel;
import jakarta.annotation.Nullable;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;

import org.aspectj.weaver.NewConstructorTypeMunger;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.mobileprogramming.mobiletoystore.entity.OrderItem;
import com.mobileprogramming.mobiletoystore.entity.Product;
import com.mobileprogramming.mobiletoystore.entity.Review;
import com.mobileprogramming.mobiletoystore.entity.User;
import com.mobileprogramming.mobiletoystore.model.ProductModel;
import com.mobileprogramming.mobiletoystore.model.ReviewModel;
import com.mobileprogramming.mobiletoystore.service.IOrderItemService;
import com.mobileprogramming.mobiletoystore.service.IProductService;
import com.mobileprogramming.mobiletoystore.service.IReviewService;
import com.mobileprogramming.mobiletoystore.service.IUserService;
import com.mobileprogramming.mobiletoystore.service.impl.ReviewServiceImpl;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/toystoreapp/review")
public class ReviewController {

    @Autowired
    ModelMapper modelMapper;

    @Autowired
    Cloudinary cloudinary;

    @Autowired
    IReviewService reviewService;

    @Autowired
    IProductService productService;

    @Autowired
    IUserService userService;

    @Autowired
    IOrderItemService orderItemService;

    @GetMapping("/all")
    public ResponseEntity<?> listReviews() {
        List<ReviewModel> reviewModels = reviewService.findAll().stream()
                .map(review -> modelMapper.map(review, ReviewModel.class)).collect(Collectors.toList());
        return new ResponseEntity<>(reviewModels, HttpStatus.OK);
    }

    @PostMapping(path = "/my", consumes = "application/x-www-form-urlencoded")
    public ResponseEntity<?> getReviewByUser(@RequestParam int userID) {
        List<Review> reviews = reviewService.findByUser(userID);
        List<ReviewModel> reviewModels = modelMapper.map(reviews, new TypeToken<List<ReviewModel>>() {
        }.getType());
        return new ResponseEntity<>(reviewModels, HttpStatus.OK);
    }

    @GetMapping("/{reviewID}")
    public ResponseEntity<?> getReviewByID(@PathVariable int reviewID) {
        Optional<Review> review = reviewService.findById(reviewID);
        if (review.isPresent()) {
            ReviewModel reviewModel = modelMapper.map(review, ReviewModel.class);
            return new ResponseEntity<>(reviewModel, HttpStatus.OK);
        }
        return new ResponseEntity<>(Optional.empty(), HttpStatus.OK);
    }

    @PostMapping(path = "", consumes = "application/x-www-form-urlencoded")
    public ResponseEntity<?> getReviewByProduct(@RequestParam int productID) {
        Product product = productService.findById(productID).get();
        List<Review> reviews = reviewService.findByProduct(product);
        List<ReviewModel> reviewModels = modelMapper.map(reviews, new TypeToken<List<ReviewModel>>() {
        }.getType());
        return new ResponseEntity<>(reviewModels, HttpStatus.OK);
    }

    @GetMapping("/orderitem")
    public ResponseEntity<?> getReviewByOrderItem(@RequestParam int orderItemID) {
        OrderItem orderItem = orderItemService.findById(orderItemID).get();
        Review review = orderItem.getReview();
        if (review != null) {
            ReviewModel reviewModel = modelMapper.map(review, ReviewModel.class);
            return new ResponseEntity<>(reviewModel, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @PostMapping("/create")
    public ResponseEntity<?> reviewProduct(@RequestPart String orderItemID, @RequestPart String star,
                                           @RequestPart String comment, @RequestPart MultipartFile images) {
        Optional<OrderItem> orderItem = orderItemService.findById(Integer.parseInt(orderItemID));
        float receivedStar = Float.parseFloat(star);
        if (!orderItem.isPresent())
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        try {
            Review review = new Review();
            review.setStar((int)receivedStar);
            review.setComment(comment);
            review.setOrderItem(orderItem.get());
            review.setCreatedAt(new Timestamp(System.currentTimeMillis()));
            review.setUser(orderItem.get().getOrder().getUser());
            review.setProduct(orderItem.get().getProduct());
            review = reviewService.save(review);
            if (!images.isEmpty()) {
                // Upload image
                // Without random, it will replace current image
                // So the url will display image slowly
                UUID randomUUID = UUID.randomUUID();
                Map u = cloudinary.uploader().upload(images.getBytes(), ObjectUtils.asMap("public_id", "review_" + review.getReviewID() + "_" + randomUUID));
                // public_id: a unique identifier that you can assign to each image to help you manage your media assets
                // Crop image
                String url = cloudinary.url().publicId(u.get("public_id").toString()).
                        transformation(new Transformation().width(500).height(500).crop("fill")).generate();
                // Update image
                review.setImages(url);
                review = reviewService.save(review);
            }
            ReviewModel reviewModel = modelMapper.map(review, ReviewModel.class);
            return new ResponseEntity<>(reviewModel, HttpStatus.OK);
        } catch (IOException exception) {
            System.out.println(exception.getMessage());
        }
        return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
    }

    @PutMapping("/update")
    public ResponseEntity<?> updateReview(@RequestParam int reviewID, @RequestParam int star,
                                          @Nullable @RequestParam String comment, @Nullable @RequestParam String images) {
        Review review = reviewService.findById(reviewID).get();
        review.setStar(star);
        review.setComment(comment);
        review.setImages(images);
        review.setUpdatedAt(new Timestamp(System.currentTimeMillis()));
        review = reviewService.save(review);

        ReviewModel reviewModel = modelMapper.map(review, ReviewModel.class);
        return new ResponseEntity<>(reviewModel, HttpStatus.CREATED);
    }

    @GetMapping("/all/desc")
    public ResponseEntity<?> getReviewDesc() {
        List<Review> reviews = reviewService.findByOrderByCreatedAtDesc();
        List<ReviewModel> reviewModels = modelMapper.map(reviews, new TypeToken<List<ReviewModel>>() {
        }.getType());
        return new ResponseEntity<>(reviewModels, HttpStatus.OK);
    }

    @GetMapping("/bystar")
    public ResponseEntity<?> getReviewByStar(@RequestParam int star) {
        List<Review> reviews = reviewService.findByStarOrderByCreatedAtDesc(star);
        List<ReviewModel> reviewModels = modelMapper.map(reviews, new TypeToken<List<ReviewModel>>() {
        }.getType());
        return new ResponseEntity<>(reviewModels, HttpStatus.OK);
    }
}
