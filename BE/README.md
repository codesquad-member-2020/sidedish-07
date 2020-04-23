# 반찬 API

## API 서버 주소
http://15.165.190.16/

## 메뉴별 데이터 요청 API
### GET `/products/{menu}`

### 필요한 데이터
- `{menu}`에 main, soup, side 중 하나를 포함시켜서 요청해주세요.
  > 예시

    `http://15.165.190.16/products/main`
    
### 응답 데이터 
```
[
    {
        "hash": "H72C3",
        "title": "[수하동] 특곰탕 850g",
        "alt": "[수하동] 특곰탕 850g",
        "description": "100% 한우양지로 끓여낸 70년전통의 서울식곰탕",
        "salePrice": "14,200원",
        "normalPrice": "15,000원",
        "image": "http://public.codesquad.kr/jk/storeapp/data/d1fccf125f0a78113d0e06cb888f2e74.jpg",
        "deliveryTypes": [
            "새벽배송",
            "전국택배"
        ],
        "badges": [
            "이벤트특가"
        ]
    },
    {
        "hash": "HA6EE",
        "title": "[빅마마의밥친구] 된장찌개 900g",
        "alt": "[빅마마의밥친구] 된장찌개 900g",
        "description": "항아리에서 숙성시킨 집된장으로만 맛을내 짜지 않은 된장찌개",
        "salePrice": "0원",
        "normalPrice": "10,000원",
        "image": "http://public.codesquad.kr/jk/storeapp/data/c069bc32cb37727c59e1f0c2839311a0.jpg",
        "deliveryTypes": [
            "새벽배송",
            "전국택배"
        ],
        "badges": []
    },
    ...
]
```
