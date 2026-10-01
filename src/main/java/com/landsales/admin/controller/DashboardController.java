package com.landsales.admin.controller;

import com.landsales.property.service.PropertyService;
import com.landsales.crm.service.CustomerService;
import com.landsales.sales.service.SaleService;
import com.landsales.admin.service.UserService;
import com.landsales.admin.service.AuditLogService;
import com.landsales.admin.entity.AuditLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.landsales.admin.dto.MonthlyRevenueDTO;
import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

@Controller
public class DashboardController {

    @Autowired
    private PropertyService propertyService;

    @Autowired
    private CustomerService customerService;

    @Autowired
    private SaleService saleService;

    @Autowired
    private UserService userService;

    @Autowired
    private AuditLogService auditLogService;

    @Autowired
    private com.landsales.crm.repository.InquiryRepository inquiryRepository;

    @GetMapping({"/", "/dashboard"})
    public String dashboard(Model model, Authentication authentication) {
        if (authentication != null && authentication.isAuthenticated() && !"anonymousUser".equals(authentication.getName())) {
            if (authentication.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_CUSTOMER"))) {
                return "redirect:/customer/portal";
            }
            if (authentication.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_PROPERTY") || a.getAuthority().equals("ROLE_PROPERTY_MANAGER"))) {
                return "redirect:/property";
            }
            if (authentication.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_SALES"))) {
                return "redirect:/sales";
            }
            if (authentication.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_SURVEY"))) {
                return "redirect:/survey";
            }
            if (authentication.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_LEGAL"))) {
                return "redirect:/legal";
            }
            if (authentication.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"))) {
                return "redirect:/admin/dashboard";
            }
        }
        return "redirect:/home";
    }

