//
//  LoginView.swift
//  ReserveNow
//
//  Created by trioangle on 03/08/23.
//

import Foundation
import UIKit
import FirebaseAuth
class LoginVIew: BaseView {
    
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var credentialsStack: UIStackView!
    @IBOutlet weak var passwordValidationLbl: UILabel!
    @IBOutlet weak var signUpbtn: UIButton!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    var loginVc: LoginVC!
    var isPasswoordVerified = false
    var isEmailVerified = false
    var isShowViewModified = Bool()
    var isHideViewModified = Bool()
    override func didLoad(baseVC: BaseViewController) {
        
       
        super.didLoad(baseVC: baseVC)
        self.loginVc = baseVC as? LoginVC
        initData()
        setupUI()
        initNotifcations()
    }
    
    func  initData(){
        emailTF.delegate = self
        passwordTF.delegate = self

    }
    
    func initNotifcations() {
//        NotificationEnum.UIKeyboardWillShowNotification.addObserver(self, selector: "keyboardWillShow:")
//        NotificationEnum.UIKeyboardWillHideNotification.addObserver(self, selector: "keyboardWillHide:")
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    deinit {
        NotificationEnum.removeobserver.removeAll(self)
    }
    
    @objc
    func keyboardWillShow(notification: NSNotification) {
        
    


        
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            //let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
           
            var frame = self.credentialsStack.frame
            frame.origin.y -= keyboardSize.height / 2
            //keyboardSize.height / 2
 if emailTF.isFirstResponder && !isShowViewModified {
     isShowViewModified = true
     UIView.transition(with: credentialsStack, duration: 0.33,
       options: [.curveEaseOut, .transitionFlipFromTop],
       animations: {
         self.credentialsStack.frame = frame
       },
       completion: nil
     )
     print("")
 } else if passwordTF.isFirstResponder && !isShowViewModified  {
     isShowViewModified = true
     UIView.transition(with: credentialsStack, duration: 0.33,
       options: [.curveEaseOut, .transitionFlipFromTop],
       animations: {
         self.credentialsStack.frame = frame
       },
       completion: nil
     )
     print("")
 }
        
        }
    }
    
    @objc
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            var frame = self.credentialsStack.frame
            frame.origin.y += keyboardSize.height / 2
 if emailTF.isFirstResponder && !isHideViewModified {
     isHideViewModified = true
     UIView.transition(with: credentialsStack, duration: 0.33,
       options: [.curveEaseOut, .transitionFlipFromBottom],
       animations: {
         self.credentialsStack.frame = frame
       },
       completion: nil
     )
    
     print("")
 } else if passwordTF.isFirstResponder && !isHideViewModified  {
     isHideViewModified = true
     UIView.transition(with: credentialsStack, duration: 0.33,
       options: [.curveEaseOut, .transitionFlipFromBottom],
       animations: {
         self.credentialsStack.frame = frame
       },
       completion: nil
     )
     print("")
 }
        }
    }
    
    func setupUI() {
        checkButtonStatus(true)
        passwordValidationLbl.isHidden = true
        //passwordTF.isSecureTextEntry = true
        topView.setSpecificCornersForBottom(cornerRadius: 25)
    }
    
    @IBAction func didTapLoginBtn(_ sender: Any) {
//        guard let email = emailTF.text, !email.isEmpty , let password = passwordTF.text, !password.isEmpty else {return}
//        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) {[weak self] result, error in
//            guard let welf = self else {return}
//            let appdelegate = UIApplication.shared.delegate as! AppDelegate
//            guard  error == nil else {
//                //Create Account
//                welf.createAccount(email, password)
//                return
//            }
//            self?.loginVc.sceneDelegate!.createToastMessage("Account created failed", isFromWishList: true)
//         //   appdelegate.createToastMessage("Account created failed")
//        }
        let commonAlert = CommonAlert()
        commonAlert.setupAlert(alert: "App name", alertDescription: "Hello user", okAction: "Ok",cancelAction: "Cancel")
        commonAlert.addAdditionalOkAction(isForSingleOption: false) {
            print("no action")
           // isPayout ? self.PayoutAlert(comments: self.lang.payoutContent) : self.callAccDeleteApi()
            
            self.callOTPPage()
        }
        commonAlert.addAdditionalCancelAction {
            print("yes action")
        }
        self.loginVc.sceneDelegate!.createToastMessage("Account created failed", isFromWishList: true)
    }
    
    func callOTPPage() {
        let otp = OTPValidationVC.initWithStory()
       // otp.hidesBottomBarWhenPushed = true
        self.loginVc.navigationController?.pushViewController(otp, animated: true)
    }
    
    
    
    func createAccount(_ email: String, _ password: String) {
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) {[weak self] result, error in
            guard let welf = self else {return}
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
            guard  error == nil else {
                self?.loginVc.sceneDelegate!.createToastMessage("Account created successfully", isFromWishList: true)
          //      appdelegate.createToastMessage("Account created successfully")
                return
            }
            self?.loginVc.sceneDelegate!.createToastMessage("Account created successfully", isFromWishList: true)
         //   appdelegate.createToastMessage("Account created failed")
        }
        
//
//        let commonAlert = CommonAlert()
//        commonAlert.setupAlert(alert: "Care Taxi", alertDescription: "Are you sure want to create account", okAction: "Ok",cancelAction: "Cancel")
//        commonAlert.addAdditionalOkAction(isForSingleOption: false) {
//
//
//        }
//        commonAlert.addAdditionalCancelAction {
//            print("yes action")
//        }
        
    }
    
}


extension LoginVIew: UITextFieldDelegate {
    func checkButtonStatus(_ isFirsttime: Bool) {
        if isFirsttime {
            signUpbtn.alpha = 0.5
            signUpbtn.isUserInteractionEnabled = false
        }  else {
            if isEmailVerified &&  isPasswoordVerified {
                self.signUpbtn.alpha = 1
                self.signUpbtn.isUserInteractionEnabled = true
            } else {
                self.signUpbtn.alpha = 0.5
                self.signUpbtn.isUserInteractionEnabled = false
              
            }
        }
        

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.emailTF {
            self.resignFirstResponder()
          //  self.passwordTF.becomeFirstResponder()
            self.endEditing(true)
           
        } else if textField == self.passwordTF {
            self.endEditing(true)
            checkButtonStatus(false)
           
            self.resignFirstResponder()
          
        }
        isHideViewModified = false
        isShowViewModified = false
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.emailTF {
            guard let email = textField.text, !email.isEmpty else {
                
                return}
            if email.isValidMail {
                isEmailVerified = true
                checkButtonStatus(false)
            } else {
                self.loginVc.sceneDelegate?.createToastMessage("Enter Valid Email", isFromWishList: true)
                isEmailVerified = false
                checkButtonStatus(false)
            }
            
        }
       else if textField == self.passwordTF {
           guard let passwd = textField.text, !passwd.isEmpty else {
               
               return}
            if passwd.count>7 && passwd.containsSpecialCharacter {
                self.isPasswoordVerified = true
                passwordValidationLbl.isHidden = true
                checkButtonStatus(false)
            } else {
               // self.loginVc.sceneDelegate?.createToastMessage("Enter Valid password")
                passwordValidationLbl.isHidden = false
                self.isPasswoordVerified = false
                checkButtonStatus(false)
            }
            
        }
    }
    
    func toAnimate(_ toanimateView: UIView) {

    }
    
    
    @IBAction
    private func textFieldDidChange(textField: UITextField) {

        print("Edited")
    }
}
