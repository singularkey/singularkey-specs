# Singular Key iOS Fido2 Demo
![SingularKey Logo](http://singularkey.com/wp-content/uploads/2018/09/SingularKeyLOGOS1.svg)

SingularKey is an authenticator that uses [FIDO2](https://fidoalliance.org) and Web Authentication API ([WebAuthn](https://www.w3.org/TR/webauthn/)). 

This project demonstrates the registration and use of a FIDO2 credential in an iOS App. It uses Singular Key's FIDO2 native API and Singular Key's FIDO2 Cloud Service. FIDO2 Credentials are phishing resistant, attested public key based credentials for strong authentication of users.
The demo supports iOS authenticator using biometrics (faceId,touchId) and device passcode

## Getting Started with Example 2
- Get your `rpid` (Relying Party Id), `origin` and `RP server URL` and `singularKeyAPIKey` from SingularKey dev portal.

This demonstration requires Demo RP (Relying Party) Server (https://github.com/singularkey/webauthndemo) which communicates to Singular Key's FIDO2 Cloud Service. Please contact support (`support@singularkey.com`) for your `free Api Key`.

## Prerequisites
It requies iOS version `9.0 or abve.`

## Install
- Drag and drop `SingularKey.xcframework` bundle into your Xcode project (in Frameworks directory). Make sure you have **Copy items if needed** check off.
- Open `General` tab in your project settings and drag `SingularKey.xcframework` in Embedded Binaries section or do **+** and add.
- Open `Config.swift` file and set `baseURL`, `rpId` and `origin`
- All the API calls is made POST

## Using cocoapods
`pod install`

open iOSFido2Demo.xcworkspace


## Register with name
1. In your register viewController
```swift
import SingularKey
...
```

2. Add following code in your `viewController's` register button action.
Ask user to input name (in text field). Send `name` to `/register/initiate` API

3. If the API call of step 2 is successful, get challenge from `initiateRegistrationResponse["Challenge"]` and call SingularKey's framework function to create credentials using biometric or other available access Control methods. If you do not want to use available access control methods, then pass `userPresent` and `userVerified` flags.
The available modality option are available here: https://developer.apple.com/documentation/security/secaccesscontrolcreateflags


```swift
let modality = SecAccessControlCreateFlags.biometryAny
// use rpid and origin from your Config
let credentials = CredentialsManager()
credentials.credentialsCreate(rpId: Config.rpId, origin: Config.origin, modality: modality, json: <JSON>, userPresent: true, userVerified: true) { (result, error) in
```

4. If there is no error on step 3, you will get JSON `result`.
get `result["createCredResponse"]` values and send them to `/register/complete` API


## Login with name
1. In your login viewController, add this code outside `viewDidLoad` function.
```swift
import SingularKey
...

let credManager = CredentialsManager()

```

2. Add following code in your `viewController's` login button action.
Send username to this API `/auth/initiate` with name as a parameter. You can find API end point details in `NetworkAPIUtils.swift` file.

3. In the successful callback of step 2 network call, get the JSON with `challenge` and publicKeyId (which is one of the item in the array of `allowCredentials` key). Use this JSON to get the stored credentials


```swift
credManager.credentialsGet(rpId: Config.rpId, origin: Config.origin, json: json, userPresent: nil, userVerified: nil) { (result, error) in
```
4. The result of above callback is the JSON data that you need to send to `/auth/complete` API. If the response of this API call is success then you are authenticated.



## Example Project 
You can find example project ( `iOS Example2`) that includes everything mentioned above. Please check it.


### Run
Build your IOS App and install it on an iOS device. Below is a demonstration of the functionality:

<img src="https://singularkey.s3-us-west-2.amazonaws.com/iOSFido2Demo.gif" width="50%" height="50%" />

### Architecture
`iOS FIDO2 Demo App` --> `RP Server (Default Port 3001)` API --> `Singular Key's FIDO Cloud Service`

### Key Files
 * `SignUpViewController.swift`  : Check out https://webauthn.singularkey.com/ for FIDO2 Sequence Diagrams.
    * FIDO2 Registration Steps:
        *  1. `SignUpViewModel.registerInitiate()` : Relying Party (RP) Server API call which is proxied to Singular Key FIDO Service to initiate the FIDO2 registration process to retrieve a randomly generated challenge and other RP and User information
        *  2. `self.credManager.credentialsCreate()` : iOS Singular Key FIDO2 Attestation API call to create a biometrics secured public key based strong `FIDO2 credential`and sign the response (`public key`, challenge and other information)
        *  3. `SignUpViewModel.registerComplete()` : The signed response is sent to the RP Server API which is proxied to Singular Key FIDO Service to complete the FIDO2 registration process
    
* `LoginViewController.swift`  : Check out https://webauthn.singularkey.com/ for FIDO2 Sequence Diagrams.
    * FIDO2 Authentication Steps:
        *   `LoginViewModel.authInitiate()` : RP Server API call which is proxied to Singular Key FIDO Service to initiate the FIDO2 Authentication process to retrieve a randomly generated challenge and other information
        *   `self.credManager.credentialsGet()` : iOS Singular Key FIDO2 Assertion API call to create a signed response (challenge and other information) with the previously created FIDO2 Credential.
        *   `LoginViewModel.authComplete()` : The signed response is sent to the RP Server API  which is proxied to Singular Key FIDO Service to complete the FIDO2 Authentication process

 * `NetworkAPIUtils.swift` - RP API Interface
    * POST /register/initiate
    * POST /register/complete
    * POST /auth/initiate
    * POST /auth/complete

------------
# Support
Have questions? Please contact Support (`support@singularkey.com`) or sign up at http://singularkey.com/singular-key-web-authn-fido-developer-program-api/

# License
Apache 2.0
