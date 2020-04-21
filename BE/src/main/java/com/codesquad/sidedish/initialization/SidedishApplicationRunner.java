package com.codesquad.sidedish.initialization;

import com.codesquad.sidedish.entity.Delivery;
import com.codesquad.sidedish.entity.DetailImage;
import com.codesquad.sidedish.entity.ThumbImage;
import com.codesquad.sidedish.entity.Product;
import com.codesquad.sidedish.repository.*;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.ArrayNode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import java.util.Arrays;
import java.util.Optional;

@Component
public class SidedishApplicationRunner implements ApplicationRunner {

    private static final Logger log = LoggerFactory.getLogger(SidedishApplicationRunner.class);

    private static String detailUri = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/detail";

    private ProductRepository productRepository;
    private ThumbImageRepository thumbImageRepository;
    private DetailImageRepository detailImageRepository;
    private BadgeRepository badgeRepository;
    private DeliveryRepository deliveryRepository;

    public SidedishApplicationRunner(ProductRepository productRepository,
                                     ThumbImageRepository thumbImageRepository,
                                     DetailImageRepository detailImageRepository,
                                     BadgeRepository badgeRepository,
                                     DeliveryRepository deliveryRepository) {
        this.productRepository = productRepository;
        this.thumbImageRepository = thumbImageRepository;
        this.detailImageRepository = detailImageRepository;
        this.badgeRepository = badgeRepository;
        this.deliveryRepository = deliveryRepository;
    }

    @Override
    public void run(ApplicationArguments args) throws Exception {
        JsonNode body = getNodeFromApi(detailUri).get("body");
        for (JsonNode child : body) {
            Product product = new Product();
            product.setHash(child.get("hash").asText());

            JsonNode data = child.get("data");
            product.setDescription(data.get("product_description").asText());
            product.setDeliveryFee(data.get("delivery_fee").asText());
            String deliveryInfo = data.get("delivery_info").asText();
            String dayOfWeek = deliveryInfo.substring(deliveryInfo.indexOf("["), deliveryInfo.indexOf("]") + 1);
            product.setDeliveryPossible(dayOfWeek);

            // 배달
            if (deliveryInfo.contains("새벽배송")) {
                // DAO 클래스 만들어서 name = :name 쿼리문으로 DB에서 가져와야 할
                Delivery delivery = deliveryRepository.findById(1).orElseThrow(IllegalArgumentException::new);
                product.addDelivery(delivery.getId());
            }

            if (deliveryInfo.contains("전국택배")) {
                Delivery delivery = deliveryRepository.findById(2).orElseThrow(IllegalArgumentException::new);
                product.addDelivery(delivery.getId());
            }

           // 가격
            ArrayNode pricesNode = (ArrayNode)data.get("prices");
            int[] prices = new int[pricesNode.size()];
            for (int i = 0; i < pricesNode.size(); ++i) {
                prices[i] = Integer.parseInt(pricesNode.get(i).asText().replace("원", "").replace(",", ""));
            }
            Arrays.sort(prices);
            if (pricesNode.size() >= 2) {
                product.setsPrice(prices[0]);
                product.setnPrice(prices[1]);
            } else
                product.setnPrice(prices[0]);

            productRepository.save(product);

            // 이미지
            ArrayNode thumbImages = (ArrayNode)data.get("thumb_images");
            for (int i = 0; i < thumbImages.size(); ++i) {
                String url = thumbImages.get(i).asText();
                ThumbImage thumbImage = new ThumbImage(url, product.getId());
                thumbImageRepository.save(thumbImage);
            }

            ArrayNode detailImages = (ArrayNode)data.get("detail_section");
            for (int i = 0; i < detailImages.size(); ++i) {
                String url = detailImages.get(i).asText();
                DetailImage detailImage = new DetailImage(url, product.getId());
                detailImageRepository.save(detailImage);
            }
        }
    }

    public static JsonNode getNodeFromApi(String uri) {
        RestTemplate restTemplate = new RestTemplate();
        return restTemplate.getForObject(uri, JsonNode.class);
    }
}
