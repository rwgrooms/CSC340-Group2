package com.realestatedirect.api.security;

import com.realestatedirect.api.crud.User;
import com.realestatedirect.api.crud.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.*;
import org.springframework.stereotype.Service;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    private UserRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepository.findByUserName(username)
            .orElseThrow(() -> new UsernameNotFoundException("User not found"));


        String mappedRole = switch (user.getRole()) {
                case 1 -> "BUYER";
                case 2 -> "SELLER";
                default -> throw new IllegalStateException("Unknown role: " + user.getRole());
            };

        return org.springframework.security.core.userdetails.User
            .withUsername(user.getEmail())
            .password(user.getPassword())
            .roles(mappedRole) // or use user.getRole()
            .build();
    }
}
