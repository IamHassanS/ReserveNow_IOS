//
//  HomeView.swift
//  ReserveNow
//
//  Created by trioangle on 18/04/23.
//

import Foundation
import UIKit
import SafariServices
import SDWebImage

class HomeView: BaseView {
    
   // @IBOutlet weak var contentHolderView: UIView!
    
    @IBOutlet weak var bookNoewView: UIView!
    
    @IBOutlet weak var callHolderView: UIView!
    
    @IBOutlet weak var callView: UIView!
    @IBOutlet weak var contactHolderView: UIView!
    
    @IBOutlet weak var gotoMapHolderView: UIView!
    @IBOutlet weak var gotoMapView: UIView!
    @IBOutlet weak var viewWebsiteHolderView: UIView!
    @IBOutlet weak var viewWebsiteView: UIView!
    @IBOutlet weak var bottomCurveView: UIView!
    
    @IBOutlet weak var backholderview: UIView!
    var homeVc: HomeVc!
    
    override func didLoad(baseVC: BaseViewController) {
        
        
            super.didLoad(baseVC: baseVC)
            self.homeVc = baseVC as? HomeVc

             setupUI()
             initViews()
            //cellRegistration()
            // toLoadData()
 
        }
    
    func setupUI() {
//        self.homeVc.presentAlertWithTitle(title: "Reserve Now", message: "Hello", options: "Ok","Calcel", completion: {
//            (optionss) in
//            switch optionss {
//            case 0: break
//               // self.menuVC.callLogoutAPI()
//            case 1: break
//               // self.hideMenuAndDismiss()
//            //self.menuVC.dismiss(animated: false, completion: nil)
//            default:
//                break
//            }
//        })
       
        bottomCurveView.elevate(4, shadowColor: .lightGray, opacity: 0.5)
        bottomCurveView.setSpecificCornersForTop(cornerRadius: self.bottomCurveView.height / 10)
        bookNoewView.elevate(4, shadowColor: .lightGray, opacity: 0.5)
        bookNoewView.layer.cornerRadius = 10
        
        callView.layer.cornerRadius = callView.height / 2.25
        
        backholderview.layer.cornerRadius = backholderview.height / 2
        backholderview.elevate(4)
        gotoMapView.layer.cornerRadius = gotoMapView.height / 2.25
        
        
        viewWebsiteView.layer.cornerRadius = viewWebsiteView.height / 2.25
    }
    
    
    func initViews() {
        backholderview.addTap {
            self.homeVc.navigationController?.popViewController(animated: true)
        }
        bookNoewView.addTap {
            let reserve = ReservationVc.initWithStory()
            self.homeVc.navigationController?.pushViewController(reserve, animated: true)
        }
        gotoMapHolderView.addTap {
            let vc = MapFilterVC.initWithStory()
            self.homeVc.navigationController?.pushViewController(vc, animated: true)
        }
        
        
        callHolderView.addTap {
            self.callNumber(phoneNumber: "9952447906" as String)
        }
        
        viewWebsiteView.addTap {
            if let url = URL(string: "https://thalappakatti.com/") {
               let safariViewController = SFSafariViewController(url: url)
                self.homeVc.present(safariViewController, animated: true, completion: nil)
            }
         }
  
    }
    
    func callNumber(phoneNumber:String) {

        if let phoneCallURL = URL(string: "telprompt://\(phoneNumber)") {

            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                if #available(iOS 10.0, *) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                     application.openURL(phoneCallURL as URL)

                }
            }
        }
    }
    
}
