//
//  SpalashVC.swift
//  Makent
//
//  Created by Trioangle technologies on 05/04/23.
//

import Foundation
import UIKit

class SplashVC: BaseViewController{
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet var splashView: SplashView!
    var isFirstTimeLaunch : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
      //  callCheckVersion()
    }
    
    
    class func initWithStory() -> SplashVC {
        let splash : SplashVC = UIStoryboard.Main.instantiateViewController()
       // splash.accViewModel = AccountViewModel()
        return splash
    }
    
    func callCheckVersion(){
        
        AppDelegate.shared.setTabbarForSwithUsers()
        
//        var paramDict = JSON()
//        paramDict = ["version": AppVersion ?? 1, "device_type" : "1"]
//        accViewModel.checkAppVersion(params: paramDict) { result in
//            switch result{
//            case .success(let response):
//                print(response)
//                self.checkVersionModel = response
//                print(self.checkVersionModel.force_update ?? "")
//
//                AppDelegate.shared.setTabbarForSwithUsers(viewCtrl: self)
//            case .failure(let error):
//                print(error.localizedDescription)
//                self.appDelegate.createToastMessage(error.localizedDescription, isSuccess: false)
//                break
//            }
//        }
    }
}
