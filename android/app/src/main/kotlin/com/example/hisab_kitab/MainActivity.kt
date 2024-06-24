package com.example.hisab_kitab

import io.flutter.embedding.android.FlutterActivity
import android.content.Intent
import android.net.Uri
import android.os.Bundle
 import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.app/upi"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "launchUpi") {
                val url: String? = call.argument("url")
                if (url != null) {
                    launchUpi(url)
                    result.success(null)
                } else {
                    result.error("UNAVAILABLE", "URL not provided.", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun launchUpi(url: String) {
        val intent = Intent(Intent.ACTION_VIEW)
        intent.data = Uri.parse(url)
        startActivity(intent)
    }
}

