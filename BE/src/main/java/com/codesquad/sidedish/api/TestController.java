package com.codesquad.sidedish.api;

import com.codesquad.sidedish.entity.Product;
import com.codesquad.sidedish.repository.ProductRepository;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@RestController
public class TestController {

    private ProductRepository productRepository;

    public TestController(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    @GetMapping("/detail")
    public List<Product> test() {
        List<Product> products = new ArrayList<>();
        Iterator<Product> iter = productRepository.findAll().iterator();
        while (iter.hasNext()) {
            products.add(iter.next());
        }
        return products;
    }
}
