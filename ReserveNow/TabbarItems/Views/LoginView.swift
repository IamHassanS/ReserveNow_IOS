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
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    var loginVc: LoginVC!

    
    override func didLoad(baseVC: BaseViewController) {
        
        
        super.didLoad(baseVC: baseVC)
        self.loginVc = baseVC as? LoginVC
        setupUI()
    }
    func setupUI() {
        topView.setSpecificCornersForBottom(cornerRadius: 25)
    }
    
    @IBAction func didTapLoginBtn(_ sender: Any) {
        guard let email = emailTF.text, !email.isEmpty , let password = passwordTF.text, !password.isEmpty else {return}
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) {[weak self] result, error in
            guard let welf = self else {return}
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
            guard  error == nil else {
                //Create Account
                welf.createAccount(email, password)
                return
            }
            self?.loginVc.sceneDelegate.createToastMessage("Account created failed")
         //   appdelegate.createToastMessage("Account created failed")
        }
    }
    
    func createAccount(_ email: String, _ password: String) {
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) {[weak self] result, error in
            guard let welf = self else {return}
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
            guard  error == nil else {
                self?.loginVc.sceneDelegate.createToastMessage("Account created successfully")
          //      appdelegate.createToastMessage("Account created successfully")
                return
            }
            self?.loginVc.sceneDelegate.createToastMessage("Account created successfully")
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
