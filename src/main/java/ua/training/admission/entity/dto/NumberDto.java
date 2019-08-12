package ua.training.admission.entity.dto;

import lombok.Data;

import javax.validation.constraints.DecimalMax;
import javax.validation.constraints.DecimalMin;
import javax.validation.constraints.NotNull;

@Data
public class NumberDto {

    @NotNull
    @DecimalMin("0.0")
    @DecimalMax("100.0")
    private Double passGrade;
}
