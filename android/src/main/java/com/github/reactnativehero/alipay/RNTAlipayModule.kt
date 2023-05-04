package com.github.reactnativehero.alipay

import com.alipay.sdk.app.AuthTask
import com.alipay.sdk.app.PayTask
import com.facebook.react.bridge.*

class RNTAlipayModule(private val reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {

    override fun getName(): String {
        return "RNTAlipay"
    }

    @ReactMethod
    fun auth(options: ReadableMap, promise: Promise) {

        Thread {

            val response = Arguments.createMap()

            val alipay = AuthTask(currentActivity)
            // 执行到这会阻塞，直到从支付宝返回当前 App 才会继续往下执行
            val result = alipay.authV2(options.getString("authString"), true)

            val resultStatus = result["resultStatus"] ?: "1"
            if (resultStatus == "9000") {
                response.putInt("code", 0)
                response.putString("msg", "success")
                response.putString("data", result["result"] ?: "")
            } else {
                response.putInt("code", resultStatus.toInt())
                response.putString("msg", result["memo"] ?: "")
            }
            promise.resolve(response)

        }.start()

    }

    @ReactMethod
    fun pay(options: ReadableMap, promise: Promise) {

        Thread {

            val response = Arguments.createMap()

            val alipay = PayTask(currentActivity)
            // 执行到这会阻塞，直到从支付宝返回当前 App 才会继续往下执行
            val result = alipay.payV2(options.getString("orderString"), true)

            val resultStatus = result["resultStatus"] ?: "1"
            if (resultStatus == "9000") {
                response.putInt("code", 0)
                response.putString("msg", "success")
                response.putString("data", result["result"] ?: "")
            } else {
                response.putInt("code", resultStatus.toInt())
                response.putString("msg", result["memo"] ?: "")
            }
            promise.resolve(response)

        }.start()

    }

}
