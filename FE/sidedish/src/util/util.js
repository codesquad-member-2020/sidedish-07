const preventScroll = (element,boolean) => {
    let scrollProperty;
    boolean === true ? (scrollProperty = "hidden") : (scrollProperty = "auto");
    element.style.overflow = scrollProperty;
  };

  export default preventScroll;