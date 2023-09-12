import Foundation
import UIKit
import MobileCoreServices

let ThemeColors : JSON? = infoPlist?.value(for: .ThemeColors)



class Fonts:NSObject{
    static let CIRCULAR_BOLD = "CircularAirPro-Bold"
    static let CIRCULAR_LIGHT = "CircularAirPro-Light"
    static let CIRCULAR_BOOK = "CircularAirPro-Book"
    static let MAKENT_LOGO_FONT1 = "makent1"
    static let MAKENT_LOGO_FONT2 = "makent2"
    static let MAKENT_LOGO_FONT3 = "makent3"
    static let MAKENT_AMENITIES_FONT = "makent-amenities"
}

enum CustomFont {
    case bold(size:CGFloat)
    case light(size:CGFloat)
    case medium(size:CGFloat)
    case logo(size:CGFloat)
    
    var instance:UIFont {
        switch self {
        case .bold(size: let size):
            return UIFont(name: Fonts.CIRCULAR_BOLD, size: size) ?? UIFont.systemFont(ofSize: 14, weight: .medium)
        case .light(size: let size):
            return UIFont(name: Fonts.CIRCULAR_LIGHT, size: size) ?? UIFont.systemFont(ofSize: 14, weight: .medium)
        case .medium(size: let size):
            return UIFont(name: Fonts.CIRCULAR_BOOK, size: size) ?? UIFont.systemFont(ofSize: 14, weight: .medium)
            
        case .logo(size: let size):
            return UIFont(name: Fonts.MAKENT_LOGO_FONT1, size: size) ?? UIFont.systemFont(ofSize: 14, weight: .medium)
        }
    }

}
extension CGFloat {
    static let EXTRALARGE :CGFloat = 52
    static let LARGE :CGFloat = 35
    static let HEADER:CGFloat = 20
    static let SUBHEADER:CGFloat = 16
    static let BODY:CGFloat = 14
    static let SMALL:CGFloat = 12
    static let TINY:CGFloat = 10
}


extension UIColor {
    static var covidShildColor = UIColor(hex: "35af00")
    static var appGuestThemeColor = Constants.guestThemeColor
    static var appHostThemeColor = Constants.hostThemeColor
    
    static var appGuestButtonBG = Constants.guestButtonColor
    static var appHostButtonBG = Constants.hostButtonColor
    
    static var appTitleColor = Constants.guestThemeColor
    static var appHostTitleColor = Constants.hostThemeColor

    static var appFavouriteColor = Constants.monsterFavouriteColor

    static var appGuestLightColor = Constants.monsterLightColor
    static var instantBookColor = Constants.instantBookColor
    
    static let blackcolor = UIColor.black
    static let lightColor = UIColor(hex: "EBEBEB") // "#DEDEDE"
    static var appDarkThemeColor = Constants.darkThemeColor
    
}


extension UIColor {

    private static var _Colors = [String : UIColor]()

    open class var GuestThemeColor : UIColor {
        get { return UIColor._Colors["GuestThemeColor"] ?? UIColor(hex: ThemeColors?.string("GuestThemeColor")) }
        set { UIColor._Colors["GuestThemeColor"] = newValue } }

    open class var HostThemeColor : UIColor {
        get { return UIColor._Colors["HostThemeColor"] ?? UIColor(hex: ThemeColors?.string("HostThemeColor")) }
        set { UIColor._Colors["HostThemeColor"] = newValue } }

    open class var GuestDarkThemeColor : UIColor { return UIColor(hex: ThemeColors?.string("GuestDarkThemeColor")) }

    open class var CovidSheildColor : UIColor { return UIColor(hex: ThemeColors?.string("CovidSheildColor")) }

    open class var FavoriteColor: UIColor { return UIColor(hex: ThemeColors?.string("FavoriteColor")) }

    open class var LightFavoriteColor: UIColor { return UIColor(hex: ThemeColors?.string("FavoriteColor")).withAlphaComponent(0.5) }

    open class var InstantBookColor : UIColor { return UIColor(hex: ThemeColors?.string("InstantBookColor")) }
    
    
    //MARK: hex Extention
    public  convenience init(hex : String?) {
        guard let hex = hex else {
            self.init()
            return }

        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            self.init(red: 1, green: 1, blue: 1, alpha: 1)
            return
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}



extension UILabel {
    func appGuestTextColor() {
        self.textColor = .appTitleColor
    }
    
    func appHostTextColor() {
        self.textColor = .appHostTitleColor
        
    }
    
    
    func appGuestBGColor() {
        self.backgroundColor = UIColor.appGuestThemeColor
    }
    
    func appHostBGColor() {
        self.backgroundColor = UIColor.appHostThemeColor
    }
    
    
    func clearBG(setText textColor:UIColor = .black) {
        self.backgroundColor = nil
        self.textColor = textColor
    }
    
    func setFont(font customFont: CustomFont) {
      
        self.font = customFont.instance
    }
    
    
    func updateTextColor(_ color:UIColor = .blackcolor) {
        self.textColor = color
    }
    
    
    func addFontAttribute(originalText:String, attrText:String, font:UIFont,attrColor:UIColor? = nil) {
        let strName = originalText
        let string_to_color2 = attrText
        let attributedString1 = NSMutableAttributedString(string:strName)
        let range2 = (strName as NSString).range(of: string_to_color2)
               print(range2)
               attributedString1.addAttribute(NSAttributedString.Key.font, value: font, range: range2)
        if attrColor != nil {
            
            attributedString1.addAttribute(.foregroundColor, value: attrColor, range: range2)
        }
        self.attributedText = attributedString1
    }
    
