import React, { useState, useEffect } from "react";
import styled from '@emotion/styled';
import Header from './components/Header/Header';
import Navigation from './components/Navigation/Navigation';
import Carousel from './components/Carousel/Carousel';
import { createGlobalStyle } from "styled-components";
import reset from "styled-reset";
import axios from "axios";

function App() {


  const StyleReset = createGlobalStyle`
        ${reset};
    `;

  const Wrap = styled.div`
    width : 100%;
    /* height : 930px; */
    padding : 5px;
    box-sizing : border-box;
    margin : auto;
    /* overflow : hidden; */
  `;

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

  return (
    <React.Fragment>
      <StyleReset/>
    <Wrap>
      <Header/>
      <Navigation/>
      <Carousel data = {sideCarousel} category="밑반찬" title="언제 먹어도 든든한 반찬"/>
      <Carousel data = {mainCarousel} category="메인반찬" title="담기만 하면 완성되는 메인반찬"/>
      <Carousel data = {soupCarousel} category="국·찌개" title="김이 모락모락 국,찌개"/>
    </Wrap>
    </React.Fragment>
     );
}

export default App;
