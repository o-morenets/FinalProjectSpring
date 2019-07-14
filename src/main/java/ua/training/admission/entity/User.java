package ua.training.admission.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import java.util.Collection;
import java.util.Set;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "usr", uniqueConstraints = {@UniqueConstraint(columnNames = "username")})
public class User implements UserDetails {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @NotBlank(message = "form.invalid.username.empty")
    private String username;

    @NotBlank(message = "form.invalid.password")
    private String password;

    @Email(message = "Email is not correct")
    @NotBlank(message = "Email cannot be empty")
    private String email;

    @ElementCollection(targetClass = Role.class, fetch = FetchType.EAGER)
    @CollectionTable(name = "user_role", joinColumns = @JoinColumn(name = "user_id"))
    @Enumerated(EnumType.STRING)
    @Column(name = "role_name")
    private Collection<Role> authorities;

    private boolean accountNonExpired;

    private boolean accountNonLocked;

    private boolean credentialsNonExpired;

    private boolean enabled;

    @NotBlank(message = "First Name cannot be empty")
    @Column(name = "first_name")
    private String firstName;

    @NotBlank(message = "Last Name cannot be empty")
    @Column(name = "last_name")
    private String lastName;

    @OneToMany(mappedBy = "user", fetch = FetchType.EAGER)
    private Set<SubjectGrade> grades;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "speciality_id")
    @OnDelete(action = OnDeleteAction.CASCADE)
    private Speciality speciality;

    public boolean isAdmin() {
        return authorities.contains(Role.ADMIN);
    }
}
