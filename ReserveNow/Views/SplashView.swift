//
//  SplashView.swift
//  Makent
//
//  Created by Trioangle technologies on 05/04/23.
//

import Foundation
import UIKit

class SplashView: BaseView{
    
    var splashVC : SplashVC!
    
    @IBOutlet var lblMenuTitle: UILabel!
    @IBOutlet var imgAppIcon: UIImageView!
    
    @IBOutlet weak var SplashImageHolderView: UIView!
    override
    func didLoad(baseVC: BaseViewController) {
        super.didLoad(baseVC: baseVC)
        self.splashVC = baseVC as? SplashVC
        setupUI()
        self.initView()
    }
    
    func initView(){
        
        Timer.scheduledTimer(timeInterval:3.0, target: self, selector: #selector(self.onSetRootViewController), userInfo: nil, repeats: false)
        }
        
        
        
        
    
    
    func setupUI() {
        self.backgroundColor = .white
        SplashImageHolderView.elevate(2, shadowColor: .lightGray, opacity: 0.5)
        imgAppIcon.clipsToBounds = true
        
        SplashImageHolderView.layer.cornerRadius = 12
        imgAppIcon.layer.cornerRadius  = 12
    }
    
    @objc func wsToCheckVersion() {
        splashVC.callCheckVersion()
    }
    

//    @objc func onSetRootViewController()
//    {
//        self.splashVC.callCheckVersion()
////        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
////        appDelegate.setTabbarForSwithUsers(viewCtrl: self.splashVC)
//    }

    @objc func onSetRootViewController()
    {
        splashVC.callCheckVersion()
//        self.splashVC.callCheckVersion()
//        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.setTabbarForSwithUsers(viewCtrl: self.splashVC)
    }


    
}
