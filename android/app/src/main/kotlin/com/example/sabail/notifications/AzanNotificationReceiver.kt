package com.example.sabail.notifications

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent

class AzanNotificationReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        val id = intent.getIntExtra("notification_id", 0)
        val title = intent.getStringExtra("notification_title") ?: "Prayer time"
        val body = intent.getStringExtra("notification_body") ?: ""

        AzanNotificationScheduler.showNotification(
            context,
            ScheduledAzanNotification(
                id = id,
                triggerAtMillis = System.currentTimeMillis(),
                title = title,
                body = body,
            ),
        )
    }
}
