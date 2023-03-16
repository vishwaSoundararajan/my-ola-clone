package com.example.myolaapp

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import androidx.core.app.NotificationCompat
import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage
import io.flutter.Log
import kotlin.random.Random
import com.example.fluttersdkplugin.FluttersdkpluginPlugin

class MessagingService : FirebaseMessagingService() {
    lateinit var token: String

    override fun onNewToken(tokken: String) {
        super.onNewToken(tokken)
        token = tokken
        Log.i("token", "Refreshed token :: $tokken")
    }

    override fun onMessageReceived(remoteMessage: RemoteMessage) {
        super.onMessageReceived(remoteMessage)

        var intent: Intent = Intent("com.example.myapp.MY_EVENT");
        intent.putExtra("message", remoteMessage.notification?.title);
        sendBroadcast(intent);
        print("msg received!!!!")
        Log.d("Tag1", "received a notification")
        FluttersdkpluginPlugin().clientMessageReceiver(remoteMessage, this)
//        Log.d("Tag1", "${remoteMessage.notification?.title}")
//        Log.d("Tag1", "${remoteMessage.notification?.body}")
////        Log.d("Tag1", "${remoteMessage.data}")
//        if (ReAndroidSDK.getInstance(this).) {
//
//        }
////deeplink
//
//        // Check if the message contains a notification payload.
//        if (remoteMessage.notification != null) {
//            // Handle the notification here
//
//            Log.i("fcm","received a notification")
//            val notification = remoteMessage.notification
//            val title = notification?.title
//            val body = notification?.body
//
//            // Create and show the notification
//            val notificationManager = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
//            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
//                val channel = NotificationChannel(
//                    "my_channel_id",
//                    "My Channel",
//                    NotificationManager.IMPORTANCE_DEFAULT
//                )
//                notificationManager.createNotificationChannel(channel)
//            }
//
//            val intent = Intent(this, MainActivity::class.java)
//            intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
//            intent.putExtra("notification_data", true)
//            val pendingIntent = PendingIntent.getActivity(
//                this, 0, intent,
//                PendingIntent.FLAG_ONE_SHOT
//            )
//
//            val notificationBuilder = NotificationCompat.Builder(this, "my_channel_id")
//                .setContentTitle(title)
//                .setContentText(body)
//                .setAutoCancel(true)
//                .setContentIntent(pendingIntent)
//
//            notificationManager.notify(0, notificationBuilder.build())
//        }
//    }
//
//
// //deeplink

    }

}

//    fun getRandom(): Int {
//        return Random.nextInt(100)
//    }





//class EventClass: FlutterActivity() {
//    private lateinit var  eChannel:EventChannel
//    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
//        super.configureFlutterEngine(flutterEngine)
//       eChannel =EventChannel(
//            flutterEngine.dartExecutor.binaryMessenger,
//            "example.com/channel")
//    }
//    fun callEventChannel(){
//        eChannel.setStreamHandler(MessageNotifier())
//    }

//}
//class MessageNotifier : EventChannel.StreamHandler {
//
//    override fun onListen(arguments: Any?,events: EventChannel.EventSink) {
//        events.success("Event Channel  :: Received a Notification")
//        print("Started streaming!!!")
//    }
//    override fun onCancel(arguments: Any?) {
//
//    }
//
//}
