package com.example.server.services.impl;

import com.example.server.enties.models.Account;
import com.example.server.enties.models.UserDetailsImpl;
import com.example.server.repositories.AccountRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {
    @Autowired
    private AccountRepository accountRepository;
    @Override
    @Transactional
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Account account =  accountRepository.findByUsername(username)
                .orElseThrow(()-> new UsernameNotFoundException("User not found"));
       // System.out.println(account.toString());

        return UserDetailsImpl.build(account);
    }
}
