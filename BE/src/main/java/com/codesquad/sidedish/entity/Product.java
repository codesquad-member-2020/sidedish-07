package com.codesquad.sidedish.entity;

import org.springframework.data.annotation.Id;

import java.util.HashSet;
import java.util.Set;

public class Product {

    @Id
    private Integer id;

    private String hash;

    private Menu menu;

    private String title;

    private String description;

    private int sPrice;

    private int nPrice;

    private String deliveryFee;

    private String deliveryPossible;

//    private Set<ProductCategory> categories = new HashSet<>();

//    private Set<ProductBadge> badges = new HashSet<>();

    private Set<ProductDelivery> deliveries = new HashSet<>();


    public Integer getId() {
        return id;
    }

    public String getHash() {
        return hash;
    }

    public Menu getMenu() {
        return menu;
    }

    public String getTitle() {
        return title;
    }

    public String getDescription() {
        return description;
    }

    public int getsPrice() {
        return sPrice;
    }

    public int getnPrice() {
        return nPrice;
    }

    public String getDeliveryFee() {
        return deliveryFee;
    }

    public String getDeliveryPossible() {
        return deliveryPossible;
    }

    public Set<ProductDelivery> getDeliveries() {
        return deliveries;
    }

    public void setHash(String hash) {
        this.hash = hash;
    }

    public void setMenu(Menu menu) {
        this.menu = menu;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setsPrice(int sPrice) {
        this.sPrice = sPrice;
    }

    public void setnPrice(int nPrice) {
        this.nPrice = nPrice;
    }

    public void setDeliveryFee(String deliveryFee) {
        this.deliveryFee = deliveryFee;
    }

    public void setDeliveryPossible(String deliveryPossible) {
        this.deliveryPossible = deliveryPossible;
    }

    public void addDelivery(Integer delivery) {
        deliveries.add(new ProductDelivery(delivery));
    }
}
