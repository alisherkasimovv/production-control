package uz.pc.db.entities;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.lang.Nullable;
import uz.pc.db.entities.base.UpdateBaseEntity;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Entity
@Table(name = "db_employees")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Employee extends UpdateBaseEntity {

    @NotNull
    @Column(name = "first_name")
    private String firstName;

    @Nullable
    @Column(name = "second_name")
    private String secondName;

    @Nullable
    @Column(name = "experience")
    private double experience;

    @Nullable
    @Column(name = "group_id")
    private int groupId = 0;

    @Nullable
    @Column(name = "card_id", unique = true)
    private String cardId;

    @Nullable
    @Column(name = "is_card_disabled")
    private boolean cardDisabled = false;

}
