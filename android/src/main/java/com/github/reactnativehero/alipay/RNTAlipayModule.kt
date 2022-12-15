package com.github.reactnativehero.alipay

import com.alipay.sdk.app.PayTask
import com.facebook.react.bridge.*

class RNTAlipayModule(private val reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {

    override fun getName(): String {
        return "RNTAlipay"
    }

    @ReactMethod
    fun pay(options: ReadableMap, promise: Promise) {

        Thread {

            val map = Arguments.createMap()

            val alipay = PayTask(currentActivity)
            val result = alipay.payV2(options.getString("order_info"), true)

            val resultStatus = result["resultStatus"] ?: ""
            if (resultStatus == "9000") {
                map.putInt("code", 0)
                map.putString("msg", "success")
                map.putString("data", result["result"] ?: "")
            } else {
                map.putInt("code", 1)
                map.putString("msg", result["memo"] ?: "")
            }
            promise.resolve(map)

        }.start()

    }

}
