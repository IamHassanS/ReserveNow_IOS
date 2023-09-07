//
//  OTPValidationView.swift
//  ReserveNow
//
//  Created by trioangle on 06/09/23.
//

import Foundation
import UIKit
extension OTPValidationView: CheckStatusProtocol {
    func checkStatus() {
        print("Checked")
        let isActive : Bool
        if let _otp = self.otpView.otp{
            isActive = _otp.count == 6//_otp == self.otpView.otp
        }else{
            isActive = false
        }
       // self.bottomDescLbl.textColor = .black
        self.btnNxt.alpha = isActive ? 1 : 0.5
        self.btnNxt.isUserInteractionEnabled = isActive
    }
}

class OTPValidationView: BaseView  {

    
    @IBOutlet weak var btnNxt: UIButton!
    @IBOutlet weak var inputFieldHolderView: UIView!
    var otpValidationVC: OTPValidationVC!
    
    lazy var otpView : OTPView = {
        let _otpView = OTPView.getView(with: self,
                                       using: self.inputFieldHolderView.bounds)
 
        return _otpView
    }()
    lazy var toolBar : UIToolbar = {
        let tool = UIToolbar(frame: CGRect(origin: CGPoint.zero,
                                              size: CGSize(width: self.frame.width,
                                                           height: 30)))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                    target: nil,
                                    action: nil)
        let done = UIBarButtonItem(barButtonSystemItem: .done,
                                   target: self,
                                   action: #selector(self.doneAction))
        let clear = UIBarButtonItem(barButtonSystemItem: .refresh,
                                   target: self,
                                   action: #selector(self.clearAction))
        tool.setItems([clear,space,done], animated: true)
        tool.sizeToFit()
        return tool
    }()
    override func didLoad(baseVC: BaseViewController) {
        super.didLoad(baseVC: baseVC)
        self.otpValidationVC = baseVC as? OTPValidationVC
        initActions()
        setupUI()
    }
    func  initActions() {
        
    }
    @objc func doneAction(){
        self.endEditing(true)
        self.checkStatus()
    }
    
    @objc func clearAction(){
     //   if self.currentScreenState == .mobileNumber{
         //   self.mobileNumberView.clear()
         
       // }else{
            
            self.otpView.clear()
      //  }
    }
    

    
    


    
    func setupUI() {
        btnNxt.setTitle("", for: .normal)
        btnNxt.elevate(2)
        btnNxt.layer.cornerRadius = btnNxt.height / 2
        self.inputFieldHolderView.insertSubview(self.otpView, at: 0)//(self.otpView)
        self.inputFieldHolderView.bringSubviewToFront(self.otpView)
        self.otpView.setToolBar(self.toolBar)
    }
    
    @IBAction func didTapNxtBtn(_ sender: Any) {
        
      //  AuthManager.shared.authenticatePhoneNumber(number: <#T##String#>, completion: <#T##(Bool) -> ()#>)
        
        AuthManager.shared.validateOTP(OTPcode:  self.otpView.otp!) { isValid in
            if isValid {
                let infoVc = UserInfoVC.initWithStory()
                self.otpValidationVC.navigationController?.pushViewController(infoVc, animated: true)
            } else {
                self.otpView.invalidOTP()
            }
        }
        
      
    }
    
}
