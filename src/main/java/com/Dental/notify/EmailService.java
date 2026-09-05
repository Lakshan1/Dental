package com.Dental.notify;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;

// Sends transactional email via Brevo's REST API (https://api.brevo.com/v3/smtp/email).
// Configured entirely through environment variables, so no API key is ever
// committed to source - same pattern as DBConnection's env() lookups.
//
// send() fires the request asynchronously and returns immediately: a slow or
// unreachable email provider must never make staff creation, billing or
// booking feel slow, since the email is a convenience on top of those, not a
// requirement for them to succeed.
public class EmailService {

    private static final String API_KEY = env("BREVO_API_KEY", "");
    private static final String SENDER_EMAIL = env("BREVO_SENDER_EMAIL", "noreply@sunrisedental.com");
    private static final String SENDER_NAME = env("BREVO_SENDER_NAME", "Sunrise Dental Clinic");

    private static final HttpClient CLIENT = HttpClient.newBuilder()
            .connectTimeout(Duration.ofSeconds(10))
            .build();

    public static void send(String toEmail, String toName, String subject, String htmlBody) {
        if (API_KEY.isEmpty()) {
            System.out.println("[EmailService] BREVO_API_KEY not set - skipping email to " + toEmail);
            return;
        }
        if (toEmail == null || toEmail.isBlank()) return;

        String json = "{"
                + "\"sender\":{\"name\":\"" + escape(SENDER_NAME) + "\",\"email\":\"" + escape(SENDER_EMAIL) + "\"},"
                + "\"to\":[{\"email\":\"" + escape(toEmail) + "\",\"name\":\"" + escape(toName) + "\"}],"
                + "\"subject\":\"" + escape(subject) + "\","
                + "\"htmlContent\":\"" + escape(htmlBody) + "\""
                + "}";

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create("https://api.brevo.com/v3/smtp/email"))
                .timeout(Duration.ofSeconds(10))
                .header("accept", "application/json")
                .header("api-key", API_KEY)
                .header("content-type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(json))
                .build();

        CLIENT.sendAsync(request, HttpResponse.BodyHandlers.ofString())
                .whenComplete((response, error) -> {
                    if (error != null) {
                        System.out.println("[EmailService] failed to send to " + toEmail + ": " + error.getMessage());
                    } else if (response.statusCode() < 200 || response.statusCode() >= 300) {
                        System.out.println("[EmailService] Brevo returned " + response.statusCode()
                                + " for " + toEmail + ": " + response.body());
                    }
                });
    }

    private static String env(String key, String fallback) {
        String value = System.getenv(key);
        return (value == null || value.isEmpty()) ? fallback : value;
    }

    // Minimal JSON string escaping - covers quotes, backslashes and newlines,
    // which is everything the HTML bodies built for this app ever contain.
    private static String escape(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "");
    }
}
