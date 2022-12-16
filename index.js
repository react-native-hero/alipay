
import { NativeModules } from 'react-native'

const { RNTAlipay } = NativeModules

/**
 * 支付
 */
export function pay(options) {
  return new Promise((resolve, reject) => {
    RNTAlipay
      .pay(options)
      .then(response => {
        if (response.code === 0) {
          if (response.data && typeof response.data === 'string') {
            // 把 json 字符串解析成对象，方便外部处理
            response.data = JSON.parse(response.data)
          }
          resolve(data)
        }
        else {
          reject(data)
        }
      })
  })
}
