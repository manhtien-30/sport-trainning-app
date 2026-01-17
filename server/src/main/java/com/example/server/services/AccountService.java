package com.example.server.services;


import com.example.server.enties.dto.AccountDto;
import com.example.server.enties.dto.ApiResponseDto;
import com.example.server.enties.models.Account;
import org.springframework.http.ResponseEntity;

import java.time.OffsetDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface AccountService {
    void save(Account account);
    void updateLastlogin(String username, OffsetDateTime lastLogin);
    void update(Account account);
    ResponseEntity<ApiResponseDto<?>> getProfileDetails(UUID id);
    Boolean existByEmail(String email);
    Boolean existByUsername(String username);


}