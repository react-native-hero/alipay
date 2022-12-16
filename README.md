# @react-native-hero/alipay

封装支付宝 SDK，仅支持支付功能。

## Getting started

Install the library using either Yarn:

```
yarn add @react-native-hero/alipay
```

or npm:

```
npm install --save @react-native-hero/alipay
```

## Link

- React Native v0.60+

For iOS, use `cocoapods` to link the package.

run the following command:

```
$ cd ios && pod install
```

For android, the package will be linked automatically on build.

- React Native <= 0.59

run the following command to link the package:

```
$ react-native link @react-native-hero/alipay
```

## Usage

```js
import {
  pay,
} from '@react-native-hero/alipay'

// 支付（一般透传后端传来的参数，不用管它是什么意思）
pay({
  orderString: 'orderString',
  // ios 需传入 appScheme
  // appScheme 为 app 在 info.plist 注册的 scheme
  appScheme: 'appScheme',
})
.then(response => {
  /**
   * 示例 data 如下
   * {
        "alipay_trade_app_pay_response":{
            "code":"10000",
            "msg":"Success",
            "app_id":"2014072300007148",
            "out_trade_no":"081622560194853",
            "trade_no":"2016081621001004400236957647",
            "total_amount":"9.00",
            "seller_id":"2088702849871851",
            "charset":"utf-8",
            "timestamp":"2016-10-11 17:43:36"
        },
        "sign":"NGfStJf3i3ooWBuCDIQSumOpaGBcQz+aoAqyGh3W6EqA/gmyPYwLJ2REFijY9XPTApI9YglZyMw+ZMhd3kb0mh4RAXMrb6mekX4Zu8Nf6geOwIa9kLOnw0IMCjxi4abDIfXhxrXyj********",
        "sign_type":"RSA2"
    }
   */
  response.data
})
.catch(response => {
  // 支付失败
  // code 可能的值如下：
  // 8000: 正在处理中，支付结果未知（有可能已经支付成功），请查询商家订单列表中订单的支付状态。
  // 4000: 订单支付失败。
  // 5000: 重复请求。
  // 6001: 用户中途取消。
  // 6002: 网络连接出错。
  // 6004: 支付结果未知（有可能已经支付成功），请查询商家订单列表中订单的支付状态。
  response.code
  response.msg
})
```
