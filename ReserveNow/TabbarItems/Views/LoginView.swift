//
//  LoginView.swift
//  ReserveNow
//
//  Created by trioangle on 03/08/23.
//

import Foundation
import UIKit
import FirebaseAuth

extension LoginVIew : CountryListVCDelegate {
    func countrySelected(_ selectedcode: String) {
        phoneCodeLbl.text = selectedcode
    }
    
    
}
class LoginVIew: BaseView {
    
    enum pageType {
        case login
        case mobienumber
        
        
    }
    
    func setPagetype(pageType: pageType) {
        switch pageType {
        case .login:
            self.pageType = .login
            self.mobileStack.isHidden = true
            self.credentialsStack.isHidden = false
            signUpbtn.setTitle("Login", for: .normal)
            self.passwordValidationLbl.text = "Password should be alphanumeric, special character, min 8 char & max16, combination upper case."
            self.signinLbl.text = "Sign up with mobile"
           // self.emailTF.becomeFirstResponder()
            
        case .mobienumber:
            self.pageType = .mobienumber
            self.mobileStack.isHidden = false
            self.credentialsStack.isHidden = true
            self.passwordValidationLbl.text = "Enter valid Mobile number"
            signUpbtn.setTitle("Send OTP", for: .normal)
           
            self.signinLbl.text = "Already have an Account? then sign in."
            //self.phoneNumberFld.becomeFirstResponder()
        }
    }
    
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var mobileSubEmailView: UIView!
    
    @IBOutlet weak var mobileSubPhoneView: UIView!
    @IBOutlet weak var mobileStack: UIStackView!
    @IBOutlet weak var credentialsStack: UIStackView!
    @IBOutlet weak var passwordValidationLbl: UILabel!
    @IBOutlet weak var signUpbtn: UIButton!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var signinLbl: UILabel!
    @IBOutlet weak var phoneNumberFld: UITextField!

    @IBOutlet weak var phoneCodeView: UIView!
    @IBOutlet weak var phoneCodeLbl: UILabel!
    
    var loginVc: LoginVC!
    var isPasswoordVerified = false
    var isEmailVerified = false
    var isMobileVerifed = false
    var isShowViewModified = Bool()
    var isHideViewModified = Bool()
    var pageType : pageType = .mobienumber
    override func didLoad(baseVC: BaseViewController) {
        super.didLoad(baseVC: baseVC)
        self.loginVc = baseVC as? LoginVC
        initData()
        setupUI()
        initNotifcations()
       
    }
    
    func  initData(){
        emailTF.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordTF.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        phoneNumberFld.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

        emailTF.delegate = self
        passwordTF.delegate = self
        phoneNumberFld.delegate = self
        signinLbl.addTap {
            self.setPagetype(pageType: self.pageType == .login ? .mobienumber : .login)
            self.signinLbl.text = self.pageType == .login ? "Sign up with mobile" : "Already have an Account? then sign in."
        }
        
        phoneCodeView.addTap {
            let vc = CountryListVC.initWithStory()
            vc.delegate = self
            vc.modalTransitionStyle = .coverVertical
            self.loginVc.navigationController?.present(vc, animated: true)
        }

    }


    
    
