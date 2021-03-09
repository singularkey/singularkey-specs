# Singularkey

[![Version](https://img.shields.io/cocoapods/v/Singularkey.svg?style=flat)](https://cocoapods.org/pods/Singularkey)
[![License](https://img.shields.io/cocoapods/l/Singularkey.svg?style=flat)](https://cocoapods.org/pods/Singularkey)
[![Platform](https://img.shields.io/cocoapods/p/Singularkey.svg?style=flat)](https://cocoapods.org/pods/Singularkey)

## Table of contents

*   [Overview](#overview)
*   [Getting started](#getting-started)
*   [Credentials Create](#credentials-create)
*   [Credentials Get](#credentials-get)
*   [Example](#example)
*   [Installation](#installation)

## Overview
This SDK supports iOS authenticator using biometrics (faceId,touchId) and device passcode to verify a user. It talks to Singular Key's FIDO2 Cloud Service. FIDO2 Credentials are phishing resistant, attested public key based credentials for strong authentication of users.

## Getting started

* SDK supports iOS 11.3+
* SDK supports Xcode 12 and above

## Credentials Create
In order to ceate a credential you have to supply following arguments in `credentialsCreate` function  

````swift
// method signature
/*
You can use this function to create/add credentials. You will have to handle publickey and rest of the data yourself.
  - Parameter rpId: Relaying Party Id
  - Parameter origin: iOS app's bundle Id.
  - Parameter modality: The available modality option will be available here: https://developer.apple.com/documentation/security/secaccesscontrolcreateflags
  - Parameter json: It is a json response you get from your FIDO server.
  - Parameter userPresent: It is a flag for user present. You can discard it if you are sending modality
  - Parameter userVerified: It is a flag for user verification. You can discard if you are sending modality
  - Parameter callback: It is a response closure. Response will be result and error. Both result and error are optional
*/
func credentialsCreate(rpId: String, origin: String, modality: SecAccessControlCreateFlags?, json: [String : AnyObject], userPresent: Bool?, userVerified: Bool?, callback:@escaping (_ result: [String : Any]?, _ error: Error?) -> ()) {}


// example
import SingularKey

let credManager = CredentialsManager()
credManager.credentialsCreate(rpId: <YOUR_RPID>, origin: <YOUR_ORIGIN>, modality: SecAccessControlCreateFlags?, json: json, userPresent: Bool = true, userVerified: Bool = true, ) { (result, error) in
    if let err = error {
      // handle error
      return
    }
    guard let result = result else {
      // no response, i.e. invalid response. Check your supplied data and try again.
      return
    }
    guard let createCredResponse = result["createCredResponse"] as? [String: Any] else {
      // no createCredResponse i.e. invalid response. Check your supplied data and try again.
      return
    }

    // use createCredResponse to complete your FIDO2 Registration Step 3
}


````

callback returns dictionary object `[String : Any]?` and/or `Error?` (standard Swift Error object).


## Credentials Get
In order to get the stored credential you have to supply following arguments in `credentialsGet` function

````swift

/*
You can use this function to find the stored credentials and compare with the provided challenge and publickeyId
  return callback with optional dictionary [String: Any] and optional error String
  - Parameter rpId: Relaying Party Id.
  - Parameter origin: iOS app's bundle.
  - Parameter json: It is a json you get from your FIDO server.
  - Parameter userPresent: It is a flag for whether user is preseted or not. You can pass nil to discard if you are not using this flag
  - Parameter userVerified: It is a flag for whether user is verified or not. You can pass nil to discard if you are not using this flag
  - Parameter callback: It is a response closure. Response will be result and error. Both result and error are optional
*/
func credentialsGet(rpId: String, origin: String, json: [String : AnyObject], userPresent: Bool?, userVerified: Bool?, callback: @escaping (_ result: [String: Any]?, _ errorMessage: String?) -> ()) {}

// example
import SingularKey

let credManager = CredentialsManager()
credManager.credentialsGet(rpId: <YOUR_RPID>, origin: <YOUR_ORIGIN>, json: json) { (result, error) in
    if let err = error {
      // handle error
      return
    }
    guard let result = result else {
      // no response, i.e. invalid response. Check your supplied data and try again.
      return
    }
   
    // use result to complete your FIDO2 Authentication Step 3
}

````

callback returns dictionary object `[String : Any]?` and/or errorMessage `String?`

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

Singularkey is available through [CocoaPods](https://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'Singularkey'
```

## Author

Singular Key Inc., info@singularkey.com

## License

Singularkey is available under the MIT license. See the LICENSE file for more info.
