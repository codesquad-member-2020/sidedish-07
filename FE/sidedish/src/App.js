import React from 'react';
import styled from '@emotion/styled';
import Header from './components/Header/Header';
import Menu from './components/Menu/Menu';
import Carousel from './components/Carousel/Carousel';

function App() {
  
  const Test = styled.div`
    background-color : orchid;
    color : #fff;
    text-align : center;
  `

  return (
    <React.Fragment>
      <Test>Test</Test>
      <Header/>
      <Menu/>
      <Carousel/>
    </React.Fragment>
  );
}

export default App;
