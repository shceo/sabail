package com.example.sabail.notifications

import org.json.JSONObject

data class ScheduledAzanNotification(
    val id: Int,
    val triggerAtMillis: Long,
    val title: String,
    val body: String,
) {
    fun toJson(): JSONObject =
        JSONObject()
            .put("id", id)
            .put("triggerAtMillis", triggerAtMillis)
            .put("title", title)
            .put("body", body)

    companion object {
        fun fromJson(json: JSONObject): ScheduledAzanNotification =
            ScheduledAzanNotification(
                id = json.getInt("id"),
                triggerAtMillis = json.getLong("triggerAtMillis"),
                title = json.optString("title"),
                body = json.optString("body"),
            )
    }
}
