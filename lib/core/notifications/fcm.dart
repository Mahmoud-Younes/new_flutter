// import 'package:onesignal_flutter/onesignal_flutter.dart';

// class PushNotificationService {
//   static final OneSignal _oneSignal = OneSignal.;

//   // Initialize OneSignal and request permissions
//   static Future<void> init() async {
//     try {
//       // Set your OneSignal App ID
//       await _oneSignal.setAppId('YOUR_ONESIGNAL_APP_ID');

//       // Enable debug logs
//       _oneSignal.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

//       // Request permission for notifications
//       await _oneSignal.promptUserForPushNotificationPermission();

//       // Handle notification opened when app is in foreground
//       _oneSignal.setNotificationWillShowInForegroundHandler(
//           (OSNotificationReceivedEvent event) {
//         print('Received foreground notification: ${event.notification.title}');
//         // Complete the notification event to show it
//         event.complete(event.notification);
//       });

//       // Handle notification opened when app is in background or terminated
//       _oneSignal.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
//         print('Notification opened: ${result.notification.title}');
//         // TODO: Handle notification open (navigate to specific screen)
//       });

//       // Handle subscription changes
//       _oneSignal.getDeviceState().then((deviceState) {
//         print('OneSignal Device ID: ${deviceState?.userId}');
//       });
//     } catch (e) {
//       print('Error initializing OneSignal: $e');
//     }
//   }

//   // Get OneSignal Device ID (equivalent to FCM token)
//   static Future<String?> getDeviceId() async {
//     try {
//       final deviceState = await _oneSignal.getDeviceState();
//       return deviceState?.userId;
//     } catch (e) {
//       print('Error getting device ID: $e');
//       return null;
//     }
//   }
// }