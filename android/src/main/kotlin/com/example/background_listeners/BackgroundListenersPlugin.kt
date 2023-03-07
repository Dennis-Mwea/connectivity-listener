package com.example.background_listeners

import android.app.Activity
import android.content.Context
import android.net.ConnectivityManager
import android.util.Log
import android.view.Gravity
import android.view.View
import android.view.ViewGroup
import android.view.animation.AnimationUtils
import android.widget.LinearLayout
import android.widget.TextView
import android.widget.Toast
import androidx.activity.ComponentActivity
import androidx.activity.viewModels
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.lifecycle.asLiveData
import com.example.background_listeners.di.DependencyInjectionHelper
import com.example.background_listeners.main.data.NetworkStatusRepository
import com.example.background_listeners.main.model.NetworkStatusState
import com.example.background_listeners.main.view.NoInternetBar
import com.example.background_listeners.main.viewmodel.NetworkStatusViewModel
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** BackgroundListenersPlugin */
class BackgroundListenersPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    private lateinit var activity: ComponentActivity
    private lateinit var noInternetBar: NoInternetBar

    /** ViewModel for consuming network changes */
    private lateinit var viewModel: NetworkStatusViewModel

    /** The main repo handling network callbacks */
    private val repo: NetworkStatusRepository by lazy {
        DependencyInjectionHelper.injectRepo(context)
    }

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "background_listeners")
        channel.setMethodCallHandler(this)
        noInternetBar = NoInternetBar(context)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "hideBanner" -> noInternetBar.noInternet.visibility = View.GONE
            "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        initActivity(binding)
        this.viewModel = initViewModel()
        setupObservers()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        initActivity(binding)
    }

    private fun initActivity(binding: ActivityPluginBinding) {
        activity = binding.activity as ComponentActivity
        val params = ConstraintLayout.LayoutParams(
            LinearLayout.LayoutParams.MATCH_PARENT,
            LinearLayout.LayoutParams.MATCH_PARENT
        )
        params.bottomToBottom = 0
        activity.addContentView(noInternetBar, params)
    }

    override fun onDetachedFromActivityForConfigChanges() {}

    override fun onDetachedFromActivity() {}

    private fun initViewModel(): NetworkStatusViewModel {
        val viewModel: NetworkStatusViewModel by activity.viewModels {
            DependencyInjectionHelper.injectViewModelFactory(repo)
        }

        return viewModel
    }

    private fun setupObservers() {
        /*
         * convert StateFlow to LiveData to save precious PRECIOUS resources
         * when view is no longer visible
         */
        viewModel.networkState.asLiveData().observe(activity) { state ->
            render(state)
        }
    }

    private fun render(state: NetworkStatusState) {
        if (state == NetworkStatusState.NetworkStatusDisconnected) {
            val enterAnim = AnimationUtils.loadAnimation(context, R.anim.enter_from_bottom)
            noInternetBar.noInternet.startAnimation(enterAnim)
        } else {
            val exitAnim = AnimationUtils.loadAnimation(context, R.anim.exit_to_bottom)
            noInternetBar.noInternet.startAnimation(exitAnim)
        }
        noInternetBar.noInternet.visibility =
            if (state == NetworkStatusState.NetworkStatusDisconnected) View.VISIBLE else View.GONE
    }
}
