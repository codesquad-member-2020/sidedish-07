package com.codesquad.sidedish.repository;

import com.codesquad.sidedish.entity.Delivery;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.Optional;

public interface DeliveryRepository extends CrudRepository<Delivery, Integer> {

    @Query("SELECT d.id, d.name FROM delivery d WHERE d.name = :name")
    Optional<Delivery> findByName(String name);
}
