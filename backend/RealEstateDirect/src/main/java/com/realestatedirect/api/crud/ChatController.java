package com.realestatedirect.api.crud;

import okhttp3.Call;
import okhttp3.Callback;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;
import okhttp3.ResponseBody;
import okhttp3.MediaType;

import okio.BufferedSource;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.ResponseBodyEmitter;

import java.io.IOException;
import java.util.concurrent.TimeUnit;

@RestController
@RequestMapping("/chat")
public class ChatController {

    @Value("${openai.api.key}")
    private String openaiApiKey;

    private final OkHttpClient client = new OkHttpClient.Builder()
            .readTimeout(0, TimeUnit.SECONDS)
            .build();

    private static final String OPENAI_API_URL = "https://api.openai.com/v1/chat/completions";

    @PostMapping(value = "/stream", produces = org.springframework.http.MediaType.TEXT_EVENT_STREAM_VALUE)
    public ResponseBodyEmitter streamChat(@org.springframework.web.bind.annotation.RequestBody ChatRequest chatRequest) {
        ResponseBodyEmitter emitter = new ResponseBodyEmitter();

        MediaType jsonMediaType = MediaType.parse("application/json");

//gpt-4
//gpt-3.5-turbo
//              "tools": [ { "type": "web_search_preview" } ],
        RequestBody requestBody = RequestBody.create(
            """
            {
              "model": "gpt-4.1",
              "messages": [
                {"role": "system", "content": "You are a helpful and knowledgeable assistant who only answers questions about real estate. If the question is not related to real estate, politely respond that you are only able to discuss real estate topics."},
                {"role": "user", "content": "%s"}
              ],
              "stream": true
            }
            """.formatted(chatRequest.getMessage()),
            jsonMediaType
        );

        Request request = new Request.Builder()
                .url(OPENAI_API_URL)
                .header("Authorization", "Bearer " + openaiApiKey)
                .post(requestBody)
                .build();

        client.newCall(request).enqueue(new Callback() {
            @Override
            public void onFailure(Call call, IOException e) {
                try {
                    emitter.send("Error: " + e.getMessage());
                } catch (IOException ignored) {}
                emitter.complete();
            }

            @Override
            public void onResponse(Call call, Response response) {
                try (ResponseBody body = response.body()) {
                    if (body == null) {
                        emitter.send("Error: No response body.");
                        emitter.complete();
                        return;
                    }

                    BufferedSource source = body.source();
                    while (!source.exhausted()) {
                        String line = source.readUtf8LineStrict();
                        if (line.startsWith("data: ")) {
                            String json = line.substring(6).trim();
                            if (json.equals("[DONE]")) break;

                            String delta = extractDelta(json);
                            if (!delta.isEmpty()) {
                                emitter.send(delta);
                            }
                        }
                    }
                } catch (Exception e) {
                    try {
                        emitter.send("Error: " + e.getMessage());
                    } catch (IOException ignored) {}
                } finally {
                    emitter.complete();
                }
            }
        });

        return emitter;
    }

    private String extractDelta(String json) {
        try {
            int start = json.indexOf("\"content\":\"");
            if (start == -1) return "";
            start += 11;
            int end = json.indexOf("\"", start);
            return json.substring(start, end);
        } catch (Exception e) {
            return "";
        }
    }

    public static class ChatRequest {
        private String message;
        public String getMessage() { return message; }
        public void setMessage(String message) { this.message = message; }
    }
}
