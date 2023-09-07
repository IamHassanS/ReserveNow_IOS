//
//  AuthManager.swift
//  ReserveNow
//
//  Created by trioangle on 07/09/23.
//

import Foundation
import FirebaseAuth
class AuthManager {
  static  let shared = AuthManager()
    
    var id: String?
    
    func authenticatePhoneNumber(number: String, completion: @escaping (Bool) -> ()) {
        PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) { verificationID , error in
            guard let verificationID = verificationID, error == nil else {
                completion(false)
                return}
            self.id = verificationID
            completion(true)
        }
    }
    
    func validateOTP(OTPcode: String, completion: @escaping (Bool) -> ()) {
        guard let id = self.id else {
            completion(false)
            return}
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: id,
          verificationCode: OTPcode
        )
        Auth.auth().signIn(with: credential) { (authResult, error) in
            guard authResult != nil && error == nil else{
                completion(false)
                return}
            completion(true)
        }
    }
}
