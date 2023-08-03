//
//  GlobalVariables.swift
//  Makent
//
//  Created by Trioangle technologies on 05/04/23.
//

import Foundation
import UIKit

// MARK: - Application Details
/**
 isSimulator is a Global Variable.isSimulator used to identfy the current running mechine
 - note : Used in segregate Simulator and device to do appropriate action
 */
var isSimulator : Bool { return TARGET_OS_SIMULATOR != 0 }
/**
 AppVersion is a Global Variable.AppVersion used to get the current app version from info plist
 - note : Used in Force update functionality to get newer version update
 */
var AppVersion : String? = { return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String }()


// MARK: - UserDefaults Easy Access
/**
 userDefaults is a Global Variable.
 - note : userDefaults used to store and retrive details from Local Storage (Short Access)
 */
let userDefaults = UserDefaults.standard


// MARK: - URLS and API Keys
/**
 infoPlist is a Global Variable.
 - note : infoPlist used to read all the details inside info plist
 */
let infoPlist = PlistReader<InfoPlistKeys>()

enum AppURL
{
    case demo
    case live
    var instance :String {
        switch  self
        {
        case .live:
            return "https://makent.trioangle.com/"
        case .demo :
//            return "http://makent.trioangledemo.com/"
            return "https://makent81.trioangledemo.com/"
            //return "http://10.10.5.250:81/"
        }
    }
}
/**
 APIBaseUrl is a Global Variable. Get from info Plist, Change in Configuration File
 - note : used in project's All source files (eg: images)
 - warning : Don't Forget to Add Your URL here
 */
let APIBaseUrl : String = (infoPlist?.value(for: .App_URL) ?? "").replacingOccurrences(of: "\\", with: "")
/**
 Global_UserType is a Global Variable. Get from info Plist, Change in Configuration File
 - note : used in project's All source files (eg: images)
 - warning : Don't Forget to Add Your URL here
 */
let Global_UserType : String = "User" //(infoPlist?.value(for: .UserType) ?? "")
/**
 APIUrl is a Global Variable. Get from info Plist, Change in Configuration File
 - note : used in project's All APIs
 - warning : Don't Forget to Add Your URL here
 */

let APIUrlForImg : String = APIBaseUrl + "public/"

let APIUrl : String = APIBaseUrl + "api/"
/**
 GoogleAPIKey is a Global Variable. Get from info Plist, Change in Configuration File
 - note : used in maps and geodecode from Google Api
 - warning : Don't Forget to Add Your Key before AppCheck
 */
let GoogleAPIKey : String = infoPlist?.value(for: .Google_API_keys) ?? ""
/**
 GooglePlacesApiKey is a Global Variable. Get from info Plist, Change in Configuration File
 - note : used in Places name and direction from Google Api
 - warning : Don't Forget to Add Your Key before AppCheck
 */
let GooglePlacesApiKey : String = infoPlist?.value(for: .Google_Places_keys) ?? ""
/**
 appLogo is a Global Variable.appLogo Holds the image name of the applogo in our Project
 - warning : appLogo name must preset in image assets
 */
let appLogo = "applogo_grey.png"
/**
 forceUpdateVersion is a Global Variable.forceUpdateVersion Holds the value for next update check from forceupdate
 - warning : don't for get to change the value for config before any build
 */
var forceUpdateVersion : String? = infoPlist?.value(for: .ReleaseVersion)

// MARK: - Custom Font Names
/**
 RegularFont is a Global Variable.RegularFont Holds the Regular Font Name used in our Project
 - note : RegularFont used in All Lables and Button
 */
var Coda_RegularFont : String = "Coda-Regular"
var Menio_RegularFont : String = "Menlo-Regular"
var Font_Awesome : String = "FontAwesome"
var Century_Font : String = "century"
/**
 MediumFont is a Global Variable.MediumFont Holds the Medium Font Name used in our Project
 - note : MediumFont used in All Lables and Button
 */
var CircularAir_Bold : String = "CircularAir-Bold"
var CircularAir_Book : String = "CircularAir-Book"
var CircularAir_Light : String = "CircularAir-Light"
/**
 BoldFont is a Global Variable.BoldFont Holds the Bold Font Name used in our Project
 - note : BoldFont used in All Lables and Button
 */
var Makent1 : String = "makent1"
var Makent2 : String = "makent2"
var Makent3 : String = "makent3"
/**
 ImageFont is a Global Variable.ImageFont Holds the Images  used in our Project
 - note : ImageFont used in All Lable image setting
 */
let ImageFont : String = "makent-amenities"




// MARK: - Application Features Variables

/**
 isSingleApplication is a Global Variable.To initiate Single Application Feature in Application
 - Warning: make sure you set 'false' to get Multiple Application
 */
var isSingleApplication : Bool = false
/**
 CanRequestSinchNotification is a Global Variable. To initiate Sinch Call  set 'true'
 - Warning: make sure you set 'true' to get Sinch Call
 */
let CanRequestSinchNotification = true
/**
 crashApplicationOnSplash is a Global Variable.To initiate firebase crash analytics set 'true'
 - Warning: make sure you set 'false' before launching
 */
let crashApplicationOnSplash = false


class Constants : NSObject {
    
    func STOREVALUE(value : String ,
                    keyname : String) {
        UserDefaults.standard.setValue(value,
                                       forKey: keyname)
        UserDefaults.standard.synchronize()
    }
    
    func GETVALUE(keyname : String) -> String {
        if let value = UserDefaults.standard.value(forKey: keyname) as? String {
            return value
        } else {
            debug(print: "\(keyname) Value is Missing")
            return ""
        }
    }
    
    static let guestThemeColor = UIColor.init(hex: "#00A699")
    static let hostThemeColor = UIColor.init(hex: "#FF5A5F")
    static let darkThemeColor = UIColor.init(hex: "#00464d")
    
    static let hostButtonColor = Constants.guestThemeColor
    static let guestButtonColor = Constants.hostThemeColor
    
    

    static let monsterFavouriteColor = UIColor(red: 255.0 / 255.0, green: 114.0 / 255.0, blue: 114.0 / 255.0, alpha: 1.0)
    static let monsterLightColor = Constants.guestThemeColor.withAlphaComponent(0.5)
    
    static let instantBookColor = UIColor(red: 255.0 / 255.0, green: 180.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
    static let downarrowImage = UIImage(named: "down-arrow1")?.withRenderingMode(.alwaysTemplate)
    static let maplayer = UIImage(named: "map_layer")?.withRenderingMode(.alwaysTemplate)
    static let spaceImage = UIImage(named: "rooms")?.withRenderingMode(.alwaysTemplate)
    static let upArrow = UIImage(named: "upicon")?.withRenderingMode(.alwaysTemplate)
    
}
