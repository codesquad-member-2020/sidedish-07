import React from 'react';
import styled from '@emotion/styled'

const Header = () => {
    const HeaderTopWrap = styled.div`
        display : flex;
        justify-content : space-between;
    `;
    const UserMenu = styled.div`
        color : #6E6E6E;
        font-size : 8px;
        margin-right : 10px;
    `;
    const AppLink = styled.div`
        font-size : 8px;
        color : #6E6E6E;
        margin-left : 10px;
    `;
    const LineWrap = styled.div`
        width : 100%;
        text-align : center;
    `;
    const Line = styled.div`
        width : 99%;
        height : 1px;
        background : gray;
        margin : 5px;
    `;
    const HeaderContentWrap = styled.div`
        height : 70px;
        display : flex;
        line-height : 70px;
    `;
    const Logo = styled.img`
        height : 70px;
        margin-left : 10px;
    `;
    const SearchBar = styled.div`
        margin : 0px 20px;
    `;
    const SearchInput = styled.input`
        height : 10px;
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
        <React.Fragment>
          <HeaderTopWrap>
                <AppLink>배민찬 앱 다운로드 ▼</AppLink>
                <UserMenu> 로그인 ｜ 회원가입 ｜ 마이페이지 ｜ 고객센터 ｜ 새벽배송지역검색 ｜ 이벤트게시판 ｜ 장바구니  </UserMenu>
            </HeaderTopWrap>
            <LineWrap><Line/></LineWrap>
            <HeaderContentWrap>
                <Logo src="https://www.dailypop.kr/news/photo/201811/36399_61481_3927.jpg"/>
                <SearchBar><SearchInput/></SearchBar>
            </HeaderContentWrap>
            </React.Fragment>
    );
};

export default Header;