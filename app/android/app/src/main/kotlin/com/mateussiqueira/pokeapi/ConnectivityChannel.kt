package com.mateussiqueira.pokeapi

import android.content.Context
import android.net.ConnectivityManager
import android.net.Network
import android.net.NetworkCapabilities
import android.net.NetworkRequest
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.PluginRegistry

class ConnectivityChannel: FlutterPlugin, EventChannel.StreamHandler, PluginRegistry.ActivityResultListener {
    private var eventSink: EventChannel.EventSink? = null
    private var connectivityManager: ConnectivityManager? = null
    private var networkCallback: ConnectivityManager.NetworkCallback? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        val channel = EventChannel(binding.binaryMessenger, "connectivity_status")
        channel.setStreamHandler(this)
        
        connectivityManager = binding.applicationContext.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        networkCallback?.let { connectivityManager?.unregisterNetworkCallback(it) }
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
        setupNetworkCallback()
    }

    override fun onCancel(arguments: Any?) {
        networkCallback?.let { connectivityManager?.unregisterNetworkCallback(it) }
        eventSink = null
    }

    private fun setupNetworkCallback() {
        val networkRequest = NetworkRequest.Builder()
            .addCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET)
            .build()

        networkCallback = object : ConnectivityManager.NetworkCallback() {
            override fun onAvailable(network: Network) {
                eventSink?.success("connected")
            }

            override fun onLost(network: Network) {
                eventSink?.success("disconnected")
            }
        }

        networkCallback?.let { connectivityManager?.registerNetworkCallback(networkRequest, it) }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        return false
    }
} 