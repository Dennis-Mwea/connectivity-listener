package com.example.background_listeners.main.view

import android.content.Context
import android.util.AttributeSet
import android.view.View
import android.widget.TextView
import androidx.constraintlayout.widget.ConstraintLayout
import com.example.background_listeners.R


class NoInternetBar: ConstraintLayout {
    private lateinit var layout: View
    lateinit var noInternet: TextView

    constructor(context: Context): super(context) {
        initLayout(context)
    }

    constructor(context: Context, attrs: AttributeSet?): super(context, attrs) {
        initLayout(context)
    }

    constructor(context: Context, attrs: AttributeSet?, defStyleAttr: Int) : super(context, attrs, defStyleAttr){
        initLayout(context)
    }

    private fun initLayout(context: Context) {
        layout = inflate(context, R.layout.no_internet_bar, this)
        noInternet = layout.findViewById(R.id.no_internet_bar)
    }
}