package com.example.server.repositories;

import com.example.server.enties.models.Enum.ERole;
import com.example.server.enties.models.Roles;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface RoleRepository extends JpaRepository<Roles, UUID> {
    Roles findByName(ERole name);
}
