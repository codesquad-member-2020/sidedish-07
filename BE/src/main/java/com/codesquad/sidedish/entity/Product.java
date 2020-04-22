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

    private Set<ProductCategory> categories = new HashSet<>();

    private Set<ProductBadge> badges = new HashSet<>();

    private Set<ProductDelivery> deliveries = new HashSet<>();

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getHash() {
        return hash;
    }

    public void setHash(String hash) {
        this.hash = hash;
    }

    public Menu getMenu() {
        return menu;
    }

    public void setMenu(Menu menu) {
        this.menu = menu;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getsPrice() {
        return sPrice;
    }

    public void setsPrice(int sPrice) {
        this.sPrice = sPrice;
    }

    public int getnPrice() {
        return nPrice;
    }

    public void setnPrice(int nPrice) {
        this.nPrice = nPrice;
    }

    public String getDeliveryFee() {
        return deliveryFee;
    }

    public void setDeliveryFee(String deliveryFee) {
        this.deliveryFee = deliveryFee;
    }

    public String getDeliveryPossible() {
        return deliveryPossible;
    }

    public void setDeliveryPossible(String deliveryPossible) {
        this.deliveryPossible = deliveryPossible;
    }

    public Set<ProductCategory> getCategories() {
        return categories;
    }

    public Set<ProductBadge> getBadges() {
        return badges;
    }

    public Set<ProductDelivery> getDeliveries() {
        return deliveries;
    }

    public void addDelivery(Integer delivery) {
        deliveries.add(new ProductDelivery(delivery));
    }

    public void addBadge(Integer badge) {
        badges.add(new ProductBadge(badge));
    }

    public boolean addCategory(Integer category) {
        return categories.add(new ProductCategory(category));
    }
}
