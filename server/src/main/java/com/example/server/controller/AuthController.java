package com.example.server.controller;

import com.example.server.enties.dto.ApiResponseDto;
import com.example.server.enties.dto.SignInRequestDto;
import com.example.server.enties.dto.SignUpRequestDto;
import com.example.server.services.impl.AuthenticatedServiceImpl;
import com.example.server.utils.exceptions.RoleNotFoundException;
import com.example.server.utils.exceptions.UserAlreadyExistsException;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
public class AuthController {
    @Autowired
    private AuthenticatedServiceImpl authenticatedService;
    @PostMapping("/sign-up")
    public ResponseEntity<ApiResponseDto<?>> signUp(@RequestBody @Valid SignUpRequestDto signUpRequestDto)
            throws UserAlreadyExistsException, RoleNotFoundException {
        return authenticatedService.signUp(signUpRequestDto);
    }
    @PostMapping("/sign-in")
    public ResponseEntity<ApiResponseDto<?>> signIn(@RequestBody @Valid SignInRequestDto signInRequestDto) {
        return authenticatedService.signIn(signInRequestDto);
    }
    @PostMapping("/log-out")
    public void logOut(Authentication authentication) {}
}