    @GetMapping("/admin/dashboard")
    public String adminDashboard(Model model) {
        var properties = propertyService.getAllProperties();
        var customers = customerService.getAllCustomers();
        var sales = saleService.getAllSales();
        var users = userService.getAllUsers();
        var inquiries = inquiryRepository.findAll();
        List<AuditLog> allLogs = auditLogService.getAllLogs();
        List<AuditLog> recentLogs = auditLogService.getRecentLogs(10);

        long totalProperties = properties.size();
        long availableProperties = properties.stream().filter(p -> "AVAILABLE".equals(p.getStatus())).count();
        long reservedProperties = properties.stream().filter(p -> "RESERVED".equals(p.getStatus())).count();
        long soldProperties = properties.stream().filter(p -> "SOLD".equals(p.getStatus())).count();
        double totalRevenue = sales.stream()
                .filter(s -> !"CANCELLED".equalsIgnoreCase(s.getStatus()))
                .mapToDouble(s -> s.getSalePrice() != null ? s.getSalePrice() : 0.0)
                .sum();

        long pendingInquiriesCount = inquiries.stream()
                .filter(i -> "PENDING".equalsIgnoreCase(i.getStatus()) || "PAYMENT_SUBMITTED".equalsIgnoreCase(i.getStatus()))
                .count();

        String todayStr = LocalDate.now().toString();
        long todayAuditLogsCount = allLogs.stream()
                .filter(l -> l.getTimestamp() != null && l.getTimestamp().toLocalDate().toString().equals(todayStr))
                .count();

        // -------------------------------------------------------------
        // Monthly Revenue & Month-over-Month (MoM) Analytics
        // -------------------------------------------------------------
        Map<YearMonth, List<com.landsales.sales.entity.Sale>> salesByMonth = sales.stream()
                .filter(s -> !"CANCELLED".equalsIgnoreCase(s.getStatus()))
                .collect(Collectors.groupingBy(s -> s.getSaleDate() != null ? YearMonth.from(s.getSaleDate()) : YearMonth.now()));

        YearMonth currentYm = YearMonth.now();
        YearMonth lastYm = currentYm.minusMonths(1);

        // Timeline covers at least 6 months up to the current month
        YearMonth earliestMonth = currentYm.minusMonths(5);
        for (YearMonth ym : salesByMonth.keySet()) {
            if (ym.isBefore(earliestMonth)) {
                earliestMonth = ym;
            }
        }

        List<YearMonth> timeline = new ArrayList<>();
        YearMonth cursor = earliestMonth;
        while (!cursor.isAfter(currentYm)) {
            timeline.add(cursor);
            cursor = cursor.plusMonths(1);
        }

        List<MonthlyRevenueDTO> chronologicalSummaries = new ArrayList<>();
        Double prevRevenue = null;
        double peakRevenue = 0.0;
        String peakMonthLabel = "None";

        for (YearMonth ym : timeline) {
            List<com.landsales.sales.entity.Sale> monthSales = salesByMonth.getOrDefault(ym, Collections.emptyList());
            double monthRev = monthSales.stream()
                    .mapToDouble(s -> s.getSalePrice() != null ? s.getSalePrice() : 0.0)
                    .sum();
            long deals = monthSales.size();

            Double growthPct = null;
            Double growthDiff = null;
            if (prevRevenue != null) {
                growthDiff = monthRev - prevRevenue;
                if (prevRevenue > 0) {
                    growthPct = ((monthRev - prevRevenue) / prevRevenue) * 100.0;
                } else if (monthRev > 0) {
                    growthPct = 100.0;
                } else {
                    growthPct = 0.0;
                }
            }

            MonthlyRevenueDTO dto = new MonthlyRevenueDTO(ym, monthRev, deals, growthPct, growthDiff);
            chronologicalSummaries.add(dto);

            if (monthRev > peakRevenue) {
                peakRevenue = monthRev;
                peakMonthLabel = ym.format(DateTimeFormatter.ofPattern("MMMM yyyy"));
            }

            prevRevenue = monthRev;
        }

        // Highlight Peak Month in summaries
        for (MonthlyRevenueDTO dto : chronologicalSummaries) {
            if (dto.getRevenue() == peakRevenue && peakRevenue > 0) {
                dto.setPeak(true);
            }
        }

        // Executive MoM Comparison figures
        double currentMonthRevenue = salesByMonth.getOrDefault(currentYm, Collections.emptyList())
                .stream().mapToDouble(s -> s.getSalePrice() != null ? s.getSalePrice() : 0.0).sum();
        long currentMonthDeals = salesByMonth.getOrDefault(currentYm, Collections.emptyList()).size();

        double lastMonthRevenue = salesByMonth.getOrDefault(lastYm, Collections.emptyList())
                .stream().mapToDouble(s -> s.getSalePrice() != null ? s.getSalePrice() : 0.0).sum();
        long lastMonthDeals = salesByMonth.getOrDefault(lastYm, Collections.emptyList()).size();

        Double momGrowthPercentage = 0.0;
        double momDifference = currentMonthRevenue - lastMonthRevenue;
        String momGrowthDirection = "FLAT";

        if (lastMonthRevenue > 0) {
            momGrowthPercentage = ((currentMonthRevenue - lastMonthRevenue) / lastMonthRevenue) * 100.0;
            if (momGrowthPercentage > 0) {
                momGrowthDirection = "UP";
            } else if (momGrowthPercentage < 0) {
                momGrowthDirection = "DOWN";
            }
        } else if (currentMonthRevenue > 0) {
            momGrowthPercentage = 100.0;
            momGrowthDirection = "UP";
        }

        long nonCancelledSalesCount = sales.stream().filter(s -> !"CANCELLED".equalsIgnoreCase(s.getStatus())).count();
        double averageDealSizeOverall = nonCancelledSalesCount > 0 ? (totalRevenue / nonCancelledSalesCount) : 0.0;
        double averageDealSizeCurrentMonth = currentMonthDeals > 0 ? (currentMonthRevenue / currentMonthDeals) : 0.0;
        double averageDealSizeLastMonth = lastMonthDeals > 0 ? (lastMonthRevenue / lastMonthDeals) : 0.0;

        // Chart.js JSON series
        StringBuilder chartLabelsJson = new StringBuilder("[");
        StringBuilder chartRevenueJson = new StringBuilder("[");
        StringBuilder chartDealsJson = new StringBuilder("[");
        for (int i = 0; i < chronologicalSummaries.size(); i++) {
            MonthlyRevenueDTO m = chronologicalSummaries.get(i);
            chartLabelsJson.append("\"").append(m.getMonthLabel()).append("\"");
            chartRevenueJson.append(String.format(Locale.US, "%.2f", m.getRevenue()));
            chartDealsJson.append(m.getDealsCount());
            if (i < chronologicalSummaries.size() - 1) {
                chartLabelsJson.append(",");
                chartRevenueJson.append(",");
                chartDealsJson.append(",");
            }
        }
        chartLabelsJson.append("]");
        chartRevenueJson.append("]");
        chartDealsJson.append("]");

        // Reverse for table display (most recent month on top)
        List<MonthlyRevenueDTO> tableSummaries = new ArrayList<>(chronologicalSummaries);
        Collections.reverse(tableSummaries);

        model.addAttribute("totalProperties", totalProperties);
        model.addAttribute("availableProperties", availableProperties);
        model.addAttribute("reservedProperties", reservedProperties);
        model.addAttribute("soldProperties", soldProperties);
        model.addAttribute("totalCustomers", customers.size());
        model.addAttribute("totalUsers", users.size());
        model.addAttribute("totalRevenue", totalRevenue);
        model.addAttribute("inquiries", inquiries);
        model.addAttribute("pendingInquiriesCount", pendingInquiriesCount);
        model.addAttribute("properties", properties);
        model.addAttribute("sales", sales);
        model.addAttribute("users", users);
        model.addAttribute("recentAuditLogs", recentLogs);
        model.addAttribute("totalAuditLogsCount", allLogs.size());
        model.addAttribute("todayAuditLogsCount", todayAuditLogsCount);

        // MoM & Revenue Analytics Model Attributes
        model.addAttribute("monthlySummaries", tableSummaries);
        model.addAttribute("currentMonthRevenue", currentMonthRevenue);
        model.addAttribute("currentMonthDeals", currentMonthDeals);
        model.addAttribute("currentMonthLabel", currentYm.format(DateTimeFormatter.ofPattern("MMMM yyyy")));
        model.addAttribute("lastMonthRevenue", lastMonthRevenue);
        model.addAttribute("lastMonthDeals", lastMonthDeals);
        model.addAttribute("lastMonthLabel", lastYm.format(DateTimeFormatter.ofPattern("MMMM yyyy")));
        model.addAttribute("momGrowthPercentage", momGrowthPercentage);
        model.addAttribute("momDifference", momDifference);
        model.addAttribute("momGrowthDirection", momGrowthDirection);
        model.addAttribute("averageDealSizeOverall", averageDealSizeOverall);
        model.addAttribute("averageDealSizeCurrentMonth", averageDealSizeCurrentMonth);
        model.addAttribute("averageDealSizeLastMonth", averageDealSizeLastMonth);
        model.addAttribute("peakRevenue", peakRevenue);
        model.addAttribute("peakMonthLabel", peakMonthLabel);
        model.addAttribute("chartLabelsJson", chartLabelsJson.toString());
        model.addAttribute("chartRevenueJson", chartRevenueJson.toString());
        model.addAttribute("chartDealsJson", chartDealsJson.toString());

        // Server & JVM Health Diagnostics
        Runtime runtime = Runtime.getRuntime();
        long maxMemory = runtime.maxMemory() / (1024 * 1024);
        long totalMemory = runtime.totalMemory() / (1024 * 1024);
        long freeMemory = runtime.freeMemory() / (1024 * 1024);
        long usedMemory = totalMemory - freeMemory;
        int memoryPercent = (totalMemory > 0) ? (int) ((usedMemory * 100) / totalMemory) : 0;

        model.addAttribute("jvmUsedMemory", usedMemory);
        model.addAttribute("jvmTotalMemory", totalMemory);
        model.addAttribute("jvmMaxMemory", maxMemory);
        model.addAttribute("jvmMemoryPercent", memoryPercent);
        model.addAttribute("javaVersion", System.getProperty("java.version"));
        model.addAttribute("osName", System.getProperty("os.name") + " (" + System.getProperty("os.arch") + ")");
        model.addAttribute("dbStatus", "OPERATIONAL_CONNECTED");

        return "admin/dashboard";
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }
}

