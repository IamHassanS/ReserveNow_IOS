//
//  GetUserInfoView.swift
//  ReserveNow
//
//  Created by trioangle on 12/09/23.
//

import Foundation
import UIKit

extension GetUserInfoView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == fnameFld {
            checkButtonStatus(false)
            lnameFld.becomeFirstResponder()
        } else if textField == lnameFld {
            checkButtonStatus(false)
            passwordFld.becomeFirstResponder()
        } else if textField == passwordFld {
            checkButtonStatus(false)
            retypePasswordFld.becomeFirstResponder()
        } else if textField == retypePasswordFld {
            checkButtonStatus(false)
            self.endEditing(true)
            self.resignFirstResponder()
          
            
        }
        return true
    }
}

enum validationTypes {
  case phone
  case email
}


class GetUserInfoView: BaseView {

    func tosetViewType (_ type: validationTypes) {
        switch type {
            
        case .phone:
            self.mailORphoneFld.placeholder = "Enter your E-mail"
            phoneORmailIV.image = UIImage(systemName:  "mail")
        case .email:
            self.mailORphoneFld.placeholder = "Enter your Phone number"
            phoneORmailIV.image = UIImage(systemName:  "phone.fill")
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
            if self.validationType == .phone ? email.isValidMail : email.isValidPhoneNumber {
                if self.validationType == .phone {
                    self.isMobileVerifed = true
                } else if self.validationType == .email {
                    self.isEmailVerified = true
                }
                checkButtonStatus(false)
            } else {
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
            guard let passwd = textField.text, !passwd.isEmpty else {
                
                return}
            if passwd.count>7 && passwd.containsSpecialCharacter {
                self.isRetypedPasswordVerified = true
                errorLbl.isHidden = true
                checkButtonStatus(false)
            } else {
                // self.loginVc.sceneDelegate?.createToastMessage("Enter Valid password")
                errorLbl.isHidden = false
                self.errorLbl.text = "Password mismatch."
                self.isRetypedPasswordVerified = false
                checkButtonStatus(false)
            }
            
        }
    }
    
    func checkButtonStatus(_ isFirsttime: Bool) {
        if isFirsttime {
            btnNxt.alpha = 0.5
            btnNxt.isUserInteractionEnabled = false
        } else if  self.isfnameVerified && self.islnameVerified && self.isPasswordVerified && self.isRetypedPasswordVerified &&  self.validationType == .email ? self.isEmailVerified : self.isMobileVerifed {
            btnNxt.alpha = 1
            btnNxt.isUserInteractionEnabled = true
        } else {
            btnNxt.alpha = 0.5
            btnNxt.isUserInteractionEnabled = false
        }
    }
    
}
