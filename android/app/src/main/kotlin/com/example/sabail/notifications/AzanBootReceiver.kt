package com.example.sabail.notifications

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent

class AzanBootReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        AzanNotificationScheduler.rescheduleSaved(context)
    }
}
