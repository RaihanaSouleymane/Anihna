
//  Anihna
//
//  Created by Raihana Souleymane on 4/26/20.
//  Copyright © 2020 Raihana Souleymane. All rights reserved.
//

import Foundation
import UIKit

var appDisplayname =  Bundle.main.infoDictionary?["CFBundleName"] as? String
var encodedDeviceName = UIDevice.current.name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
var systemVersion = UIDevice.current.systemVersion
var devceMake = "Apple"
var devceModel = UIDevice.current.model
var devceType = "iOS"
var appname = "Anihna"
let devicId = ""// use KeyChain to store it

struct Appname {
    static let appname = "Anihna"
}


struct ButtonTitleConstants {
    static let seach = "SEARCH "
    static let verifyPin = "Verify"
    static let requestPin = "Authenticate"
    static let agree = "Agree"
    static let okay = "Okay"
    static let Confirm = "Confirm"
    static let Skip = "Skip"
    static let SendFeedback = "Send feedback"
    static let Call = "Call"
    static let Cancel = "Cancel"
}


struct  TermsConditions{
    static let tc = "Terms & Conditions"
    static let pp = "Privacy Policy."
    static let lm = "Learn more."

}


//URL Constants

struct LearnMoreConstants {
    static let urlConstants = "https://www.google.com"
}

struct TermsConditionsConstants {
    static let text = "Tap Subcibe Now.\nBy subcribing, you agree to our Terms&Conditions and PrivacyPollicy."
    static let urlConstants = "https://www.google.com"
}

struct PrivacyPolicyConstants {
    static let urlConstants = "https://www.google.com"
}
struct FAQConstants {
    static let text = ""
    static let faqUrlConstants = "https://www.google.com"
}


struct SignOutConstants {
    static let signOutMessage = "Signing out will clear log you out and clear local data.\nThis will not delete your profile from Anihna.\nTo delete your profile, go to Manage profile in the menu."
}

