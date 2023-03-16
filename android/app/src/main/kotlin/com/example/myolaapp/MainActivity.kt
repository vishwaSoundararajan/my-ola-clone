package com.example.myolaapp
import android.content.BroadcastReceiver
import android.content.ContentValues.TAG
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Bundle
import com.example.fluttersdkplugin.FluttersdkpluginPlugin
import io.flutter.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import kotlin.math.log
import android.net.Uri
import io.flutter.plugin.common.MethodChannel
//import com.example.fluttersdkplugin.MessageNotifier
//import sun.jvm.hotspot.debugger.win32.coff.DebugVC50X86RegisterEnums.TAG


class MainActivity: FlutterActivity(){
    private lateinit var  eChannel:EventChannel
    private lateinit var _fluttersdkplugin:FluttersdkpluginPlugin


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        _fluttersdkplugin=FluttersdkpluginPlugin()
        io.flutter.Log.d("oncreate", "on create!!")
        //android.util.Log.i(TAG, "on create called!!")
        _fluttersdkplugin.initResdk(this)
        eChannel.setStreamHandler(MessageNotifier(""))
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine){
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
                Log.d("Tag1","received a notification2")
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