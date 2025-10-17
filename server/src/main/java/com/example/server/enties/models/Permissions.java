package com.example.server.enties.models;

import jakarta.persistence.*;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.util.Collection;
import java.util.UUID;

@Entity
@Table(name = "permissions")
@Data
@Getter
@Setter
public class Permissions {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID permissionId;
    @Column(name = "permission_Name")
    private String permissionName;
    @Column(name = "description")
    private String permissionDescription;

}
