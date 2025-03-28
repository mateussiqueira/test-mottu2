package com.mateussiqueira.pokeapi

import android.content.Context
import android.net.ConnectivityManager
import android.net.Network
import android.net.NetworkCapabilities
import android.net.NetworkRequest
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CONNECTIVITY_CHANNEL = "com.mateussiqueira.pokeapi/connectivity"
    private var connectivityEventSink: EventChannel.EventSink? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, CONNECTIVITY_CHANNEL)
            .setStreamHandler(object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    connectivityEventSink = events
                    setupConnectivityListener()
                }

                override fun onCancel(arguments: Any?) {
                    connectivityEventSink = null
                }
            })
    }

    private fun setupConnectivityListener() {
        val connectivityManager = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            connectivityManager.registerDefaultNetworkCallback(object : ConnectivityManager.NetworkCallback() {
                override fun onAvailable(network: Network) {
                    super.onAvailable(network)
                    activity?.runOnUiThread {
                        connectivityEventSink?.success(true)
                    }
                }

                override fun onLost(network: Network) {
                    super.onLost(network)
                    activity?.runOnUiThread {
                        connectivityEventSink?.success(false)
                    }
                }
            })
        } else {
            val builder = NetworkRequest.Builder()
            val networkRequest = builder.build()

            connectivityManager.registerNetworkCallback(networkRequest, object : ConnectivityManager.NetworkCallback() {
                override fun onAvailable(network: Network) {
                    super.onAvailable(network)
                    activity?.runOnUiThread {
                        connectivityEventSink?.success(true)
                    }
                }

                override fun onLost(network: Network) {
                    super.onLost(network)
                    activity?.runOnUiThread {
                        connectivityEventSink?.success(false)
                    }
                }
            })
        }
    }
}
