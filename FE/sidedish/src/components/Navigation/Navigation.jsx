import React from 'react';
import styled from '@emotion/styled'


const Navigation = () => {

    const NavWrap = styled.div`
        background : #483F35;
        display : flex;
        justify-content : center;
    `;

    const NavUL = styled.ul`
        width : 700px;
        height : 20px;
        display : flex;
        justify-content : space-around;
    `;
    const Nav = styled.li`
        height : 20px;
        line-height : 20px;
        color : white;
        font-size : 8px;
        font-weight : normal;
        &:hover{
            color : #18C2BD;
        };
    `;
    return (
        <div>
           <NavWrap>
               <NavUL>
               <Nav>밑반찬</Nav>
               <Nav>메인반찬</Nav>
               <Nav>국·찌개·탕</Nav>
               <Nav>아이반찬</Nav>
               <Nav>육류구이관</Nav>
               <Nav>김치·장아찌</Nav>
               <Nav>세계음식</Nav>
               <Nav>밥·죽·면</Nav>
               <Nav>샐러드</Nav>
               <Nav>간식</Nav>
               <Nav>정기식단</Nav>
               <Nav>반찬브랜드</Nav>
               </NavUL>
           </NavWrap>
        </div>
    );
};

export default Navigation;