package com.example.server.enties.dto;

import lombok.Builder;
import lombok.Data;

import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;

@Data
@Builder
public class SignInResponseDto {
    private String token;
    private String type = "Bearer";
    private UUID id;
    private String username;
    private String email;
    @Builder.Default
    private OffsetDateTime lastLogin = OffsetDateTime.now();
    private List<String> roles;
}