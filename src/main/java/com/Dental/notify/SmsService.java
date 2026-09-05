package com.Dental.notify;

import java.net.URI;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.time.Duration;

// Sends SMS via notify.lk (https://app.notify.lk/api/v1/send), a Sri Lankan
// SMS gateway. Same fail-safe, fire-and-forget policy as EmailService: if the
// NOTIFYLK_* environment variables aren't set, or the number can't be
// normalized, send() logs and returns without throwing, since SMS here is a
// convenience notification on top of booking/billing, not a requirement for
// them to succeed.
public class SmsService {

    private static final String USER_ID = env("NOTIFYLK_USER_ID", "");
    private static final String API_KEY = env("NOTIFYLK_API_KEY", "");
    private static final String SENDER_ID = env("NOTIFYLK_SENDER_ID", "NotifyDEMO");

    private static final HttpClient CLIENT = HttpClient.newBuilder()
            .connectTimeout(Duration.ofSeconds(10))
            .build();

    public static void send(String toPhone, String message) {
        if (USER_ID.isEmpty() || API_KEY.isEmpty()) {
            System.out.println("[SmsService] NOTIFYLK credentials not set - skipping SMS to " + toPhone);
            return;
        }
        String normalized = normalize(toPhone);
        if (normalized == null) {
            System.out.println("[SmsService] could not normalize phone number: " + toPhone);
            return;
        }

        String url = "https://app.notify.lk/api/v1/send"
                + "?user_id=" + enc(USER_ID)
                + "&api_key=" + enc(API_KEY)
                + "&sender_id=" + enc(SENDER_ID)
                + "&to=" + enc(normalized)
                + "&message=" + enc(message);

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .timeout(Duration.ofSeconds(10))
                .GET()
                .build();

        CLIENT.sendAsync(request, HttpResponse.BodyHandlers.ofString())
                .whenComplete((response, error) -> {
                    if (error != null) {
                        System.out.println("[SmsService] failed to send to " + toPhone + ": " + error.getMessage());
                    } else if (response.statusCode() < 200 || response.statusCode() >= 300) {
                        System.out.println("[SmsService] notify.lk returned " + response.statusCode()
                                + " for " + toPhone + ": " + response.body());
                    }
                });
    }

    // notify.lk expects Sri Lankan numbers as 94XXXXXXXXX (country code, no
    // leading 0 or +). Accepts local "07XXXXXXXX", international "+947XXXXXXXX"
    // or an already-normalized "947XXXXXXXX". Returns null if the digit count
    // doesn't match any of those shapes, rather than guessing.
    static String normalize(String phone) {
        if (phone == null) return null;
        String digits = phone.replaceAll("[^0-9]", "");
        if (digits.startsWith("94") && digits.length() == 11) return digits;
        if (digits.startsWith("0") && digits.length() == 10) return "94" + digits.substring(1);
        if (digits.length() == 9) return "94" + digits;
        return null;
    }

    private static String env(String key, String fallback) {
        String value = System.getenv(key);
        return (value == null || value.isEmpty()) ? fallback : value;
    }

    private static String enc(String s) {
        return URLEncoder.encode(s == null ? "" : s, StandardCharsets.UTF_8);
    }
}
