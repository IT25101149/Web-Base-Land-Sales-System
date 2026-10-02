package com.landsales.admin.controller;

import com.landsales.admin.entity.AuditLog;
import com.landsales.admin.service.AuditLogService;
import com.landsales.property.entity.Property;
import com.landsales.property.service.PropertyService;
import com.landsales.sales.entity.Sale;
import com.landsales.sales.service.SaleService;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller
@RequestMapping("/admin/export")
public class ExportReportController {

    @Autowired
    private SaleService saleService;

    @Autowired
    private PropertyService propertyService;

    @Autowired
    private AuditLogService auditLogService;

    @GetMapping("/sales.csv")
    public void exportSalesCsv(HttpServletResponse response) throws IOException {
        response.setContentType("text/csv; charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment; filename=\"ceylon_lands_sales_ledger.csv\"");

        PrintWriter writer = response.getWriter();
        writer.println("Sale ID,Property ID,Property Title,Customer ID,Buyer Name,Sale Price (LKR),Advance Paid (LKR),Balance Due (LKR),Sale Date,Sale Status,Payment Status,Legal Status,Deed Number");

        List<Sale> sales = saleService.getAllSales();
        for (Sale s : sales) {
            String propTitle = (s.getProperty() != null && s.getProperty().getTitle() != null) ? s.getProperty().getTitle() : "";
            String buyer = s.getBuyerFullName() != null ? s.getBuyerFullName() : (s.getCustomer() != null ? s.getCustomer().getName() : "");
            writer.printf("%d,%s,\"%s\",%s,\"%s\",%.2f,%.2f,%.2f,%s,%s,%s,%s,\"%s\"\n",
                    s.getId(),
                    s.getProperty() != null ? String.valueOf(s.getProperty().getId()) : "",
                    escapeCsv(propTitle),
                    s.getCustomer() != null ? String.valueOf(s.getCustomer().getId()) : "",
                    escapeCsv(buyer),
                    s.getSalePrice() != null ? s.getSalePrice() : 0.0,
                    s.getAdvancePaid() != null ? s.getAdvancePaid() : 0.0,
                    s.getBalanceAmount() != null ? s.getBalanceAmount() : 0.0,
                    s.getSaleDate() != null ? s.getSaleDate().toString() : "",
                    escapeCsv(s.getStatus()),
                    escapeCsv(s.getPaymentStatus()),
                    escapeCsv(s.getLegalStatus()),
                    escapeCsv(s.getDeedNumber())
            );
        }
        writer.flush();
    }

    @GetMapping("/properties.csv")
    public void exportPropertiesCsv(HttpServletResponse response) throws IOException {
        response.setContentType("text/csv; charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment; filename=\"ceylon_lands_property_inventory.csv\"");

        PrintWriter writer = response.getWriter();
        writer.println("Property ID,Title,Location,Type,Size (Perches),Price (LKR),Status");

        List<Property> properties = propertyService.getAllProperties();
        for (Property p : properties) {
            writer.printf("%d,\"%s\",\"%s\",\"%s\",%.2f,%.2f,%s\n",
                    p.getId(),
                    escapeCsv(p.getTitle()),
                    escapeCsv(p.getLocation()),
                    escapeCsv(p.getType()),
                    p.getSize() != null ? p.getSize() : 0.0,
                    p.getPrice() != null ? p.getPrice() : 0.0,
                    escapeCsv(p.getStatus())
            );
        }
        writer.flush();
    }

    @GetMapping("/audit-logs.csv")
    public void exportAuditLogsCsv(HttpServletResponse response) throws IOException {
        response.setContentType("text/csv; charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment; filename=\"ceylon_lands_audit_trail.csv\"");

        PrintWriter writer = response.getWriter();
        writer.println("Log ID,Timestamp,Action,Module,Operator Username,User Role,IP Address,Status,Description");

        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        List<AuditLog> logs = auditLogService.getAllLogs();
        for (AuditLog l : logs) {
            writer.printf("%d,%s,\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\"\n",
                    l.getId(),
                    l.getTimestamp() != null ? l.getTimestamp().format(dtf) : "",
                    escapeCsv(l.getAction()),
                    escapeCsv(l.getModule()),
                    escapeCsv(l.getUsername()),
                    escapeCsv(l.getUserRole()),
                    escapeCsv(l.getIpAddress()),
                    escapeCsv(l.getStatus()),
                    escapeCsv(l.getDescription())
            );
        }
        writer.flush();
    }

    private String escapeCsv(String value) {
        if (value == null) return "";
        return value.replace("\"", "\"\"");
    }
}

