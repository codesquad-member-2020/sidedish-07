# 반찬 API

## API 서버 주소
http://15.165.65.200

## 메뉴별 데이터 요청 API
### GET `/products/{menu}`

### 필요한 데이터
- `{menu}`에 main, soup, side 중 하나를 포함시켜서 요청해주세요.
  > 예시

    `http://15.165.190.16/products/main`
    
### 응답 데이터
- 정상 응답 
```
{
    "status": "SUCCESS",
    "content": [
        {
            "hash": "HBDEF",
            "title": "[미노리키친] 규동 250g",
            "alt": "[미노리키친] 규동 250g",
            "description": "일본인의 소울푸드! 한국인도 좋아하는 소고기덮밥",
            "salePrice": "5,200원",
            "normalPrice": "6,500원",
            "image": "http://public.codesquad.kr/jk/storeapp/data/2d3f99a9a35601f4e98837bc4d39b2c8.jpg",
            "deliveryTypes": [
                "새벽배송",
                "전국택배"
            ],
            "badges": [
                "이벤트특가"
            ]
        },
        {
            "hash": "HDF73",
            "title": "[빅마마의밥친구] 아삭 고소한 연근고기조림 250g",
            "alt": "[빅마마의밥친구] 아삭 고소한 연근고기조림 250g",
            "description": "편식하는 아이도 좋아하는 건강한 연근조림",
            "salePrice": "0원",
            "normalPrice": "5,500원",
            "image": "http://public.codesquad.kr/jk/storeapp/data/7674311a02ba7c88675f3186ddaeef9e.jpg",
            "deliveryTypes": [
                "새벽배송",
                "전국택배"
            ],
            "badges": []
        },
        ...
    ]
}
```

- 에러 응답
  - 요청 URL이 잘못된 경우
  - 상태 코드 : 400 (Bad Request)
```
{
    "status": "ERROR",
    "content": "API URL 오류"
}
```

## 상세 페이지 데이터 요청 API
### GET `/products/detail/{hash}`

### 필요한 데이터
- `{hash}`에 상품 hash 값을 넣어주세요.
  > 예시

    `http://15.165.190.16/products/detail/H72C3`
    
### 응답 데이터 
- 정상 응답 
```
{
    "status": "SUCCESS",
    "content": {
        "hash": "H72C3",
        "title": "[수하동] 특곰탕 850g",
        "description": "100% 한우양지로 끓여낸 70년전통의 서울식곰탕",
        "salePrice": "14,200원",
        "normalPrice": "15,000원",
        "point": "142원",
        "deliveryFee": "2,500원 (40,000원 이상 구매 시 무료)",
        "deliveryInfo": "서울 경기 새벽배송 / 전국택배 (제주 및 도서산간 불가)[화 · 수 · 목 · 금 · 토] 수령 가능한 상품입니다.",
        "topImage": "http://public.codesquad.kr/jk/storeapp/data/d1fccf125f0a78113d0e06cb888f2e74.jpg",
        "thumbImages": [
            "http://public.codesquad.kr/jk/storeapp/data/d1fccf125f0a78113d0e06cb888f2e74.jpg",
            "http://public.codesquad.kr/jk/storeapp/data/detail/H0FC6/92f556b605c4a84813070d7214c4f336.jpg",
            "http://public.codesquad.kr/jk/storeapp/data/detail/H0FC6/538b8ab021c7814aa4af860d94f81287.jpg",
            "http://public.codesquad.kr/jk/storeapp/data/detail/H0FC6/adaef08ab0680b087096afa0f0070fad.jpg"
        ],
        "detailImages": [
            "http://public.codesquad.kr/jk/storeapp/data/detail/H0FC6/341b8605fa224ec1808c4f169097d170.jpg",
            "http://public.codesquad.kr/jk/storeapp/data/detail/H0FC6/0228d4cb660a3cca06952917bd024dcb.jpg",
            "http://public.codesquad.kr/jk/storeapp/data/detail/H0FC6/e027227f61a93b6473e8c4bbd5c3de74.jpg",
            "http://public.codesquad.kr/jk/storeapp/data/detail/H0FC6/03ac0b09199421bb61727c667c2361f6.jpg",
            "http://public.codesquad.kr/jk/storeapp/data/detail/H0FC6/cbe4a3e12b7bdba5cf410e0e19dcf1ca.jpg",
            "http://public.codesquad.kr/jk/storeapp/data/detail/H0FC6/b58fa5791b67db106524b48442cb1c6a.jpg",
            "http://public.codesquad.kr/jk/storeapp/data/detail/H0FC6/82cfe0332f0e1c927a23b79f1d152430.jpg",
            "http://public.codesquad.kr/jk/storeapp/data/detail/H0FC6/390ca9ad5a574cbe7f3f6e26871f6690.jpg",
            "http://public.codesquad.kr/jk/storeapp/data/detail/H0FC6/e113889a6120357c8e6196802a9f155b.jpg",
            "http://public.codesquad.kr/jk/storeapp/data/detail/H0FC6/967e8e1ef357e9722b796e2bcb09ba3d.jpg"
        ]
    }
}
```

- 에러 응답
  - 존재하지 않는 hash를 전달한 경우
  - 상태 코드 : 404 (Not Found)
```
{
    "status": "ERROR",
    "content": "존재하지 않는 상품입니다."
}
```
