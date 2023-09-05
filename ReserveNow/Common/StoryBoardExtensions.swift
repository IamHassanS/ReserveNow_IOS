//
//  StoryboardExtensions.swift
//  Makent
//
//  Created by Trioangle technologies on 05/04/23.
//

import Foundation
import UIKit

//MARK:- Extensions
protocol ReusableView: AnyObject {}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
  
}
extension UIView {
    
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
extension ReusableView where Self : UIView {
     static func nib() -> UINib {
        return UINib(nibName: self.reuseIdentifier, bundle: nil)
    }
    static func getViewFromXib<T: ReusableView>() -> T?{
        return self.nib().instantiate(withOwner: nil, options: nil).first as? T
    }

    func setupFromNib<T: ReusableView & UIView>(_ object : T) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.02) {
            guard let view : T = Self.getViewFromXib(),
                !object.subviews.compactMap({$0.tag}).contains(2523143) else { fatalError("Error loading \(self) from nib") }
            view.tag = 2523143
            view.frame = object.bounds
            view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
            object.addSubview(view)
            object.bringSubviewToFront(view)
      }
       
    }
}

// UIViewController.swift
extension UIViewController: ReusableView { }

// UIStoryboard.swift
extension UIStoryboard {
    
   

 
    static var Main : UIStoryboard{
        return UIStoryboard(name: "Account", bundle: nil)
    }
    

    static var TabBarItems : UIStoryboard{
        return UIStoryboard(name: "TabBarItems", bundle: nil)
    }
    

    func instantiateViewController<T>() -> T where T: ReusableView {
        return instantiateViewController(withIdentifier: T.reuseIdentifier) as! T
    }
    /**

     */
    func instantiateIDViewController<T>() -> T where T: ReusableView {
        return instantiateViewController(withIdentifier: T.reuseIdentifier + "ID") as! T
    }
}
