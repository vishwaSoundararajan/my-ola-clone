package com.example.myolaapp

import android.content.Context
import android.content.Intent
import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage
import io.flutter.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor.DartEntrypoint
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import io.mob.resu.reandroidsdk.ReAndroidSDK
import kotlin.random.Random


class MessagingService : FirebaseMessagingService(){
lateinit var token:String

    override fun onNewToken(tokken: String) {
        super.onNewToken(tokken)
        token=tokken
        Log.i("token", "Refreshed token :: $tokken")
    }
    override fun onMessageReceived(remoteMessage: RemoteMessage) {
        super.onMessageReceived(remoteMessage)

        var intent: Intent = Intent("com.example.myapp.MY_EVENT");
        intent.putExtra("message",remoteMessage.notification?.title);
        sendBroadcast(intent);
//        Log.d("Tag1", "${remoteMessage.notification?.title}")
//        Log.d("Tag1", "${remoteMessage.notification?.body}")
////        Log.d("Tag1", "${remoteMessage.data}")
//        if (ReAndroidSDK.getInstance(this).) {
//
//        }
    }

    fun getRandom(): Int {
        return Random.nextInt(100)
    }

}

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
