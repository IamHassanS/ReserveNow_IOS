//
//  GetUserInfoView.swift
//  ReserveNow
//
//  Created by trioangle on 12/09/23.
//

import Foundation
import UIKit
import FirebaseAuth
extension GetUserInfoView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
}

enum validationTypes {
  case phone
  case email
  case socialLogin
}


class GetUserInfoView: BaseView {

    func tosetViewType (_ type: validationTypes) {
        switch type {
            
        case .phone:
            
            self.mailORphoneFld.placeholder = "Enter your Phone number"
            phoneORmailIV.image = UIImage(systemName:  "phone.fill")
        case .email:
            self.mailORphoneFld.placeholder = "Enter your E-mail"
            phoneORmailIV.image = UIImage(systemName:  "mail")
        case .socialLogin:
            self.mailORphoneFld.text = Global_UserProfile.emailID
            phoneORmailIV.image = UIImage(systemName:  "mail")
            self.fnameFld.text = Global_UserProfile.firstName
            self.lnameFld.text = Global_UserProfile.lastName
            self.isfnameVerified  = !Global_UserProfile.firstName.isEmpty ? true : false
            self.islnameVerified = !Global_UserProfile.lastName.isEmpty ? true : false
            self.isEmailVerified = !Global_UserProfile.emailID.isEmpty  ? true : false
           
        }
    }
    
    var getUserInfoVC: GetUserInfoVC!
    @IBOutlet weak var fnameView: UIView!
    @IBOutlet weak var lnameView: UIView!
    @IBOutlet weak var genderView: UIView!
    @IBOutlet weak var DOBView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var confirmPasswordView: UIView!
    @IBOutlet weak var btnNxt: UIButton!
    @IBOutlet weak var fnameFld: UITextField!
    @IBOutlet weak var lnameFld: UITextField!
    @IBOutlet weak var mailORphoneFld: UITextField!
    @IBOutlet weak var passwordFld: UITextField!
    @IBOutlet weak var retypePasswordFld: UITextField!
    @IBOutlet weak var errorLbl: UILabel!
    
    @IBOutlet weak var phoneORmailIV: UIImageView!
    // MARK: - variables
    var isfnameVerified = false
    var islnameVerified = false
    var isPasswordVerified = false
    var isRetypedPasswordVerified = false
    var isEmailVerified = false
    var isMobileVerifed = false
    var isTermsandConditionsVerified = false
    var validationType: validationTypes = .email
    var view = UIView()
    
    func setDelegates() {
        retypePasswordFld.delegate = self
        passwordFld.delegate = self
        mailORphoneFld.delegate = self
        lnameFld.delegate = self
        fnameFld.delegate = self
        retypePasswordFld.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordFld.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        mailORphoneFld.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        lnameFld.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        fnameFld.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        self.fnameFld.becomeFirstResponder()
    }
    
    
    override func didLoad(baseVC: BaseViewController) {
        super.didLoad(baseVC: baseVC)
        self.getUserInfoVC = baseVC as? GetUserInfoVC
        tosetViewType(self.getUserInfoVC.validate)
        setupUI()
        setDelegates()
        initView()
    }
    
