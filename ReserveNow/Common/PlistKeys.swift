import Foundation

enum InfoPlistKeys : String{
    case Google_API_keys
    case Google_Places_keys
    case App_URL
    case RedirectionLink_user
    case ThemeColors
    case ReleaseVersion
    case UserType
}
extension InfoPlistKeys : PlistKeys{
    var key: String{
        return self.rawValue
    }
    
    static var fileName: String {
        return "Info"
    }
    
    
}
