package com.landsales.notification.service;

import jakarta.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    @Autowired(required = false)
    private JavaMailSender mailSender;

    @Value("${app.mail.sender-name:Ceylon Lands (Pvt) Ltd}")
    private String senderName;

    @Value("${app.mail.sender-email:lahirupreboth2004@gmail.com}")
    private String senderEmail;

    @Value("${spring.mail.password:}")
    private String mailPassword;

    /**
     * Sends an asynchronous, beautifully styled HTML notification email.
     */
    @Async
    public void sendNotificationEmail(String toEmail, String recipientName, String subject,
                                      String headline, String messageBody, String buttonText, String buttonUrl) {
        if (toEmail == null || toEmail.trim().isEmpty() || toEmail.equalsIgnoreCase("null")) {
            return;
        }

        final String cleanToEmail = toEmail.trim();
        final String displayName = (recipientName != null && !recipientName.trim().isEmpty()) ? recipientName.trim() : "Valued Customer";

        System.out.println("================================================================================");
        System.out.println("📧 [AUTOMATED EMAIL DISPATCH]");
        System.out.println("From    : " + senderName + " <" + senderEmail + ">");
        System.out.println("To      : " + displayName + " <" + cleanToEmail + ">");
        System.out.println("Subject : " + subject);
        System.out.println("Headline: " + headline);
        System.out.println("Message : " + messageBody);
        if (buttonUrl != null) System.out.println("Link    : " + buttonUrl);
        System.out.println("================================================================================");

        // If JavaMailSender is configured and a non-dummy password is provided, attempt live SMTP delivery
        if (mailSender != null && mailPassword != null && !mailPassword.trim().isEmpty() && !mailPassword.contains("your-app-password") && !mailPassword.contains("change-me")) {
            try {
                MimeMessage message = mailSender.createMimeMessage();
                MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
                helper.setFrom(senderEmail, senderName);
                helper.setTo(cleanToEmail);
                helper.setSubject(subject);
                helper.setText(buildHtmlTemplate(displayName, subject, headline, messageBody, buttonText, buttonUrl), true);
                mailSender.send(message);
                System.out.println("✅ [EMAIL SENT SUCCESSFULLY] to " + cleanToEmail);
            } catch (Exception e) {
                System.err.println("⚠️ [EMAIL SMTP NOTICE] Could not deliver via SMTP: " + e.getMessage() + " (In-App notification recorded successfully).");
            }
        }
    }

    private String buildHtmlTemplate(String recipientName, String subject, String headline,
                                     String messageBody, String buttonText, String buttonUrl) {
        String actionBtnHtml = "";
        if (buttonText != null && buttonUrl != null && !buttonUrl.trim().isEmpty()) {
            actionBtnHtml = "<div style='text-align: center; margin: 30px 0;'>"
                    + "<a href='" + buttonUrl + "' style='background: #0b5e28; color: #ffffff; padding: 13px 30px; text-decoration: none; border-radius: 8px; font-weight: 700; font-size: 15px; display: inline-block; box-shadow: 0 4px 12px rgba(11, 94, 40, 0.3); border: 1px solid #d4af37;'>"
                    + buttonText + "</a></div>";
        }

        return "<!DOCTYPE html>"
                + "<html>"
                + "<head><meta charset='UTF-8'><meta name='viewport' content='width=device-width, initial-scale=1.0'></head>"
                + "<body style='font-family: -apple-system, BlinkMacSystemFont, \"Segoe UI\", Roboto, Helvetica, Arial, sans-serif; background-color: #f8fafc; margin: 0; padding: 25px; color: #1e293b;'>"
                + "<div style='max-width: 600px; margin: 0 auto; background: #ffffff; border-radius: 16px; overflow: hidden; box-shadow: 0 10px 25px -5px rgba(0,0,0,0.08); border: 1px solid #e2e8f0;'>"
                + "  <div style='background: linear-gradient(135deg, #07120a 0%, #0b5e28 100%); padding: 32px 25px; text-align: center; color: #ffffff; border-bottom: 3px solid #d4af37;'>"
                + "    <div style='font-size: 28px; font-weight: 800; letter-spacing: 0.5px;'>Ceylon <span style='color: #d4af37;'>Lands</span></div>"
                + "    <div style='font-size: 12px; color: #cbd5e1; margin-top: 6px; letter-spacing: 1.5px; text-transform: uppercase;'>Prime Real Estate &amp; Land Development</div>"
                + "  </div>"
                + "  <div style='padding: 30px;'>"
                + "    <h2 style='color: #0f172a; margin-top: 0; font-size: 20px; font-weight: 700;'>" + headline + "</h2>"
                + "    <p style='color: #475569; font-size: 15px; line-height: 1.6;'>Hello <strong>" + recipientName + "</strong>,</p>"
                + "    <div style='background: #f0fdf4; border-left: 4px solid #0b5e28; padding: 18px 20px; border-radius: 6px; margin: 20px 0; border: 1px solid #dcfce7;'>"
                + "      <p style='margin: 0; color: #166534; font-size: 14.5px; line-height: 1.6;'>" + messageBody.replace("\n", "<br>") + "</p>"
                + "    </div>"
                + actionBtnHtml
                + "    <p style='color: #64748b; font-size: 13px; line-height: 1.5; margin-top: 25px; border-top: 1px solid #f1f5f9; padding-top: 20px;'>"
                + "      If you have any questions, you can reply directly or contact our 24/7 client relations hotline at <strong>+94 11 234 5678</strong>."
                + "    </p>"
                + "  </div>"
                + "  <div style='background: #f8fafc; padding: 20px 30px; text-align: center; font-size: 12px; color: #64748b; border-top: 1px solid #e2e8f0;'>"
                + "    <strong>Ceylon Lands (Pvt) Ltd</strong> &bull; No. 45, Prime Tower, Galle Road, Colombo 03, Sri Lanka<br>"
                + "    &copy; " + java.time.Year.now().getValue() + " Ceylon Lands. All rights reserved."
                + "  </div>"
                + "</div>"
                + "</body></html>";
    }
}

