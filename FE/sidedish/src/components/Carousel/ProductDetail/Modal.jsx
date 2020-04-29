import React, { useState, useEffect } from "react";
import styled from "@emotion/styled";
import axios from "axios";
import preventScroll from "../../../util/util";


const Modal = (props) => {
  const ProductModal = styled.div`
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.4);
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 1;
  `;

  const ProductBackground = styled.div`
    width: 910px;
    height: 500px;
    background: white;
    z-index: 2;
    box-sizing: border-box;
    display: flex;
    flex-direction: column;
  `;

  const ProductWrap = styled.div`
    width: 100%;
    height: 100%;
    display: flex;
    box-sizing: border-box;
  `;

  const ProductImageWrap = styled.div`
    width: 43%;
    height: 100%;
    box-sizing: border-box;
    padding : 25px;
  `;

  const TopImage = styled.img`
    width: 100%;
  `;
  const ThumbImagesWrap = styled.div`
    width : 100%;
    display : flex;
    box-sizing : border-box;
    margin-top : 15px;
  `;

  const ThumbImage = styled.img`
    width : 65px;
    height : 65px;
    margin-right : 3px;
    background : #D8D8D8;
  `;


  const ProductInfoWrap = styled.div`
    width: 57%;
    height: 100%;
    box-sizing: border-box;
  `;
  const TitleWrap = styled.div`
    width: 100%;
    display: flex;
    align-items : flex-start;
  `;
  const Title = styled.div`
    width: 95%;
    font-size: 23px;
    font-weight: bold;
    margin: 25px 0px 10px 30px;
  `;
  const CloseBtn = styled.img`
    width: 20px;
    text-align: right;
    margin: 25px 20px 10px 10px;
  `;

  const Description = styled.div`
    width: 95%;
    margin-top: 5px;
    margin-bottom: 5px;
    margin-left: 30px;
    margin-right: 10px;
    font-size: 15px;
    color: #18c2bd;
  `;

  const InfoWrap = styled.div`
    display: flex;
  `;
  const InfoTitle = styled.div`
    font-size: 13px;
    width: 90px;
    color: #6e6e6e;
    margin-top: 15px;
    margin-left: 30px;
    margin-bottom: 5px;
    margin-right: 10px;
  `;
  const Info = styled.div`
    width: 330px;
    font-size: 13px;
    margin-top: 15px;
    margin-left: 10px;
    margin-bottom: 5px;
    margin-right: 10px;
  `;

  const Price = styled.div`
    font-weight: bold;
    font-size: 30px;
    text-align: right;
    margin-right: 20px;
    margin-top: 12px;
    margin-bottom: 15px;
  `;

  const LineWrap = styled.div`
    display: flex;
    justify-content: center;
  `;
  const Line = styled.div`
    height: 1px;
    background: #bdbdbd;
    width: 93%;
    margin: 5px;
  `;

  const QuantityWrap = styled.div`
    display: flex;
    height: 25px;
    line-height: 25px;
    margin-bottom: 25px;
  `;

  const QuantityTitle = styled.div`
    width: 77%;
    font-size: 13px;
    font-weight: bold;
    margin-top: 10px;
    margin-left: 30px;
    margin-bottom: 10px;
  `;

  const QuantityInput = styled.input`
    height: 100%;
    margin-top: 10px;
    margin-right: 10px;
    margin-bottom: 10px;
    text-align: center;
    &::-webkit-inner-spin-button{
        height : 40px;
   
    }
  `;

  const TotalWrap = styled.div`
    display: flex;
    justify-content: flex-end;
    height: 40px;
    line-height: 40px;
  `;
  const TotalTitle = styled.div`
    font-size: 15px;
    font-weight: bold;
    margin-right: 20px;
    margin-top: 12px;
    margin-bottom: 15px;
  `;
  const TotalPrice = styled.div`
    font-weight: bold;
    font-size: 30px;
    text-align: right;
    color: #18c2bd;
    margin-right: 20px;
    margin-top: 12px;
    margin-bottom: 15px;
  `;
   const CartBtnWarp = styled.div`
        width : 100%;
        text-align : center;
    `;
  const CartBtn = styled.button`
    background : #18c2bd;
    height : 50px;
    width : 85%;
    color : white;
    font-size : 18px;
    font-weight : bold;
    outline : 0;
    border : 0;
    margin : 30px 0px ;
  `;

  const closeBtnClickHandler = () => {
    const body = document.querySelector("body");
    preventScroll(body, false);
    props.setModalStyle({ display: "none" });
  };

  return (
    <>
      <ProductModal>
        <ProductBackground>
          <ProductWrap>
            <ProductImageWrap>
              <TopImage src={props.topImage} />
              <ThumbImagesWrap>
              {props.thumbImages.map((image) => {  
              return (
                <ThumbImage src={image}/>
              );
            })}
    </ThumbImagesWrap>
            </ProductImageWrap>
            <ProductInfoWrap>
              <TitleWrap>
                <Title>{props.title}</Title>
                <CloseBtn
                  src="https://image.flaticon.com/icons/svg/748/748122.svg"
                  onClick={closeBtnClickHandler}
                />
              </TitleWrap>
              <Description>{props.description}</Description>
              <InfoWrap>
                <InfoTitle>포인트</InfoTitle>
                <Info>{props.point}</Info>
              </InfoWrap>
              <InfoWrap>
                <InfoTitle>배송정보</InfoTitle>
                <Info>{props.deliveryInfo}</Info>
              </InfoWrap>
              <InfoWrap>
                <InfoTitle>배송비</InfoTitle>
                <Info>{props.deliveryFee}</Info>
              </InfoWrap>
              <Price>{props.normalPrice}</Price>
              <LineWrap>
                <Line />
              </LineWrap>
              <QuantityWrap>
                <QuantityTitle>수량</QuantityTitle>
                <QuantityInput
                  type="number"
                  min="0"
                  max="15"
                  placeholder="1"
                ></QuantityInput>
              </QuantityWrap>
              <LineWrap>
                <Line />
              </LineWrap>
              <TotalWrap>
                <TotalTitle>총 상품금액</TotalTitle>
                <TotalPrice>{props.normalPrice}</TotalPrice>
              </TotalWrap>
              <CartBtnWarp>
                <CartBtn>담기</CartBtn>
              </CartBtnWarp>
            </ProductInfoWrap>
          </ProductWrap>
        </ProductBackground>
      </ProductModal>
    </>
  );
};

export default Modal;