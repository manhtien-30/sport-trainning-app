package com.example.server.services;

import com.example.server.enties.dto.ApiResponseDto;
import com.example.server.enties.dto.SignInRequestDto;
import com.example.server.enties.dto.SignUpRequestDto;
import com.example.server.utils.exceptions.RoleNotFoundException;
import com.example.server.utils.exceptions.UserAlreadyExistsException;
import org.springframework.http.ResponseEntity;

public interface AuthenticatedService {
    ResponseEntity<ApiResponseDto<?>> signUp(SignUpRequestDto signUpRequestDto) throws UserAlreadyExistsException, RoleNotFoundException;

    ResponseEntity<ApiResponseDto<?>> signIn(SignInRequestDto signInRequestDto);
}