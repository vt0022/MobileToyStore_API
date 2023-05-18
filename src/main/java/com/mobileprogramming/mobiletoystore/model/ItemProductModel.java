package com.mobileprogramming.mobiletoystore.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ItemProductModel implements Serializable {

    // Product
    private int productID;

    private String productName;

    private String productImage;

    // Order Item
    private int quantity;

    private long total;

}
