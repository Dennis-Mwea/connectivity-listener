package com.example.background_listeners_example

import io.flutter.embedding.android.FlutterFragmentActivity

/**
 * @author Dennis Mwea
 *
 * UI Controller that displays a centered message and an offline bar if
 * the user loses network connectivity
 *
 * Business logic + UI state handling is delegated to [NetworkStatusViewModel]
 * and is consumed in [setupObservers] then displayed in [render]
 */
class MainActivity: FlutterFragmentActivity() {
}
