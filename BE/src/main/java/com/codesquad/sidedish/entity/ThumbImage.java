package com.codesquad.sidedish.entity;

import org.springframework.data.annotation.Id;

public class ThumbImage {

    @Id
    private Integer id;

    private String url;

    private Integer product;

    public ThumbImage(String url, Integer product) {
        this.url = url;
        this.product = product;
    }
}
