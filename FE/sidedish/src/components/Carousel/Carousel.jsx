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
    color : #424242;
    font-size : 30px;
    margin-bottom : 45px;
  `;

  const CarouselItemWrap = styled.div`
    outline : none;
    border : none;
  `;
    
    let sidedish = [];

    let [sideCarousel, setSideCarousel] = useState([]);
    let [mainCarousel, setMainCarousel] = useState([]);
    let [soupCarousel, setSoupCarousel] = useState([]);

    useEffect(() => {
      axios.get("http://15.165.65.200/products/side").then((response) => {
        setSideCarousel(response.data.content);
      });
    }, []);

    useEffect(() => {
      axios.get("http://15.165.65.200/products/main").then((response) => {
        setMainCarousel(response.data.content);
      });
    }, []);

    useEffect(() => {
      axios.get("http://15.165.65.200/products/soup").then((response) => {
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

    const [modalStyle, setModalStyle] = useState({display : "none"})

      const openModal = ()=> {
        const body = document.querySelector("body");
        preventScroll(body,true)
        setModalStyle({})  
    };

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
            <CarouselItemWrap data-hash = {list.hash} onClick = {openModal}>
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
          </CarouselItemWrap>
        );
      })}
        </Slider>
        </CarouselContentWrap>
      </CarouselWrap>
      <div style={modalStyle}><Modal/></div>
    </React.Fragment>
  );
};

export default Carousel;