    func setupUI() {
        
        checkButtonStatus(true)
        errorLbl.isHidden = true
        btnNxt.elevate(4)
        btnNxt.layer.cornerRadius = btnNxt.height / 2
        fnameView.elevate(4)
        lnameView.elevate(4)
        genderView.elevate(4)
        DOBView.elevate(4)
        passwordView.elevate(4)
        confirmPasswordView.elevate(4)
        
    }
    
    
    func initView() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction
    private func textFieldDidChange(textField: UITextField) {
        checkButtonStatus(true)
        if textField == fnameFld {
            guard let name = textField.text, !name.isEmpty else {
                errorLbl.isHidden = false
                errorLbl.text = "First name cannot be empty"
                return}
            if name.isValiduserName(Input: name) {
                errorLbl.isHidden = true
                self.isfnameVerified = true
                checkButtonStatus(false)
                
            } else {
                self.isfnameVerified = false
                checkButtonStatus(false)
            }
        } else if textField == lnameFld {
            guard let name = textField.text, !name.isEmpty else {
                errorLbl.isHidden = false
                errorLbl.text = "Last name cannot be empty"
                return}
            if name.isValiduserName(Input: name) {
                errorLbl.isHidden = true
                self.islnameVerified = true
                checkButtonStatus(false)
            } else {
                self.islnameVerified = false
                checkButtonStatus(false)
            }
        }  else if textField == mailORphoneFld {
            guard let email = textField.text, !email.isEmpty else {
                errorLbl.isHidden = false
                errorLbl.text = self.validationType == .phone  ? "phoneNumber cannot be empty" : "Email field cannot be empty"
                return}
            if self.validationType == .phone ? email.isValidPhoneNumber : email.isValidMail {
                if self.validationType == .phone {
                    self.isMobileVerifed = true
                    errorLbl.isHidden = true
                } else if self.validationType == .email {
                    self.isEmailVerified = true
                    errorLbl.isHidden = true
                }
                checkButtonStatus(false)
            } else {
                errorLbl.isHidden = false
                errorLbl.text =  self.validationType == .phone ? "Enter valid Phone number" : "Enter valid email"
                self.isEmailVerified = false
                self.isMobileVerifed = false
            }
        }       else if textField == self.passwordFld {
            guard let passwd = textField.text, !passwd.isEmpty else {
                
                return}
            if passwd.count>7 && passwd.containsSpecialCharacter {
                self.isPasswordVerified = true
                errorLbl.isHidden = true
                checkButtonStatus(false)
            } else {
                // self.loginVc.sceneDelegate?.createToastMessage("Enter Valid password")
                errorLbl.isHidden = false
                self.errorLbl.text = "Password should be alphanumeric, special character, min 8 char & max16, combination upper case."
                self.isPasswordVerified = false
                checkButtonStatus(false)
            }
            
        }   else if textField == self.retypePasswordFld {
            self.view = textField
            guard let passwd = passwordFld.text, !passwd.isEmpty else {
                errorLbl.isHidden = false
                self.errorLbl.text = "Fill password field first"
                return}
            if passwd == textField.text {
                self.isRetypedPasswordVerified = true
                errorLbl.isHidden = true
                checkButtonStatus(false)
            } else {
             
                errorLbl.isHidden = false
                self.errorLbl.text = "Password mismatch."
                self.isRetypedPasswordVerified = false
                checkButtonStatus(false)
            }
            
        }
    }
    
    //Show the keyboard
//    @objc
//    func keyboardWillShow(notification: NSNotification) {
//        let info = notification.userInfo!
//        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
//        Shared.instance.keyboardWillShowOrHideForView(keyboarHeight: keyboardFrame.size.height, btnView: self.fnameView)
//
//    }
    
    @objc
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.frame.origin.y == 0 {
                  self.frame.origin.y -= keyboardSize.height
              }
//     print("")
// }
          
        
        }
    }
    
    //Hide the keyboard
//    @objc
//    func keyboardWillHide1(notification: NSNotification) {
//        let info = notification.userInfo!
//        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
//        Shared.instance.keyboardWillShowOrHideForView(keyboarHeight: keyboardFrame.size.height, btnView: self.fnameView)
//    }
    
    @objc
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.frame.origin.y != 0 {
                      self.frame.origin.y = 0
                  }
    
        }
    }
    
    func checkButtonStatus(_ isFirsttime: Bool) {
        if isFirsttime {
            btnNxt.alpha = 0.5
            btnNxt.isUserInteractionEnabled = false
        } else if  self.isfnameVerified && self.islnameVerified && self.isPasswordVerified && self.isRetypedPasswordVerified &&  self.validationType == .email || self.validationType == .socialLogin ? self.isEmailVerified : self.isMobileVerifed {
            btnNxt.alpha = 1
            btnNxt.isUserInteractionEnabled = true
        } else {
            btnNxt.alpha = 0.5
            btnNxt.isUserInteractionEnabled = false
        }
    }
    
    @IBAction func didTapNxtbtn(_ sender: Any) {
        doUserSignUP()
    }
    
    func doUserSignUP() {

        guard let email = mailORphoneFld.text, !email.isEmpty, let password = passwordFld.text, !password.isEmpty else {
            return}
        Shared.instance.showLoader(in: self)
        if self.validationType == .phone ? email.isValidPhoneNumber : email.isValidMail {
            if self.validationType == .email ||   self.validationType == .socialLogin {
                
                FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) {[weak self] result, error in
                    guard let welf = self else {return}
                    Shared.instance.removeLoader(in: welf)
                    guard  error == nil else {
                        welf.createAccount(email, password)
                        return
                    }
                    self?.getUserInfoVC.sceneDelegate!.createToastMessage("Account creation failed", isFromWishList: true)
             
                }
                
            
            }
        } else {
       
        }
        
        
    }
    
    func createAccount(_ email: String, _ password: String) {

        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) {[weak self] result, error in
            guard let welf = self else {return}
            if  error == nil  {
                welf.getUserInfoVC.sceneDelegate!.createToastMessage("Account created successfully", isFromWishList: true)
                LocalStorage.shared.setBool(LocalStorage.LocalValue.isUserLoggedin, value: true)
                self?.getUserInfoVC.sceneDelegate?.generateMakentLoginFlowChange(tabIcon: 4)
                
                
            }
    
        }
        
        
    }
    
}
