import React from 'react';
import styled from '@emotion/styled'

const Header = () => {

    const Header = styled.div`
        width : 100%;
        display : flex;
        justify-content : center;
        margin : 5px;
    `;
    const HeaderWrap = styled.div`
         width : 1300px;
        display : flex;
        flex-direction : column;
        justify-content : center;
        text-align : center;
    `;
    const HeaderTopWrap = styled.div`
        width : 1300px;
        display : flex;
        justify-content : space-between;
    `;
    const UserMenu = styled.div`
        color : #6E6E6E;
        font-size : 12px;
        margin-right : 10px;
    `;
    const AppLink = styled.div`
        font-size : 12px;
        color : #6E6E6E;
        margin-left : 12px;
    `;
    const Line = styled.div`
        width : 100%;
        height : 1px;
        background : gray;
        margin : 10px;
    `;
    const HeaderContentWrap = styled.div`
        height : 130px;
        display : flex;
        line-height : 130px;
    `;
    const Logo = styled.img`
        height : 130px;
        margin-left : 10px;
    `;
    const SearchBar = styled.div`
        margin : 0px 20px;
    `;
    const SearchInput = styled.input`
        width : 250px;
        height : 30px;
        margin-left : 20px;
    `;
    const SearchBtn = styled.button`
    
    `;
    const HeaderBtn = styled.div`
    
    `;
    const HeaderBtnTop = styled.div`
    
    `;
    const HeaderBtnTitle = styled.div`
    
    `;
    return (
        <Header>
        <HeaderWrap>
          <HeaderTopWrap>
                <AppLink>배민찬 앱 다운로드 ▼</AppLink>
                <UserMenu> 로그인 ｜ 회원가입 ｜ 마이페이지 ｜ 고객센터 ｜ 새벽배송지역검색 ｜ 이벤트게시판 ｜ 장바구니  </UserMenu>
            </HeaderTopWrap>
            <Line/>
            <HeaderContentWrap>
                <Logo src="https://www.dailypop.kr/news/photo/201811/36399_61481_3927.jpg"/>
                <SearchBar><SearchInput/></SearchBar>
            </HeaderContentWrap>
        </HeaderWrap>   
        </Header>
    );
};

export default Header;