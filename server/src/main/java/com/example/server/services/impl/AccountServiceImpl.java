package com.example.server.services.impl;

import com.example.server.enties.dto.AccountDto;
import com.example.server.enties.dto.ApiResponseDto;
import com.example.server.enties.models.Account;
import com.example.server.repositories.AccountProfilesRepository;
import com.example.server.repositories.AccountRepository;
import com.example.server.services.AccountService;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.beans.Transient;
import java.time.OffsetDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;


@Service
@RequiredArgsConstructor
public class AccountServiceImpl implements AccountService {
    @Autowired
    private AccountRepository accountRepository;
    private final ModelMapper modelMapper;
    private AccountProfilesRepository accountProfilesRepository;
    @Override
    //@Transactional
    public void save(Account account) {
        //accountProfilesRepository.save(account.getAccountProfiles());
        accountRepository.save(account);
    }

    @Override
    public void updateLastlogin(String username, OffsetDateTime lastLogin) {
        Account account = accountRepository.findByUsername(username).orElseThrow(()-> new RuntimeException("User not found"));
        account.setLastLogin(lastLogin);
        accountRepository.save(account);
    }

    @Override
    public void update(Account account) {
        accountRepository.save(account);
    }

    @Override
    public ResponseEntity<ApiResponseDto<?>> getProfileDetails(UUID id) {
        return ResponseEntity.ok(
                ApiResponseDto.builder()
                        .status("")
                        .message("")
                        .response(accountProfilesRepository.findById(id))
                        .build()
        );
    }



    @Override
    public Boolean existByEmail(String email) { return accountRepository.existsByEmail(email);
    }

    @Override
    public Boolean existByUsername(String username) {
        return accountRepository.existsByUsername(username);
    }

    private AccountDto toAccountDto(Account account) {
        return AccountDto.builder()
                .accountId(account.getId())
                .username(account.getUsername())
                .email(account.getEmail())
                .firstName(account.getAccountProfiles().getFirstName())
                .lastName(account.getAccountProfiles().getLastName())
                .phone(account.getAccountProfiles().getPhone())
                .roles(account.getRoles())
                .build();
    }

}
