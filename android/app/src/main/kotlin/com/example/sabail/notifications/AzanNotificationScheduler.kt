package com.example.sabail.notifications

import android.app.AlarmManager
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.ContentResolver
import android.content.Context
import android.content.Intent
import android.media.AudioAttributes
import android.net.Uri
import android.os.Build
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import com.example.sabail.MainActivity
import com.example.sabail.R
import org.json.JSONArray

object AzanNotificationScheduler {
    private const val preferencesName = "azan_scheduler_preferences"
    private const val scheduledNotificationsKey = "scheduled_notifications"

    private const val channelId = "azan_native_channel_v1"
    private const val channelName = "Azan Notifications"
    private const val channelDescription = "Prayer reminders with azan audio"
    private const val soundName = "krasivyj_azan"

    private const val extraId = "notification_id"
    private const val extraTitle = "notification_title"
    private const val extraBody = "notification_body"

    fun initialize(context: Context) {
        createChannel(context)
    }

    fun areNotificationsEnabled(context: Context): Boolean =
        NotificationManagerCompat.from(context).areNotificationsEnabled()

    fun canScheduleExactAlarms(context: Context): Boolean {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.S) {
            return true
        }

        val alarmManager = context.getSystemService(AlarmManager::class.java)
        return alarmManager.canScheduleExactAlarms()
    }

    fun replaceSchedule(context: Context, notifications: List<ScheduledAzanNotification>) {
        initialize(context)
        cancelAll(context)

        val futureNotifications =
            notifications
                .filter { it.triggerAtMillis > System.currentTimeMillis() }
                .sortedBy { it.triggerAtMillis }

        futureNotifications.forEach { schedule(context, it) }
        saveScheduledNotifications(context, futureNotifications)
    }

    fun cancelAll(context: Context) {
        val alarmManager = context.getSystemService(AlarmManager::class.java)
        val notificationManager = NotificationManagerCompat.from(context)
        val scheduledNotifications = loadScheduledNotifications(context)

        scheduledNotifications.forEach { notification ->
            alarmManager.cancel(buildPendingIntent(context, notification))
            notificationManager.cancel(notification.id)
        }

        saveScheduledNotifications(context, emptyList())
    }

    fun rescheduleSaved(context: Context) {
        initialize(context)
        if (!canScheduleExactAlarms(context)) {
            return
        }

        val futureNotifications =
            loadScheduledNotifications(context)
                .filter { it.triggerAtMillis > System.currentTimeMillis() }
                .sortedBy { it.triggerAtMillis }

        futureNotifications.forEach { schedule(context, it) }
        saveScheduledNotifications(context, futureNotifications)
    }

    fun showNotification(context: Context, notification: ScheduledAzanNotification) {
        initialize(context)

        val notificationManager = NotificationManagerCompat.from(context)
        val launchIntent =
            Intent(context, MainActivity::class.java).apply {
                flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
            }
        val contentIntent =
            PendingIntent.getActivity(
                context,
                notification.id,
                launchIntent,
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
            )

        val builder =
            NotificationCompat.Builder(context, channelId)
                .setSmallIcon(R.mipmap.ic_launcher)
                .setContentTitle(notification.title)
                .setContentText(notification.body)
                .setStyle(NotificationCompat.BigTextStyle().bigText(notification.body))
                .setPriority(NotificationCompat.PRIORITY_MAX)
                .setCategory(NotificationCompat.CATEGORY_ALARM)
                .setVisibility(NotificationCompat.VISIBILITY_PUBLIC)
                .setAutoCancel(true)
                .setContentIntent(contentIntent)

        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) {
            builder.setSound(soundUri(context))
        }

        notificationManager.notify(notification.id, builder.build())
        removeScheduledNotification(context, notification.id)
    }

    private fun schedule(context: Context, notification: ScheduledAzanNotification) {
        val alarmManager = context.getSystemService(AlarmManager::class.java)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S && !alarmManager.canScheduleExactAlarms()) {
            throw IllegalStateException("Exact alarm permission is not granted.")
        }

        alarmManager.setExactAndAllowWhileIdle(
            AlarmManager.RTC_WAKEUP,
            notification.triggerAtMillis,
            buildPendingIntent(context, notification),
        )
    }

    private fun buildPendingIntent(
        context: Context,
        notification: ScheduledAzanNotification,
    ): PendingIntent {
        val intent =
            Intent(context, AzanNotificationReceiver::class.java).apply {
                putExtra(extraId, notification.id)
                putExtra(extraTitle, notification.title)
                putExtra(extraBody, notification.body)
            }

        return PendingIntent.getBroadcast(
            context,
            notification.id,
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
        )
    }

    private fun createChannel(context: Context) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) {
            return
        }

        val notificationManager = context.getSystemService(NotificationManager::class.java)
        val channel =
            NotificationChannel(channelId, channelName, NotificationManager.IMPORTANCE_HIGH).apply {
                description = channelDescription
                lockscreenVisibility = Notification.VISIBILITY_PUBLIC
                enableVibration(true)
                setSound(
                    soundUri(context),
                    AudioAttributes.Builder()
                        .setUsage(AudioAttributes.USAGE_ALARM)
                        .setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
                        .build(),
                )
            }

        notificationManager.createNotificationChannel(channel)
    }

    private fun soundUri(context: Context): Uri =
        Uri.parse("${ContentResolver.SCHEME_ANDROID_RESOURCE}://${context.packageName}/raw/$soundName")

    private fun saveScheduledNotifications(
        context: Context,
        notifications: List<ScheduledAzanNotification>,
    ) {
        val jsonArray = JSONArray()
        notifications.forEach { notification -> jsonArray.put(notification.toJson()) }

        context
            .getSharedPreferences(preferencesName, Context.MODE_PRIVATE)
            .edit()
            .putString(scheduledNotificationsKey, jsonArray.toString())
            .apply()
    }

    private fun loadScheduledNotifications(context: Context): List<ScheduledAzanNotification> {
        val rawValue =
            context
                .getSharedPreferences(preferencesName, Context.MODE_PRIVATE)
                .getString(scheduledNotificationsKey, null)
                ?: return emptyList()

        val jsonArray = JSONArray(rawValue)
        return buildList {
            for (index in 0 until jsonArray.length()) {
                add(ScheduledAzanNotification.fromJson(jsonArray.getJSONObject(index)))
            }
        }
    }

    private fun removeScheduledNotification(context: Context, notificationId: Int) {
        val remainingNotifications =
            loadScheduledNotifications(context).filterNot { it.id == notificationId }
        saveScheduledNotifications(context, remainingNotifications)
    }
}
