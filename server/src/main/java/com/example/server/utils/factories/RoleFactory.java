package com.example.server.utils.factories;
import com.example.server.enties.models.Enum.ERole;
import com.example.server.enties.models.Roles;
import com.example.server.repositories.RoleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class RoleFactory {
    @Autowired
    private RoleRepository roleRepository;
    public Roles getInstance(String role){
        switch (role){
            case "user" -> {
                return roleRepository.findByName(ERole.ROLE_USER);
            }
            case "admin" -> {
                return roleRepository.findByName(ERole.ROLE_ADMIN);
            }
            case "moderator" -> {
                return roleRepository.findByName(ERole.ROLE_SUPER_ADMIN);
            }
            case "driver" ->{
                return roleRepository.findByName(ERole.ROLE_DRIVER);
            }
            default -> throw new IllegalArgumentException("Invalid role");
        }
    }
}
