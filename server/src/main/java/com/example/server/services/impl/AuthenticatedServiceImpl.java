package com.example.server.services.impl;

import com.example.server.enties.dto.ApiResponseDto;
import com.example.server.enties.dto.SignInRequestDto;
import com.example.server.enties.dto.SignInResponseDto;
import com.example.server.enties.dto.SignUpRequestDto;
import com.example.server.enties.models.Account;
import com.example.server.enties.models.AccountProfiles;
import com.example.server.enties.models.Enum.ResponseStatus;
import com.example.server.enties.models.Roles;
import com.example.server.enties.models.UserDetailsImpl;
import com.example.server.services.AccountService;
import com.example.server.services.AuthenticatedService;
import com.example.server.utils.exceptions.RoleNotFoundException;
import com.example.server.utils.exceptions.UserAlreadyExistsException;
import com.example.server.utils.factories.RoleFactory;
import com.example.server.utils.security.JwtUtil;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.OffsetDateTime;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class AuthenticatedServiceImpl implements AuthenticatedService {
    @Autowired
    private AccountService accountService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private AuthenticationManager authenticationManager;
    @Autowired
    private RoleFactory roleFactory;
    @Autowired
    private JwtUtil jwtUtils;
    @Override
    public ResponseEntity<ApiResponseDto<?>> signUp(SignUpRequestDto signUpRequestDto)
            throws UserAlreadyExistsException, RoleNotFoundException {
        if (accountService.existByEmail(signUpRequestDto.getEmail())) {
            throw new UserAlreadyExistsException("Registration Failed: Provided email already exists. Try sign in or provide another email.");
        }
        if (accountService.existByUsername(signUpRequestDto.getUsername())) {
            throw new UserAlreadyExistsException("Registration Failed: Provided username already exists. Try sign in or provide another username.");
        }
        Account account = createAccount(signUpRequestDto);
        accountService.save(account);
        return ResponseEntity.status(HttpStatus.CREATED).body(
                ApiResponseDto.builder()
                        .status(String.valueOf(ResponseStatus.SUCCESS))
                        .message("Registration Successful")
                        .build()
        );
    }

    public ResponseEntity<ApiResponseDto<?>> signIn(@Valid SignInRequestDto signInRequestDto) {
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(signInRequestDto.getUsername(), signInRequestDto.getPassword()));

        SecurityContextHolder.getContext().setAuthentication(authentication);

        String jwt = jwtUtils.generateJwtToken(authentication);

        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();
        List<String> roles = userDetails.getAuthorities().stream()
                .map(GrantedAuthority::getAuthority)
                .collect(Collectors.toList());

        SignInResponseDto signInResponseDto = SignInResponseDto.builder()
                .username(userDetails.getUsername())
                .email(userDetails.getEmail())
                .id(userDetails.getId())
                .token(jwt)
                .type("Bearer")
                .roles(roles)
                .build();
        accountService.updateLastlogin(userDetails.getUsername(), signInResponseDto.getLastLogin());
        return ResponseEntity.ok(
                ApiResponseDto.builder()
                        .status(String.valueOf(ResponseStatus.SUCCESS))
                        .message("Sign in successfully!")
                        .response(signInResponseDto)
                        .build()
        );
    }

    private Account createAccount(SignUpRequestDto signUpRequestDto) throws RoleNotFoundException {

        AccountProfiles accountProfiles = AccountProfiles.builder()
                .firstName(signUpRequestDto.getFirstName())
                .lastName(signUpRequestDto.getLastName())
                .build();
        Account account =  Account.builder()
                .email(signUpRequestDto.getEmail())
                .username(signUpRequestDto.getUsername())
                .password(passwordEncoder.encode(signUpRequestDto.getPassword()))
                .roles(determineRoles(signUpRequestDto.getRoles()))
                .createdAt( OffsetDateTime.now())
                .isActive(true)
                .isVerified(true)
                .build();
        accountProfiles.setAccount(account);
        account.setAccountProfiles(accountProfiles);
        return account;
    }
    private Set<Roles> determineRoles(Set<String> strRoles) throws RoleNotFoundException {
        Set<Roles> roles = new HashSet<>();

        if (strRoles == null) {
            roles.add(roleFactory.getInstance("user"));
        } else {
            for (String role : strRoles) {
                roles.add(roleFactory.getInstance(role));
            }
        }
        return roles;
    }
}