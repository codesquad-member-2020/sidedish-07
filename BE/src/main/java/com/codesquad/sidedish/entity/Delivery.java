package com.codesquad.sidedish.entity;

import org.springframework.data.annotation.Id;

public class Delivery {

    @Id
    private Integer id;

    private String name;

    public Integer getId() {
        return id;
    }
}
