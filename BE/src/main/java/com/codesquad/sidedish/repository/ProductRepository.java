package com.codesquad.sidedish.repository;

import com.codesquad.sidedish.entity.Product;
import org.springframework.data.repository.CrudRepository;

public interface ProductRepository extends CrudRepository<Product, Integer> {

}
