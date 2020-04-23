package com.codesquad.sidedish.dto;

import com.fasterxml.jackson.annotation.JsonIgnore;

import java.util.List;

public class DetailDTO {

    @JsonIgnore
    private Integer id;

    private String hash;

    private String title;

    private String description;

    private String salePrice;

    private String normalPrice;

    private String point;

    private String deliveryFee;

    private String deliveryInfo;

    private String topImage;

    private List<String> thumbImages;

    private List<String> detailImages;

    @JsonIgnore
    private List<String> deliveryTypes;

    public DetailDTO(Integer id, String hash, String title, String description, String salePrice, String normalPrice, String point, String deliveryFee, String deliveryInfo, String topImage) {
        this.id = id;
        this.hash = hash;
        this.title = title;
        this.description = description;
        this.salePrice = salePrice;
        this.normalPrice = normalPrice;
        this.point = point;
        this.deliveryFee = deliveryFee;
        this.deliveryInfo = deliveryInfo;
        this.topImage = topImage;
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

    public String getDescription() {
        return description;
    }

    public String getSalePrice() {
        return salePrice;
    }

    public String getNormalPrice() {
        return normalPrice;
    }

    public String getPoint() {
        return point;
    }

    public String getDeliveryFee() {
        return deliveryFee;
    }

    public String getDeliveryInfo() {
        return deliveryInfo;
    }

    public void setDeliveryInfo(String deliveryInfo) {
        this.deliveryInfo = deliveryInfo;
    }

    public String getTopImage() {
        return topImage;
    }

    public List<String> getThumbImages() {
        return thumbImages;
    }

    public void setThumbImages(List<String> thumbImages) {
        this.thumbImages = thumbImages;
    }

    public List<String> getDetailImages() {
        return detailImages;
    }

    public void setDetailImages(List<String> detailImages) {
        this.detailImages = detailImages;
    }

    public List<String> getDeliveryTypes() {
        return deliveryTypes;
    }

    public void setDeliveryTypes(List<String> deliveryTypes) {
        this.deliveryTypes = deliveryTypes;
    }
}
