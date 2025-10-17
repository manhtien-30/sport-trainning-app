package com.example.server.services;

import com.example.server.enties.dto.ApiResponseDto;
import com.example.server.enties.dto.SignInRequestDto;
import com.example.server.enties.dto.SignUpRequestDto;
import com.example.server.utils.exceptions.RoleNotFoundException;
import com.example.server.utils.exceptions.UserAlreadyExistsException;
import org.example.testing_api_server.utils.exceptions.RoleNotFoundException;
import org.example.testing_api_server.utils.exceptions.UserAlreadyExistsException;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

public interface AuthenticatedService {
    ResponseEntity<ApiResponseDto<?>> signUp(SignUpRequestDto signUpRequestDto) throws UserAlreadyExistsException, RoleNotFoundException, UserAlreadyExistsException, RoleNotFoundException;

    ResponseEntity<ApiResponseDto<?>> signIn(SignInRequestDto signInRequestDto);
}