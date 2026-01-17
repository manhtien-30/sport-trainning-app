package com.example.server.controller;

import com.example.server.enties.dto.AccountDto;
import com.example.server.enties.dto.ApiResponseDto;
import com.example.server.enties.models.Account;
import com.example.server.enties.models.AccountProfiles;
import com.example.server.services.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController()
@RequestMapping("/api/profile")
public class AccountController {
    @Autowired
    AccountService accountService;
    @GetMapping("/{id}/details")
    ResponseEntity<?> getProfileById(@PathVariable(value = "id") UUID id) {
        return accountService.getProfileDetails(id);
    }
}
