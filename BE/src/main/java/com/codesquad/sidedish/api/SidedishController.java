package com.codesquad.sidedish.api;

import com.codesquad.sidedish.dao.ProductDAO;
import com.codesquad.sidedish.dto.DetailDTO;
import com.codesquad.sidedish.dto.SimpleDTO;
import com.codesquad.sidedish.entity.Menu;
import com.codesquad.sidedish.response.ResponseData;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/products")
public class SidedishController {

    private static final Logger log = LoggerFactory.getLogger(SidedishController.class);
    private ProductDAO productDAO;

    public SidedishController(ProductDAO productDAO) {
        this.productDAO = productDAO;
    }

    @GetMapping("/{menu}")
    public ResponseEntity<ResponseData> showProductsByMenu(@PathVariable String menu) {
        List<SimpleDTO> products = null;
        try {
            products = productDAO.selectByMenu(Menu.valueOf(menu.toUpperCase()));
        } catch (IllegalArgumentException e) {
            return new ResponseEntity<>(new ResponseData(ResponseData.STATUS.ERROR, "API URL 오류"), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new ResponseData(ResponseData.STATUS.SUCCESS, products), HttpStatus.OK);
    }

    @GetMapping("/detail/{hash}")
    public ResponseEntity<ResponseData> showDetail(@PathVariable String hash) {
        DetailDTO product = null;
        try {
            product = productDAO.selectDetailByHash(hash);
            processDeliveryInfo(product);
        } catch (EmptyResultDataAccessException e) {
            return new ResponseEntity<>(new ResponseData(ResponseData.STATUS.ERROR, "존재하지 않는 상품입니다."), HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<>(new ResponseData(ResponseData.STATUS.SUCCESS, product), HttpStatus.OK);
    }

    private void processDeliveryInfo(DetailDTO product) {
        String deliveryInfo = new StringBuilder(product.getDeliveryTypes().stream()
                .map((type) -> {
                    if(type.equals("새벽배송"))
                        return "서울 경기 새벽배송";
                    return "전국택배 (제주 및 도서산간 불가)";
                })
                .collect(Collectors.joining(" / ")))
                .append(product.getDeliveryInfo())
                .append(" 수령 가능한 상품입니다.").toString();
        product.setDeliveryInfo(deliveryInfo);
    }
}
