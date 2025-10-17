package com.example.server.enties.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.io.Serial;
import java.util.*;
import java.util.stream.Collectors;

@Data
@AllArgsConstructor
public class UserDetailsImpl implements UserDetails {
    @Serial
    private static final long serialVersionUID = 1L;
    private UUID id;
    private String username;
    private String password;
    private String email;
    private boolean isEnabled;
    private Collection<? extends GrantedAuthority> authorities;

    public static UserDetailsImpl build(Account account) {
        List<GrantedAuthority> authorities = account.getRoles().stream()
                .map(role -> new SimpleGrantedAuthority(role.getName().name()))
                .collect(Collectors.toList());
//        Set<GrantedAuthority> grantedAuthorities = new HashSet<>();
//        account.getRoles().forEach(role -> {
//            grantedAuthorities.add(new SimpleGrantedAuthority(role.getName().name()));
//            role.getPermissions().forEach(permission -> {
//                grantedAuthorities.add(new SimpleGrantedAuthority(permission.getPermissionName()));
//            });
//        });
        return new UserDetailsImpl(
                account.getId(),
                account.getUsername(),
                account.getPassword(),
                account.getEmail(),
                account.getIsActive(),
                authorities
        );
    }
    @Override
    public boolean isAccountNonExpired() {
return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }

    @Override
    public String toString() {
        return "UserDetailsImpl{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", email='" + email + '\'' +
                ", isEnabled=" + isEnabled +
                ", authorities=" + authorities +
                '}';
    }

}
