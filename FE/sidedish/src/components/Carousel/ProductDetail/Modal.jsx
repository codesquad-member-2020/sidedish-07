import React, { useState, useEffect } from "react";
import styled from "@emotion/styled";
import axios from "axios";
import preventScroll from "../../../util/util";


const Modal = (props) => {

    const ProductModal = styled.div`
        position : fixed;
        top : 0;
        left : 0;
        width : 100%;
        height : 100%;
        background-color: rgba(0,0,0,0.4);
        display : flex;
        justify-content : center;
        align-items : center;
        z-index : 1; 
    `;

    const ProductBackground = styled.div`
        width : 910px;
        height : 700px;
        background : white;
        z-index : 2;
        box-sizing : border-box;
        display : flex;
        flex-direction : column;
    `;

    const ProductWrap = styled.div`
        width : 100%;
        height : 62%;
        display : flex;
        box-sizing : border-box;
    `;

    const ProductImageWrap = styled.div`
        width : 43%;
        height : 100%;
        border : solid 1px red;
        box-sizing : border-box;
    `;

    const ProductInfoWrap = styled.div`
        width : 57%;
        height : 100%;
        border : solid 1px blue;
        box-sizing : border-box;

    `;
    const CloseBtn = styled.img`
        width : 20px;
    `;
    const RecommentProductWrap = styled.div`
        width : 100%;
        height : 38%;
        border : solid 1px hotpink;
        box-sizing : border-box;

    `;

    const closeBtnClickHandler = ()=>{
        const body = document.querySelector("body");
        preventScroll(body,false);        
        props.setModalStyle({display : "none"});
    };

    return (
        <>
        <ProductModal>
            <ProductBackground>
                <ProductWrap>
                <ProductImageWrap></ProductImageWrap>
                <ProductInfoWrap>
                    <CloseBtn src = "https://image.flaticon.com/icons/svg/748/748122.svg" onClick={closeBtnClickHandler}/>
                </ProductInfoWrap>
                </ProductWrap>
                <RecommentProductWrap></RecommentProductWrap>
            </ProductBackground>
        </ProductModal>
        </>
    );
};

export default Modal;