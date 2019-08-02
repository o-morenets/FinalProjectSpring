package ua.training.admission.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table
public class Message {

    @Id
    private Long id;

    private double averageGrade;

    private String message;

    private boolean messageRead;

    @OneToOne
    @MapsId
    private User user;
}
