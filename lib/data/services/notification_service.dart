import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:recipe_app/common/function/print_fun.dart';
import 'package:recipe_app/controllers/splash/splash_controller.dart';
import 'package:recipe_app/util/app_export.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService =
  NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // Initialize timezone data
    tz.initializeTimeZones();
    // Set the local location to your device's current timezone
    tz.setLocalLocation(tz.getLocation(await _getLocalTimezone()));

    // Android initialization settings
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher'); // Your app icon or a custom notification icon

    // iOS/macOS initialization settings
    const DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    // General initialization settings
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse: onDidReceiveBackgroundNotificationResponse,
    );

    // Request permissions for Android 13+
    await _requestPermissions();
  }

  Future<String> _getLocalTimezone() async {
    try {
      final String timezoneName = await FlutterTimezone.getLocalTimezone();
      return timezoneName;
    } catch (e) {
      printError("Could not get native timezone: $e"); // Use printError from your utils
      return 'Etc/UTC'; // Fallback to UTC if native timezone cannot be determined
    }
  }

  // Request permissions for Android 13+ and iOS
  Future<void> _requestPermissions() async {
    if (Theme.of(Get.context!).platform == TargetPlatform.android) {
      // For Android 13 (API 33) and above, explicit permission is required
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
      await androidImplementation?.requestNotificationsPermission();
    } else if (Theme.of(Get.context!).platform == TargetPlatform.iOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  // Callback when a notification is tapped from foreground/background
  void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('Notification payload: $payload');
    }
    // You can handle navigation or other actions based on the payload
    // Example: Navigate to a specific screen
    if (payload != null) {
      SplashController controller = Get.put(SplashController());
      controller.startCookingButton();
    }
  }

  // Callback for background notifications (Android only, requires @pragma('vm:entry-point'))
  @pragma('vm:entry-point')
  static void onDidReceiveBackgroundNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('Background Notification payload: $payload');
    }
    // Handle background notification tap here (e.g., logging, simple navigation)
    // Note: Complex UI navigation might not work directly in background context.
  }

  // --- Scheduling Methods ---

  // Show a simple instant notification
  Future<void> showNotification(int id, String title, String body, {String? payload}) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'recipe_app_project', // Must be unique for your app
      ConstUtil.appName,
      channelDescription: 'Channel for daily meal reminders',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const DarwinNotificationDetails darwinPlatformChannelSpecifics =
    DarwinNotificationDetails();
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: darwinPlatformChannelSpecifics,
      macOS: darwinPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  // Schedule a daily recurring notification at a specific time
  Future<void> scheduleDailyNotification(
      int id, String title, String body, DateTime time,
      {String? payload}) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      _nextInstanceOfTime(time), // Calculate the next instance of the desired time
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'recipe_app_project', // Unique channel ID
          'Daily Meal Reminders',
          channelDescription: 'Notifications for daily meal reminders',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time, // This makes it repeat daily at the specified time
      payload: payload,
    );
    // printInfo('Scheduled daily notification for $time');
  }

  // Helper to get the next instance of a specific time in the local timezone
  tz.TZDateTime _nextInstanceOfTime(DateTime time) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
      time.second,
    );

    // If the scheduled time is in the past for today, schedule it for tomorrow
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  // Cancel a specific scheduled notification
  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
    printInfo('Canceled notification with ID: $id');
  }

  // Cancel all scheduled notifications
  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
    printInfo('Canceled all notifications.');
  }
}