//
//  Language.swift
//  ReserveNow
//
//  Created by trioangle on 01/08/23.
//

import Foundation
import UIKit

enum Language : String{
    
    case english = "en"
    case tamil = "tl"
    case arabic = "ar"
    

}
extension Language{
    
    
    
    //MARK:- get Current Language
    static func getCurrentLanguage() -> Language{
        let def:String = UserDefaults.standard.string(forKey: "lang") ?? "en"
       
        return Language(rawValue: def) ?? .english
    }
    static func saveLanguage(_ Lang:Language){
       UserDefaults.standard.set(Lang.rawValue, forKey:  "lang")
    }
    //MARK:- get localization  instace
    func getLocalizedInstance()-> LanguageProtocol{
      
        switch self{
        case .tamil:
            return Tamil()
        case .arabic:
            return Arabic()
        default:
            return English()
        }
    }
    
    var isRTL : Bool{
        
        if Language.getCurrentLanguage().rawValue == "ar"{
            return true
        }
        return false
    }
    var locale : Locale{
        switch self {
        case .arabic:
            return Locale(identifier: "ar")
        default:
            return Locale(identifier: "en")
        }
    }
    //NSCalendar(calendarIdentifier:
    var identifier : NSCalendar{
        switch self {
        case .arabic:
            return NSCalendar.init(identifier: NSCalendar.Identifier.islamicCivil)!
        default:
            return NSCalendar.init(identifier: NSCalendar.Identifier.gregorian)!
        }
    }
    var calIdentifier : Calendar{
        switch self {
        case .arabic:
            return Calendar.init(identifier: Calendar.Identifier.islamicCivil)
        default:
            return Calendar.init(identifier: Calendar.Identifier.gregorian)
        }
    }
    //MARK:- get display semantice
    var getSemantic:UISemanticContentAttribute {
        
        return self.isRTL ? .forceRightToLeft : .forceLeftToRight
     
    }
    
    //MARK:- for imageView Transform Display
    var getAffine:CGAffineTransform {
        
        return self.isRTL ? CGAffineTransform(scaleX: -1.0, y: 1.0) : CGAffineTransform(scaleX: 1.0, y: 1.0)
    
    }
    
    //MARK:- for Text Alignment
    func getTextAlignment(align : NSTextAlignment) -> NSTextAlignment{
        guard self.getSemantic == .forceRightToLeft else {
            return align
        }
        switch align {
        case .left:
            return .right
        case .right:
            return .left
        case .natural:
            return .natural
        default:
            return align
        }
    }
    
    //MARK:- for ButtonText Alignment
    func getButtonTextAlignment(align : UIControl.ContentHorizontalAlignment) -> UIControl.ContentHorizontalAlignment{
        guard self.getSemantic == .forceRightToLeft else {
            return align
        }
        switch align {
        case .left:
            return .right
        case .right:
            return .left
        case .center:
            return .center
        default:
            return align
        }
    }
    
  
}
