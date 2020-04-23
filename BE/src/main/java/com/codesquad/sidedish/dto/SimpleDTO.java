package com.codesquad.sidedish.dto;

import com.fasterxml.jackson.annotation.JsonIgnore;

import java.util.List;

public class SimpleDTO {

    @JsonIgnore
    private Integer id;

    private String hash;

    private String title;

    private String alt;

    private String description;

    private String salePrice;

    private String normalPrice;

    private String image;

    private List<String> deliveryTypes;

    private List<String> badges;

    public SimpleDTO(Integer id, String hash, String title, String alt, String description, String salePrice, String normalPrice, String image) {
        this.id = id;
        this.hash = hash;
        this.title = title;
        this.alt = alt;
        this.description = description;
        this.salePrice = salePrice;
        this.normalPrice = normalPrice;
        this.image = image;
    }

    public Integer getId() {
        return id;
    }

    public String getHash() {
        return hash;
    }

    public String getTitle() {
        return title;
    }

    public String getAlt() {
        return alt;
    }

    public String getDescription() {
        return description;
    }

    public String getSalePrice() {
        return salePrice;
    }

    public String getNormalPrice() {
        return normalPrice;
    }

    public String getImage() {
        return image;
    }

    public List<String> getDeliveryTypes() {
        return deliveryTypes;
    }

    public void setDeliveryTypes(List<String> deliveryTypes) {
        this.deliveryTypes = deliveryTypes;
    }

    public List<String> getBadges() {
        return badges;
    }

    public void setBadges(List<String> badges) {
        this.badges = badges;
    }
}
