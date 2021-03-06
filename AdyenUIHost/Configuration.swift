//
// Copyright (c) 2017 Adyen B.V.
//
// This file is open source and available under the MIT license. See the LICENSE file for more info.
//

import Foundation

// Fill in your app identifier and secret key here.
struct Configuration {
    static var appSecretKey = ""
    
    static var isFilledIn: Bool {
        return appSecretKey.characters.isEmpty == false
    }
    
    // Checks if SecretKey was defined in compile time via SECRET_KEY user defined build setting.
    static func readApiKeyFromUserDefinedBuildSettings() {
        if let apiKey = Bundle.init(for: AppDelegate.self).object(forInfoDictionaryKey: "SecretKey") as? String,
            apiKey.characters.isEmpty == false {
            Configuration.appSecretKey = apiKey
        }
    }
}
