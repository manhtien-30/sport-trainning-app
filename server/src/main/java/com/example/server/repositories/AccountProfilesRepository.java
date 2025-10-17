package com.example.server.repositories;


import com.example.server.enties.models.AccountProfiles;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface AccountProfilesRepository extends JpaRepository<AccountProfiles, UUID> {

}