    func addAttributeFont(originalText: String,attributedText: String,attributedFontName:String,attributedColor:UIColor,attributedFontSize:CGFloat) -> NSMutableAttributedString {
        let strName = originalText
        let string_to_color2 = attributedText
        let attributedString1 = NSMutableAttributedString(string:strName)
        let range2 = (strName as NSString).range(of: string_to_color2)
        attributedString1.addAttribute(NSAttributedString.Key.font, value: UIFont(name: attributedFontName, size: attributedFontSize) as Any, range: range2)
        attributedString1.addAttributes(convertToNSAttributedStringKeyDictionary([convertFromNSAttributedStringKey(NSAttributedString.Key.foregroundColor):attributedColor]), range: range2)
        return attributedString1
    }
}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
    return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToNSAttributedStringKeyDictionary(_ input: [String: Any]) -> [NSAttributedString.Key: Any] {
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}


extension URL {
    
    func getMimeType() -> String {
        let pethExtension = self.pathExtension
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as NSString, nil)?.takeRetainedValue() {
            if let type = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return type as String
            }
     
        }
        return "application/octet-stream"
    }
    
   
}

extension Array{
    
    var isNotEmpty : Bool{
        return !self.isEmpty
    }
    
    func value(atSafe index : Int) -> Element?{
        guard self.indices.contains(index) else {return nil}
        return self[index]
    }
    func find(includedElement: @escaping ((Element) -> Bool)) -> Int? {
        for arg in self.enumerated(){
            let (index,item) = arg
            if includedElement(item) {
                return index
            }
        }
        
        return nil
    }
}


extension String {
    var containsSpecialCharacter: Bool {
        let regex = "^(?=.*[a-z])(?=."
        + "*[A-Z])(?=.*\\d)"
        + "(?=.*[-+_!@#$%^&*., ?]).+$"
        let testString = NSPredicate(format:"SELF MATCHES %@", regex)
        return testString.evaluate(with: self)
    }
    
    
    var isValidMail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    var isValidPhoneNumber: Bool {
        let phoneRegEx = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phonePred = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return phonePred.evaluate(with: self)
    }
    
    func isValiduserName(Input:String) -> Bool {
        let RegEx = "\\w{1,18}"
        let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return Test.evaluate(with: Input)
    }
    
}

public extension Bundle {
    
    /**
     Gets the contents of the specified plist file.
     
     - parameter plistName: property list where defaults are declared
     - parameter bundle: bundle where defaults reside
     
     - returns: dictionary of values
     */
    static func contentsOfFile(plistName: String, bundle: Bundle? = nil) -> [String : AnyObject] {
        let fileParts = plistName.components(separatedBy: ".")
        
        guard fileParts.count == 2,
            let resourcePath = (bundle ?? Bundle.main).path(forResource: fileParts[0], ofType: fileParts[1]),
            let contents = NSDictionary(contentsOfFile: resourcePath) as? [String : AnyObject]
            else { return [:] }
        
        return contents
    }
    static func contentsOfFileArray(plistName: String, bundle: Bundle? = nil) -> [[String: Any]] {
        let fileParts = plistName.components(separatedBy: ".")
        
        guard fileParts.count == 2,
            let resourcePath = (bundle ?? Bundle.main).path(forResource: fileParts[0], ofType: fileParts[1]),
            let contents = NSArray(contentsOfFile: resourcePath)
            else { return [[String:Any]]() }
        
        return contents as! [[String : Any]]
    }
    
    /**
     Gets the contents of the specified bundle URL.
     
     - parameter bundleURL: bundle URL where defaults reside
     - parameter plistName: property list where defaults are declared
     
     - returns: dictionary of values
     */
    static func contentsOfFile(bundleURL: NSURL, plistName: String = "Root.plist") -> [String : AnyObject] {
        // Extract plist file from bundle
        guard let contents = NSDictionary(contentsOf: bundleURL.appendingPathComponent(plistName)!)
            else { return [:] }
        
        // Collect default values
        guard let preferences = contents.value(forKey: "PreferenceSpecifiers") as? [String: AnyObject]
            else { return [:] }
        
        return preferences
    }
    
    /**
     Gets the contents of the specified bundle name.
     
     - parameter bundleName: bundle name where defaults reside
     - parameter plistName: property list where defaults are declared
     
     - returns: dictionary of values
     */
    static func contentsOfFile(bundleName: String, plistName: String = "Root.plist") -> [String : AnyObject] {
        guard let bundleURL = Bundle.main.url(forResource: bundleName, withExtension: "bundle")
            else { return [:] }
        
        return contentsOfFile(bundleURL: bundleURL as NSURL, plistName: plistName)
    }
    
    /**
     Gets the contents of the specified bundle.
     
     - parameter bundle: bundle where defaults reside
     - parameter bundleName: bundle name where defaults reside
     - parameter plistName: property list where defaults are declared
     
     - returns: dictionary of values
     */
    static func contentsOfFile(bundle: Bundle, bundleName: String = "Settings", plistName: String = "Root.plist") -> [String : AnyObject] {
        guard let bundleURL = bundle.url(forResource: bundleName, withExtension: "bundle")
            else { return [:] }
        
        return contentsOfFile(bundleURL: bundleURL as NSURL, plistName: plistName)
    }
    
}

