package uz.pc.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import uz.pc.db.dao.interfaces.EmployeeDAO;
import uz.pc.db.dao.interfaces.GroupDAO;
import uz.pc.db.entities.Employee;
import uz.pc.db.entities.Group;

import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/employees")
@CrossOrigin("http://localhost:3000")
public class EmployeeController {

    private EmployeeDAO dao;
    private GroupDAO groupDAO;

    @Autowired
    public EmployeeController(EmployeeDAO dao, GroupDAO groupDAO) {
        this.dao = dao;
        this.groupDAO = groupDAO;
    }

    @RequestMapping(value = "/get", method = RequestMethod.GET)
    public ResponseEntity<List<Employee>> getAll() {
        return new ResponseEntity<>(dao.getAll(), HttpStatus.OK);
    }

    @RequestMapping(value = "/get/groups", method = RequestMethod.GET)
    public ResponseEntity<List<Group>> getGroups() {
        return new ResponseEntity<>(groupDAO.getAll(), HttpStatus.OK);
    }

    @RequestMapping(value = "/get/{id}", method = RequestMethod.GET)
    public ResponseEntity<Employee> get(@PathVariable int id) {
        if (id == -1)
            return new ResponseEntity<>(new Employee(), HttpStatus.OK);
        return new ResponseEntity<>(dao.getById(id), HttpStatus.OK);
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public ResponseEntity<String> save(@Valid @RequestBody Employee employee) {
        System.out.println(employee.getCardId());
        System.out.println(employee.isCardDisabled());
        boolean response = dao.saveEmployee(employee);
        if (!response) return new ResponseEntity<>("This id has saved already!!!", HttpStatus.OK);
        return new ResponseEntity<>("Saved", HttpStatus.OK);
    }

    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    public ResponseEntity<String> edit(@Valid @RequestBody Employee employee) {
        System.out.println(employee.getCardId());
        System.out.println(employee.isCardDisabled());
        boolean response = dao.saveEmployee(employee);
        if (!response) return new ResponseEntity<>("This id has saved already!", HttpStatus.OK);
        return new ResponseEntity<>("Saved", HttpStatus.OK);
    }

    @RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
    public ResponseEntity<List<Employee>> delete(@PathVariable int id) {
        dao.deleteEmployee(id);
        return new ResponseEntity<>(dao.getAll(), HttpStatus.OK);
    }

}
