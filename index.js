
import { NativeEventEmitter, NativeModules, Platform } from 'react-native'

const { RNTAlipay } = NativeModules

/**
 * 支付
 */
export function pay(options) {
  return new Promise((resolve, reject) => {
    RNTAlipay
      .pay(options)
      .then(data => {
        resolve(data)
      })
  })
}