    func initNotifcations() {
 
//        NotificationEnum.UIKeyboardWillShowNotification.addObserver(self, selector: "keyboardWillShow:")
//        NotificationEnum.UIKeyboardWillHideNotification.addObserver(self, selector: "keyboardWillHide:")
        
     //   NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
    //    NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
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
 } else if phoneNumberFld.isFirstResponder && !isShowViewModified {
     isShowViewModified = true
     UIView.transition(with: mobileStack, duration: 0.33,
       options: [.curveEaseOut, .transitionFlipFromTop],
       animations: {
         self.mobileStack.frame = frame
       },
       completion: nil
     )

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
 } else if phoneNumberFld.isFirstResponder  && !isHideViewModified  {
     isHideViewModified = true
     UIView.transition(with: mobileStack, duration: 0.33,
       options: [.curveEaseOut, .transitionFlipFromBottom],
       animations: {
         self.mobileStack.frame = frame
       },
       completion: nil
     )
     print("")
 }
        }
    }
    
    func setupUI() {
        if  Shared.instance.selectedPhoneCode.isEmpty {
            self.phoneCodeLbl.text = "+91"
        } else {
            self.phoneCodeLbl.text = Shared.instance.selectedPhoneCode
        }
        checkButtonStatus(true)
        passwordValidationLbl.isHidden = true
        signUpbtn.elevate(4)
        signUpbtn.layer.cornerRadius = signUpbtn.height / 2
        credentialsStack.elevate(4)
        mobileSubEmailView.elevate(4)
        mobileSubPhoneView.elevate(4)
        mobileStack.isUserInteractionEnabled = true
        //passwordTF.isSecureTextEntry = true
        topView.setSpecificCornersForBottom(cornerRadius: 25)
      //  self.phoneNumberFld.keyboardType = .phonePad
        self.setPagetype(pageType: .mobienumber)
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
        commonAlert.setupAlert(alert: "App name", alertDescription: "Hello user otp will be sent to given mobile number", okAction: "Ok",cancelAction: "Cancel")
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
        if self.pageType == .mobienumber {
            guard let number = self.phoneNumberFld.text , !number.isEmpty else {return}
            let validNumStr = Shared.instance.selectedPhoneCode == "" ? "+91\(number)" :  "\(Shared.instance.selectedPhoneCode)\(number)"
            AuthManager.shared.authenticatePhoneNumber(number: validNumStr) { isValid in
               if isValid {
                    let otp = OTPValidationVC.initWithStory()
                   // otp.hidesBottomBarWhenPushed = true
                    self.loginVc.navigationController?.pushViewController(otp, animated: true)
                } else {
                    self.loginVc.sceneDelegate?.createToastMessage("Sorry an error occured please try again later.", isFromWishList: true)
                }
            }
        } else {
            let otp = OTPValidationVC.initWithStory()
           // otp.hidesBottomBarWhenPushed = true
            self.loginVc.navigationController?.pushViewController(otp, animated: true)
        }
        
     
        
     
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
    
    @IBAction
    private func textFieldDidChange(textField: UITextField) {
        if self.pageType == .login {
            if textField == self.emailTF {
                guard let email = textField.text, !email.isEmpty else {
                    
                    return}
                if email.isValidMail {
                    isEmailVerified = true
                    checkButtonStatus(false)
                } else {
                  //  self.loginVc.sceneDelegate?.createToastMessage("Enter Valid Email", isFromWishList: true)
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
        } else {
            if textField == self.phoneNumberFld {
                guard let phonenumber = textField.text, !phonenumber.isEmpty else {
                    
                    return}
                if phonenumber.isValidPhoneNumber {
                    self.isMobileVerifed = true
                    passwordValidationLbl.isHidden = true
                    checkButtonStatus(false)
                } else {
                    self.isMobileVerifed = false
                    passwordValidationLbl.isHidden = false
                    checkButtonStatus(false)
                }
                
            }
            
        }

    
}
    
}


extension LoginVIew: UITextFieldDelegate {
    func checkButtonStatus(_ isFirsttime: Bool) {
        if isFirsttime {
            signUpbtn.alpha = 0.5
            signUpbtn.isUserInteractionEnabled = false
        }  else if self.pageType == .login {
            if isEmailVerified &&  isPasswoordVerified {
                self.signUpbtn.alpha = 1
                self.signUpbtn.isUserInteractionEnabled = true
            } else {
                self.signUpbtn.alpha = 0.5
                self.signUpbtn.isUserInteractionEnabled = false
                
            }
        } else if self.pageType == .mobienumber {
            if isMobileVerifed {
                self.signUpbtn.alpha = 1
                self.signUpbtn.isUserInteractionEnabled = true
            } else {
                self.signUpbtn.alpha = 0.5
                self.signUpbtn.isUserInteractionEnabled = false
            }
        }
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if self.pageType == .login {
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
        } else {
            self.endEditing(true)
            self.resignFirstResponder()
            //    self.phoneNumberFld.becomeFirstResponder()
        }
        
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
    }
    

}
