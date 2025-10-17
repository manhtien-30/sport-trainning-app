package com.example.server.enties.models;

import com.example.server.enties.models.Enum.ERole;
import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.LinkedHashSet;
import java.util.Set;
import java.util.UUID;

@Entity
@Table(name = "roles")
@Data
@NoArgsConstructor
public class Roles {
    @Id
    @Column(name = "role_id")
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID idRole;
    @Column(name = "role_name")
    @Enumerated(EnumType.STRING)
    private ERole name;

    public Roles(ERole name) {
        this.name = name;
    }

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name = "role_permissions",
            joinColumns = @JoinColumn(name = "role_id"),
            inverseJoinColumns = @JoinColumn(name = "permission_id"))
    private Set<Permissions> permissions = new LinkedHashSet<>();

}
