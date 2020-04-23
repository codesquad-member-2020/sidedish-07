package com.codesquad.sidedish.exception;

public class ResourceNotFound extends RuntimeException {

    public ResourceNotFound() {
        super("리소스를 찾을 수 없습니다.");
    }
}
