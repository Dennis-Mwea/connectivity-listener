package com.example.background_listeners.main.model

/**
 * @author Dennis Mwea
 *
 * State hierarchy for different Network Status connections
 */
sealed class NetworkStatusState {
    /* Device has a valid internet connection */
    object NetworkStatusConnected : NetworkStatusState()

    /* Device has no internet connection */
    object NetworkStatusDisconnected : NetworkStatusState()

    override fun toString(): String {
        return when (this) {
            NetworkStatusConnected -> "NetworkStatusConnected"
            NetworkStatusDisconnected -> "NetworkStatusDisconnected"
        }
    }

    fun message(): String {
        return when (this) {
            NetworkStatusConnected -> "You are back online."
            NetworkStatusDisconnected -> "You are not connected to the internet."
        }
    }
}
