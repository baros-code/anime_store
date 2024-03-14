package com.example.anime_store

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.runBlocking
import java.io.IOException
import java.net.HttpURLConnection
import java.net.URL

class MainActivity : FlutterActivity() {
    private val channel = "com.example/anime_store"
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            channel
        ).setMethodCallHandler { call, result ->
            val url = call.argument<String>("url")
            runBlocking(Dispatchers.IO) {
                val response = when (call.method) {
                    "fetchAnimeList" -> fetchAnimeList(url)
                    "fetchAnimeCharacters" -> fetchAnimeCharacters(url)
                    else -> null
                }
                response?.let {
                    result.success(it)
                } ?: run {
                    result.error(
                        "1",
                        "Response returned null.",
                        "Either the method is not defined or the response is null.",
                    )
                }
            }
        }
    }

    private fun fetchAnimeList(
        url: String?,
    ): String? {
        val url = URL(url)
        return try {
            val connection = url.openConnection() as HttpURLConnection
            connection.requestMethod = "GET"
            connection.connect()
            if (connection.responseCode == HttpURLConnection.HTTP_OK) {
                connection.inputStream.bufferedReader().use { it.readText() }
            } else {
                null
            }
        } catch (e: IOException) {
            e.printStackTrace()
            null
        }
    }

    private fun fetchAnimeCharacters(url: String?): String? {
        val url = URL(url)
        return try {
            val connection = url.openConnection() as HttpURLConnection
            connection.requestMethod = "GET"
            connection.connect()
            if (connection.responseCode == HttpURLConnection.HTTP_OK) {
                connection.inputStream.bufferedReader().use { it.readText() }
            } else {
                null
            }
        } catch (e: IOException) {
            e.printStackTrace()
            null
        }
    }

}
