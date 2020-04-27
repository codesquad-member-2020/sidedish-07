import React from 'react';
import styled from "@emotion/styled";

const CarouselItem = (props) => {

    const ItemWrap = styled.div`
        width : 300px;
        display : flex;
        flex-direction : column;
        justify-content : center;
        align-items : center;

    `;

    const ItemImage = styled.img`
        width : 200px;
        height : 200px;
        border-radius : 200px;
    `;

    const ItemHover = styled.div``;

    const ItemTitle = styled.div`
        width : 250px;
        height : 35px;
        /* line-height : 30px; */
        font-size : 18px;
        font-weight : bold;
        color : black;
        margin-top : 25px;
    `;

    const ItemDescription = styled.div`
        width : 220px;
        height : 30px;
        color : grey;
        font-size : 15px;
        margin-top : 10px;
        font-weight : bold;

    `;

    const ItemPrice = styled.div`
        width : 80%;
        height : 50px;
        line-height : 50px;
        display : flex;
        justify-content : center;
    `;

    const BeforePrice = styled.span` 
        font-size : 18px;
        color : grey;
        text-decoration : line-through;
        font-weight : bold;
        margin-right : 8px;
    `;

    const Price = styled.span`
        font-size : 27px;
        color : #18C2BD;
        font-weight : bold;

    `;
    const BadgeWrap = styled.div`
      box-sizing: border-box;
      width : 400px;
      display : flex;
      justify-content : center;
    `;

    const EventBadge = styled.div`
        font-size : 12px;
        color : white;
        font-weight  : bold;
        background : #cc81e2;
        margin-top : 10px;
        box-sizing : border-box;
        padding : 7px;
        margin-left : 5px;
    `;

    const priceRender = ()=>{
        if(props.salePrice === '0원') return <Price>{props.normalPrice}</Price>
        return <React.Fragment><BeforePrice>{props.normalPrice}</BeforePrice><Price>{props.salePrice}</Price></React.Fragment>
    }

    const badgeRender = ()=>{
        if(props.badges == '') return
        for(let i = 0; i<props.badges.length; i++ ){
        return <EventBadge>{props.badges[i]}</EventBadge>
        
    }
    }

    return (
      <ItemWrap>
        <ItemImage src={props.image} />
        <ItemTitle>{props.title}</ItemTitle>
        <ItemDescription>{props.description}</ItemDescription>
        <ItemPrice>{priceRender()}</ItemPrice>
        <BadgeWrap> {badgeRender()}</BadgeWrap>
      </ItemWrap>
    );
};

export default CarouselItem;