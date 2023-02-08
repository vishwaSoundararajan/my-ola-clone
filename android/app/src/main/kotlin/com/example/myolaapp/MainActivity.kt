package com.example.myolaapp

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Bundle
import com.example.fluttersdkplugin.MessageNotifier
import io.flutter.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel

class MainActivity: FlutterActivity(){
    private lateinit var  eChannel:EventChannel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // ...

        eChannel.setStreamHandler(MessageNotifier(""))
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val filter = IntentFilter("com.example.myapp.MY_EVENT")
        registerReceiver(receiver, filter)

        eChannel=EventChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "example.com/channell")
    }
    private val receiver: BroadcastReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent) {
            val message: String? = intent.getStringExtra("message")
            val token:String?=intent.getStringExtra("dtoken")
            if (message != null) {
                callEventChannel(message)
            }

        }
    }
    fun callEventChannel(data:String){
        eChannel.setStreamHandler(MessageNotifier(data))
    }

}
class MessageNotifier(var msg:String)  : EventChannel.StreamHandler {

    override fun onListen(arguments: Any?,events: EventChannel.EventSink) {
        events.success(msg)
        msg="";
    }
    override fun onCancel(arguments: Any?) {

    }

}