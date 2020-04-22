package com.codesquad.sidedish.entity;

import org.springframework.data.annotation.Id;

public class Badge {

    @Id
    private Integer id;

    private String name;

    public Badge(String name) {
        this.name = name;
    }

    public Integer getId() {
        return id;
    }
}
