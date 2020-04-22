import React from 'react';
import styled from '@emotion/styled';
import Header from './components/Header/Header';
import Navigation from './components/Navigation/Navigation';
import Carousel from './components/Carousel/Carousel';

function App() {
  
  const Test = styled.div`
    background-color : orchid;
    color : #fff;
    text-align : center;
  `
  const Wrap = styled.div`
    width : 100%;
    text-align : center;
    padding : 5px;
    box-sizing : border-box;
  `
  return (
    <Wrap>
      <Header/>
      <Navigation/>
      <Carousel/>
    </Wrap>
  );
}

export default App;
