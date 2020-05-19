package com.codesquad.sidedish.repository;

import com.codesquad.sidedish.entity.Product;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.Optional;

public interface ProductRepository extends CrudRepository<Product, Integer> {

    @Query("SELECT * FROM product WHERE hash = :hash")
    Optional<Product> findByHash(String hash);

    @Query("SELECT COUNT(p.menu) FROM product p")
    int countOfNotNull();
}
