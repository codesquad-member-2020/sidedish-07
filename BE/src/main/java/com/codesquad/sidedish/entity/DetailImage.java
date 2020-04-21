package com.codesquad.sidedish.entity;

import org.springframework.data.annotation.Id;

public class DetailImage {

    @Id
    private Integer id;

    private String url;

    private Integer product;

    public DetailImage(String url, Integer product) {
        this.url = url;
        this.product = product;
    }
}
