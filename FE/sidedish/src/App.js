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
  // const wrap
  return (
    <React.Fragment>
      <Header/>
      <Navigation/>
      <Carousel/>
    </React.Fragment>
  );
}

export default App;
