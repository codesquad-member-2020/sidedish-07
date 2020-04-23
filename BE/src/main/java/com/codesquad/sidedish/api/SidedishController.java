package com.codesquad.sidedish.api;

import com.codesquad.sidedish.dao.ProductDAO;
import com.codesquad.sidedish.dto.SimpleDTO;
import com.codesquad.sidedish.entity.Menu;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/products")
public class SidedishController {

    private static final Logger log = LoggerFactory.getLogger(SidedishController.class);
    private ProductDAO productDAO;

    public SidedishController(ProductDAO productDAO) {
        this.productDAO = productDAO;
    }

    @GetMapping("/{menu}")
    public List<SimpleDTO> showProductsByMenu(@PathVariable String menu) {
        return productDAO.selectByMenu(Menu.valueOf(menu.toUpperCase()));
    }
}
