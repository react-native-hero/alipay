
import { NativeModules } from 'react-native'

const { RNTAlipay } = NativeModules

/**
 * 授权登录
 */
export function auth(options) {
  return new Promise((resolve, reject) => {
    RNTAlipay
      .auth(options)
      .then(response => {
        if (response.code === 0) {
          if (response.data && typeof response.data === 'string') {
            // 把 json 字符串解析成对象，方便外部处理
            // data 示例
            // success=true&auth_code=d9d1b5acc26e461dbfcb6974c8ff5E64&result_code=200 &user_id=2088003646494707
            const data = { }
            response.data.split('&').forEach(
              function (item) {
                const tokens = item.split('=')
                if (tokens.length === 2) {
                  const key = tokens[0].trim()
                  const value = tokens[1].trim()
                  if (key && value) {
                    data[key] = value
                  }
                }
              }
            )
            response.data = data
          }
          resolve(response)
        }
        else {
          reject(response)
        }
      })
  })
}

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
          resolve(response)
        }
        else {
          reject(response)
        }
      })
  })
}
