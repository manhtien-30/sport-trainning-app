package com.example.server.enties.dto;

import com.example.server.enties.models.Roles;
import lombok.*;

import java.time.OffsetDateTime;
import java.util.List;
import java.util.Set;
import java.util.UUID;

@Data
@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class AccountDto {
    private UUID accountId;
    private String username;
    private String email;
    private String firstName;
    private String lastName;
    private String phone;
    private Set<Roles> roles;
}
