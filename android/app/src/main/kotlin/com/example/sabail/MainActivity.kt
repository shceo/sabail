package com.example.sabail

import android.Manifest
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.provider.Settings
import com.example.sabail.notifications.AzanNotificationScheduler
import com.example.sabail.notifications.ScheduledAzanNotification
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private companion object {
        const val CHANNEL = "com.example.sabail/native_notifications"
        const val PERMISSION_IN_PROGRESS_ERROR = "permission_in_progress"
        const val SCHEDULE_FAILED_ERROR = "schedule_failed"
        const val NOTIFICATION_PERMISSION_REQUEST_CODE = 7001
        const val EXACT_ALARM_PERMISSION_REQUEST_CODE = 7002
    }

    private var pendingPermissionsResult: MethodChannel.Result? = null
    private var notificationPermissionRequested = false
    private var exactAlarmPermissionRequested = false

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "initialize" -> {
                        AzanNotificationScheduler.initialize(this)
                        result.success(null)
                    }

                    "ensurePermissions" -> handleEnsurePermissions(call, result)

                    "replacePrayerSchedule" -> handleReplacePrayerSchedule(call, result)

                    "cancelAll" -> {
                        AzanNotificationScheduler.cancelAll(this)
                        result.success(null)
                    }

                    else -> result.notImplemented()
                }
            }
    }

    private fun handleEnsurePermissions(call: MethodCall, result: MethodChannel.Result) {
        val requestIfNeeded = call.argument<Boolean>("requestIfNeeded") ?: true
        if (!requestIfNeeded) {
            result.success(
                AzanNotificationScheduler.areNotificationsEnabled(this) &&
                    AzanNotificationScheduler.canScheduleExactAlarms(this),
            )
            return
        }

        if (pendingPermissionsResult != null) {
            result.error(
                PERMISSION_IN_PROGRESS_ERROR,
                "A notification permission request is already in progress.",
                null,
            )
            return
        }

        val alreadyGranted =
            AzanNotificationScheduler.areNotificationsEnabled(this) &&
                AzanNotificationScheduler.canScheduleExactAlarms(this)
        if (alreadyGranted) {
            result.success(true)
            return
        }

        pendingPermissionsResult = result
        continueEnsurePermissions()
    }

    private fun continueEnsurePermissions() {
        val result = pendingPermissionsResult ?: return

        val notificationsEnabled = AzanNotificationScheduler.areNotificationsEnabled(this)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU && !notificationsEnabled) {
            if (!notificationPermissionRequested) {
                notificationPermissionRequested = true
                requestPermissions(
                    arrayOf(Manifest.permission.POST_NOTIFICATIONS),
                    NOTIFICATION_PERMISSION_REQUEST_CODE,
                )
                return
            }

            finishEnsurePermissions(false)
            return
        }

        val exactAlarmsEnabled = AzanNotificationScheduler.canScheduleExactAlarms(this)
        if (!exactAlarmsEnabled) {
            if (!exactAlarmPermissionRequested) {
                exactAlarmPermissionRequested = true
                startActivityForResult(
                    Intent(
                        Settings.ACTION_REQUEST_SCHEDULE_EXACT_ALARM,
                        Uri.parse("package:$packageName"),
                    ),
                    EXACT_ALARM_PERMISSION_REQUEST_CODE,
                )
                return
            }

            finishEnsurePermissions(false)
            return
        }

        finishEnsurePermissions(true)
    }

    private fun finishEnsurePermissions(granted: Boolean) {
        val result = pendingPermissionsResult ?: return
        pendingPermissionsResult = null
        notificationPermissionRequested = false
        exactAlarmPermissionRequested = false
        result.success(granted)
    }

    private fun handleReplacePrayerSchedule(call: MethodCall, result: MethodChannel.Result) {
        try {
            val rawNotifications = call.argument<List<*>>("notifications").orEmpty()
            val notifications =
                rawNotifications.mapNotNull { rawItem ->
                    val item = rawItem as? Map<*, *> ?: return@mapNotNull null
                    val id = (item["id"] as? Number)?.toInt() ?: return@mapNotNull null
                    val triggerAtMillis =
                        (item["triggerAtMillis"] as? Number)?.toLong() ?: return@mapNotNull null
                    val title = item["title"] as? String ?: "Prayer time"
                    val body = item["body"] as? String ?: ""

                    ScheduledAzanNotification(
                        id = id,
                        triggerAtMillis = triggerAtMillis,
                        title = title,
                        body = body,
                    )
                }

            AzanNotificationScheduler.replaceSchedule(this, notifications)
            result.success(null)
        } catch (error: Exception) {
            result.error(
                SCHEDULE_FAILED_ERROR,
                error.message ?: "Failed to replace prayer schedule.",
                null,
            )
        }
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray,
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)

        if (requestCode == NOTIFICATION_PERMISSION_REQUEST_CODE) {
            continueEnsurePermissions()
        }
    }

    @Deprecated("Deprecated in Java")
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (requestCode == EXACT_ALARM_PERMISSION_REQUEST_CODE) {
            continueEnsurePermissions()
        }
    }
}
