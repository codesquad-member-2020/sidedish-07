// import React from 'react';
import styled from "@emotion/styled";
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";
import Slider from "react-slick";
import Arrow from "./Arrow";
import CarouselItem from "./CarouselItem";
import axios from "axios";
import React, { useState, useEffect } from "react";
import { findByLabelText } from "@testing-library/react";


const Carousel = (props) => {
  const settings = {
    dots: false,
    infinite: true,
    speed: 500,
    slidesToScroll: 4,
    slidesToShow: 4,
    nextArrow: <Arrow type="next" />,
    prevArrow: <Arrow type="prev" />,
  };

  const CarouselWrap = styled.div`
    width : 100%;
    display : flex;
    justify-content : center;
    margin : 15px;
  `;

  const CarouselContentWrap = styled.div`
    width : 1300px;
    display : flex;
    justify-content : center;
    flex-direction : column;
    text-align : center;
    padding : 10px 10px 30px 10px;
    box-sizing : border-box;
  `;

  const CarouselCategory = styled.div`
    color : grey;
    font-size : 20px;
    margin : 10px 10px 20px 10px;
    font-weight : bold;
  `;

  const CarouselTitle = styled.div`
    color : #424242;
    font-size : 25px;
    margin-bottom : 45px;
    font-weight : bold;
  `;
    
    let sidedish = [];

    let [sideCarousel, setSideCarousel] = useState([]);
    let [mainCarousel, setMainCarousel] = useState([]);
    let [soupCarousel, setSoupCarousel] = useState([]);

    useEffect(() => {
      axios.get("http://15.164.63.83:8080/products/side").then((response) => {
        setSideCarousel(response.data.content);
      });
    }, []);

    useEffect(() => {
      axios.get("http://15.164.63.83:8080/products/main").then((response) => {
        setMainCarousel(response.data.content);
      });
    }, []);

    useEffect(() => {
      axios.get("http://15.164.63.83:8080/products/soup").then((response) => {
        setSoupCarousel(response.data.content);

      });
    }, []);

    const setData = ()=>{
        switch(props.category){
            case "밑반찬" :
                sidedish = sideCarousel;
                break;
            case "메인반찬" :
                sidedish = mainCarousel;
                break;
            case "국·찌개" :
                sidedish = soupCarousel;
                break;    
        }
    }

  return (
    <React.Fragment>
        {setData()}
      <CarouselWrap>
          <CarouselContentWrap>
        <CarouselCategory>{props.category}</CarouselCategory>
        <CarouselTitle>{props.title}</CarouselTitle>
        <Slider style={{display : "flex", alignItems : "center"}} {...settings}> 
        {sidedish.map((list) => {
        return (
          <CarouselItem
            hash = {list.hash}
            title = {list.title}
            alt = {list.alt}
            description = {list.description}
            salePrice = {list.salePrice}
            normalPrice = {list.normalPrice}
            image = {list.image}
            deliveryTypes = {list.deliveryTypes}
            badges = {list.badges}
          />
        );
      })}
        </Slider>
        </CarouselContentWrap>
      </CarouselWrap>
    </React.Fragment>
  );
};

export default Carousel;
