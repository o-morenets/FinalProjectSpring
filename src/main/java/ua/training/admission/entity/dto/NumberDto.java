package ua.training.admission.entity.dto;

import lombok.Data;

import jakarta.validation.constraints.DecimalMax;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotNull;

@Data
public class NumberDto {

    @NotNull
    @DecimalMin("0.0")
    @DecimalMax("100.0")
    private Double passGrade;
}
