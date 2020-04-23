import React from 'react';
import styled from '@emotion/styled';
import Header from './components/Header/Header';
import Navigation from './components/Navigation/Navigation';
import Carousel from './components/Carousel/Carousel';
import { createGlobalStyle } from "styled-components";
import reset from "styled-reset";



function App() {

  const StyleReset = createGlobalStyle`
        ${reset};
    `;

  const Wrap = styled.div`
    width : 100%;
    text-align : center;
    padding : 5px;
    box-sizing : border-box;
  `
  return (
    <React.Fragment>
      <StyleReset/>
    <Wrap>
      <Header/>
      <Navigation/>
      <Carousel/>
    </Wrap>
    </React.Fragment>
  );
}

export default App;
