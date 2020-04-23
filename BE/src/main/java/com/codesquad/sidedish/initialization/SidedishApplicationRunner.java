package com.codesquad.sidedish.initialization;

import com.codesquad.sidedish.entity.*;
import com.codesquad.sidedish.repository.*;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.ArrayNode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import java.util.*;

@Component
public class SidedishApplicationRunner implements ApplicationRunner {

    private static final Logger log = LoggerFactory.getLogger(SidedishApplicationRunner.class);

    private static final String detailUrl = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/detail";
    private static final String sideUrl = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/side";
    private static final String mainUrl = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/main";
    private static final String soupUrl = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/soup";
    private static final String categoryUrl = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/best";

    private ProductRepository productRepository;
    private ThumbImageRepository thumbImageRepository;
    private DetailImageRepository detailImageRepository;
    private BadgeRepository badgeRepository;
    private DeliveryRepository deliveryRepository;
    private CategoryRepository categoryRepository;

    public SidedishApplicationRunner(ProductRepository productRepository,
                                     ThumbImageRepository thumbImageRepository,
                                     DetailImageRepository detailImageRepository,
                                     BadgeRepository badgeRepository,
                                     DeliveryRepository deliveryRepository,
                                     CategoryRepository categoryRepository) {
        this.productRepository = productRepository;
        this.thumbImageRepository = thumbImageRepository;
        this.detailImageRepository = detailImageRepository;
        this.badgeRepository = badgeRepository;
        this.deliveryRepository = deliveryRepository;
        this.categoryRepository = categoryRepository;
    }

    @Override
    public void run(ApplicationArguments args) throws Exception {
        insertCategory();
        saveProduct();
        updateProduct(Menu.MAIN);
        updateProduct(Menu.SIDE);
        updateProduct(Menu.SOUP);
        updateProductCategory();
    }

    private JsonNode getDataFromApi(String url) {
        RestTemplate restTemplate = new RestTemplate();
        return restTemplate.getForObject(url, JsonNode.class);
    }

    private void insertCategory() {
        JsonNode body = getDataFromApi(categoryUrl).get("body");
        for (JsonNode child : body) {
            Category category = new Category(child.get("name").asText());
            categoryRepository.save(category);
        }
    }

    private void saveProduct() {
        JsonNode body = getDataFromApi(detailUrl).get("body");
        for (JsonNode child : body) {
            JsonNode data = child.get("data");
            Product product = createProduct(child.get("hash").asText(), data);
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

    private Product createProduct(String hash, JsonNode data) {
        Product product = new Product();
        product.setHash(hash);
        product.setDescription(data.get("product_description").asText());
        // 배달 관련 정보 (deliveryFee, deliveryPossible)
        product.setDeliveryFee(data.get("delivery_fee").asText());
        String deliveryInfo = data.get("delivery_info").asText();
        String dayOfWeek = deliveryInfo.substring(deliveryInfo.indexOf("["), deliveryInfo.indexOf("]") + 1);
        product.setDeliveryPossible(dayOfWeek);

        // 가격
        ArrayNode pricesNode = (ArrayNode)data.get("prices");
        int[] prices = new int[pricesNode.size()];
        for (int i = 0; i < pricesNode.size(); ++i)
            prices[i] = Integer.parseInt(pricesNode.get(i).asText().replace("원", "").replace(",", ""));

        Arrays.sort(prices);
        if (pricesNode.size() >= 2) {
            product.setsPrice(prices[0]);
            product.setnPrice(prices[1]);
        } else
            product.setnPrice(prices[0]);

        return product;
    }

    private void updateProduct(Menu menu) {
        String requestUri = getRequestUrl(menu);
        JsonNode body = getDataFromApi(requestUri).get("body");
        for (JsonNode child : body) {
            String hash = child.get("detail_hash").asText();
            Optional<Product> productOptional = productRepository.findByHash(hash);
            if (!productOptional.isPresent())
                continue;

            Product product = productOptional.get();
            product.setMenu(menu);
            product.setTitle(child.get("title").asText());
            product.setImage(child.get("image").asText());

            // 배달 타입
            ArrayNode deliveryTypes = (ArrayNode)child.get("delivery_type");
            for (JsonNode type : deliveryTypes) {
                Delivery delivery = deliveryRepository.findByName(type.asText()).orElse(new Delivery(type.asText()));
                if (delivery.getId() == null)
                    delivery = deliveryRepository.save(delivery);

                product.addDelivery(delivery.getId());
            }

            // 뱃지 타입
            ArrayNode badgeTypes = (ArrayNode)child.get("badge");
            // 간혹 badge 데이터가 없는 JSON이 존재해서 Null 체크
            if (!Objects.isNull(badgeTypes)) {
                for (JsonNode type : badgeTypes) {
                    Badge badge = badgeRepository.findByName(type.asText()).orElse(new Badge(type.asText()));
                    if (badge.getId() == null)
                        badge = badgeRepository.save(badge);

                    product.addBadge(badge.getId());
                }
            }
            productRepository.save(product);
        }
    }

    private void updateProductCategory() {
        // Category와 랜덤 Product 관계 맺기
        // 각 Category에는 중복되지 않는 3개의 Product와 연결
        int countOfProduct = productRepository.countOfNotNull();
        for (Category category : categoryRepository.findAll()) {
            Set<Integer> randoms = new HashSet<>();
            while (randoms.size() < 3)
                randoms.add((int) (Math.random() * countOfProduct + 1));

            for (int id : randoms) {
                Product product = productRepository.findById(id).orElseThrow(NoSuchElementException::new);
                product.addCategory(category.getId());
                productRepository.save(product);
            }
        }
    }

    private String getRequestUrl(Menu menu) {
        switch (menu) {
            case MAIN:
                return mainUrl;
            case SIDE:
                return sideUrl;
            case SOUP:
                return soupUrl;
        }
        throw new IllegalArgumentException();
    }
}
