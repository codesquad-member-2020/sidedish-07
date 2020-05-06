import React, { useState, useEffect } from "react";
import styled from "@emotion/styled";
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";
import Slider from "react-slick";
import Arrow from "./Arrow";
import CarouselItem from "./CarouselItem";
import axios from "axios";
import { findByLabelText } from "@testing-library/react";
import Modal from "./ProductDetail/Modal";
import preventScroll from "../../util/util";


const Carousel = (props) => {

  const settings = {
    dots: false,
    infinite: true,
    draggable : false,
    speed: 500,
    slidesToScroll: 4,
    slidesToShow: 4,
    nextArrow: <Arrow type="next" />,
    prevArrow: <Arrow type="prev" />,
  };

  const CarouselWrap = styled.div`
    width : 95%;
    display : flex;
    justify-content : center;
    margin : 30px;
  `;

  const CarouselContentWrap = styled.div`
    width : 1250px;
    display : flex;
    justify-content : center;
    flex-direction : column;
    text-align : center;
    padding : 10px 10px 30px 10px;
    box-sizing : border-box;
  `;

  const CarouselCategory = styled.div`
    color : grey;
    font-size : 18px;
    margin : 10px;
  `;

  const CarouselTitle = styled.div`
    color: #424242;
    font-size: 30px;
    margin-bottom: 45px;
  `;

  const CarouselItemWrap = styled.div`
    outline: none;
    border: none;
  `;

  const [modalStyle, setModalStyle] = useState({ display: "none" });

  const [product, setProduct] = useState({
    title: null,
    description: null,
    salePrice: null,
    normalPrice: null,
    point: null,
    deliveryFee: null,
    deliveryInfo: null,
    topImage: null,
    thumbImages: [],
  });


  const openModal = (e) => {
    const hashData = e.target.closest('#hashData');
    const body = document.querySelector("body");
    preventScroll(body, true);
    fetch(hashData.dataset.hash);
    setModalStyle({});
};

const fetch = (hash)=> {
    axios
    .get(`http://15.165.65.200/products/detail/${hash}`)
    .then((response) => {
      setProduct(response.data.content);
      
    })
  };

  return (
    <React.Fragment>
      <CarouselWrap>
        <CarouselContentWrap>
          <CarouselCategory>{props.category}</CarouselCategory>
          <CarouselTitle>{props.title}</CarouselTitle>
          <Slider
            style={{ display: "flex", alignItems: "center" }}
            {...settings}
          >
            {props.data.map((list) => {
              return (
                <CarouselItemWrap onClick={openModal}>
                  <CarouselItem
                    hash={list.hash}
                    title={list.title}
                    alt={list.alt}
                    description={list.description}
                    salePrice={list.salePrice}
                    normalPrice={list.normalPrice}
                    image={list.image}
                    deliveryTypes={list.deliveryTypes}
                    badges={list.badges}
                  />
                </CarouselItemWrap>
              );
            })}
          </Slider>
        </CarouselContentWrap>
      </CarouselWrap>
      <div style={modalStyle}>
        <Modal
          setModalStyle={setModalStyle}
          title={product.title}
          description={product.description}
          salePrice={product.salePrice}
          normalPrice={product.normalPrice}
          point={product.point}
          deliveryFee={product.deliveryFee}
          deliveryInfo={product.deliveryInfo}
          topImage={product.topImage}
          thumbImages={product.thumbImages}
        />
      </div>
    </React.Fragment>
  );
};

export default Carousel;
