import styled from '@emotion/styled';
import Header from './components/Header/Header';
import Navigation from './components/Navigation/Navigation';
import Carousel from './components/Carousel/Carousel';
import { createGlobalStyle } from "styled-components";
import reset from "styled-reset";
import axios from "axios";
import React, { useState, useEffect } from "react";



function App() {


  const StyleReset = createGlobalStyle`
        ${reset};
    `;

  const Wrap = styled.div`
    width : 95%;
    padding : 5px;
    box-sizing : border-box;
    margin : auto
  `;

  return (
    <React.Fragment>
      <StyleReset/>
    <Wrap>
      <Header/>
      <Navigation/>
      <Carousel category="밑반찬" title="언제 먹어도 든든한 반찬"/>
      <Carousel category="메인반찬" title="담기만 하면 완성되는 메인반찬"/>
      <Carousel category="국·찌개" title="김이 모락모락 국,찌개"/>
    </Wrap>
    </React.Fragment>
     );
}

export default App;
