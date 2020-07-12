package uz.pc.controllers;

import javassist.bytecode.ByteArray;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import uz.pc.db.dto.Filter;
import uz.pc.db.dto.salary.SalariesDTO;
import uz.pc.db.dao.interfaces.EmployeeDAO;
import uz.pc.services.XLSHandlerService;

import javax.validation.Valid;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

@RestController
@Slf4j
@RequestMapping("/salaries")
@CrossOrigin("http://localhost:3000")
public class SalariesController {

    private EmployeeDAO dao;

    public SalariesController(EmployeeDAO dao) {
        this.dao = dao;
    }

    @RequestMapping(value = "/filter", method = RequestMethod.POST)
    public ResponseEntity<List<SalariesDTO>> getFiltered(@Valid @RequestBody Filter filter) {
        return new ResponseEntity<>(dao.getSalariesInformation(filter), HttpStatus.OK);
    }

    @RequestMapping(value = "/save-to-file", method = RequestMethod.POST)
    public ResponseEntity<ByteArrayResource> saveToFile(@Valid @RequestBody Filter filter) {
        List<SalariesDTO> collection = dao.getSalariesInformation(filter);
        XLSHandlerService xls = new XLSHandlerService(collection, filter.getStart(), filter.getEnd());

        xls.createXls(true);

        try {
            HttpHeaders header = new HttpHeaders();
            header.setContentType(new MediaType("application", "force-download"));
            header.set(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=ProductTemplate.xlsx");
            return new ResponseEntity<>(new ByteArrayResource(Files.readAllBytes(Paths.get("segmented.xlsx"))),
                    header, HttpStatus.CREATED);
        } catch (Exception e) {
            log.error(e.getMessage());
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @RequestMapping(value = "/save-overall", method = RequestMethod.POST)
    public ResponseEntity<ByteArrayResource> saveOverallToFile(@Valid @RequestBody Filter filter) throws Exception {
        List<SalariesDTO> collection = dao.getSalariesInformation(filter);
        XLSHandlerService xls = new XLSHandlerService(collection, filter.getStart(), filter.getEnd());

        xls.createXls(false);

        try {
            HttpHeaders header = new HttpHeaders();
            header.setContentType(new MediaType("application", "vnd.openxmlformats-officedocument.spreadsheetml.sheet"));
            header.set(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=ProductTemplate.xlsx");
            return new ResponseEntity<>(new ByteArrayResource(Files.readAllBytes(Paths.get("overall.xlsx"))),
                    header, HttpStatus.CREATED);
        } catch (Exception e) {
            log.error(e.getMessage());
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

}
