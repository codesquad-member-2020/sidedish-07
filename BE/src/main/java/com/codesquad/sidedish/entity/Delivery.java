package com.codesquad.sidedish.entity;

import org.springframework.data.annotation.Id;

public class Delivery {

    @Id
    private Integer id;

    private String name;

    public Delivery(String name) {
        this.name = name;
    }

    public Integer getId() {
        return id;
    }

    public String getName() {
        return name;
    }
}
