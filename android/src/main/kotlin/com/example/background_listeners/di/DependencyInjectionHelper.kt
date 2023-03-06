package com.example.background_listeners.di

import android.content.Context
import com.example.background_listeners.main.data.NetworkStatusRepository
import com.example.background_listeners.main.viewmodel.NetworkStatusViewModel
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob

/**
 * @author Dennis Mwea
 *
 * Dependency injection black box
 */
object DependencyInjectionHelper {
    /**
     * Note: [context] should be the [Context.getApplicationContext]
     * [appScope] should be created in your subclass of [android.app.Application]
     * or via your DI framework and passed in. (There should only be one instance)
     */
    fun injectRepo(
        context: Context,
        mainDispatcher: CoroutineDispatcher = Dispatchers.Main,
        appScope: CoroutineScope = CoroutineScope(SupervisorJob() + Dispatchers.Main)
    ): NetworkStatusRepository {
        return NetworkStatusRepository(
            context,
            mainDispatcher,
            appScope
        )
    }

    fun injectViewModelFactory(repository: NetworkStatusRepository): NetworkStatusViewModel.Factory {
        return NetworkStatusViewModel.Factory(repository)
    }
}