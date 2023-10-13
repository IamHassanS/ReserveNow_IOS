//
//  LoginVC.swift
//  ReserveNow
//
//  Created by trioangle on 03/08/23.
//

import UIKit
import MobileCoreServices
import AuthenticationServices

class LoginVC: BaseViewController {
    @IBOutlet var loginView: LoginVIew!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    class func initWithStory() -> LoginVC {
        let loginVC : LoginVC = UIStoryboard.TabBarItems.instantiateViewController()
        return loginVC
    }

    func chooseDocs() {
        let types = ["com.microsoft.word.doc","org.openxmlformats.wordprocessingml.document", kUTTypePDF as String]
//        ["com.adobe.pdf",
//                   "com.microsoft.word.doc",
//                    "com.microsoft.word.docx"
//                   ]
        //["com.microsoft.word.doc","org.openxmlformats.wordprocessingml.document", kUTTypePDF as String]
        let documentPicker = UIDocumentPickerViewController(documentTypes: types as [String], in: .import)
            documentPicker.delegate = self
            documentPicker.allowsMultipleSelection = true
        self.presentInFullScreen(documentPicker, animated: true, completion: nil)
    }

}


    
    extension LoginVC: UIDocumentMenuDelegate,UIDocumentPickerDelegate {
        public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let myURL = urls.first else {
                return
            }
           // self.documentURL = myURL
            print("import result : \(myURL)")

            
    //        let extens = NSURL(fileURLWithPath: "\(myURL)").pathExtension
    //        let uti = UTTypeCreatePreferredIdentifierForTag(
    //            kUTTagClassFilenameExtension,
    //            extens! as CFString,
    //            nil)
    //
    //        if UTTypeConformsTo((uti?.takeRetainedValue())!, kUTTypePDF) {
    //            print("This is an PDF")
    //        //    uploadRoomDocs(docurl: myURL, ispdf: true)
    //            uploadRoomImage(displayPic: UIImage(), docurl: myURL)
    //        } else {
    //
    //
    //        }
          //  uploadRoomImage(displayPic: UIImage(), docurl: myURL)
            
            
        
        
         //   uploadRoomImage(displayPic: UIImage(), docurl: myURL)
        }
              

        public func documentMenu(_ documentMenu:UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
            documentPicker.delegate = self
            present(documentPicker, animated: true, completion: nil)
        }


        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            print("view was cancelled")
            dismiss(animated: true, completion: nil)
        }
        
        
    }

extension LoginVC : ASAuthorizationControllerDelegate {
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    }
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // Create an account in your system.
            // For the purpose of this demo app, store the these details in the keychain.
            self.handleAppleData(forSuccess: appleIDCredential)
            //Show Home View Controller
        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            print(username,password,
                  separator: "|",
                  terminator: ".")
            // For the purpose of this demo app, show the password credential as an alert.
        }
    }
    
    @available(iOS 13.0, *)
    func handleAppleData(forSuccess appleIDCredential : ASAuthorizationAppleIDCredential){
        let email : String?
        if let appleEmail = appleIDCredential.email {
            email = appleEmail
            KeychainItem.currentUserEmail = appleEmail
        }else{
            email = KeychainItem.currentUserEmail
        }
        var userData = [String : Any]()
        if let fullName = appleIDCredential.fullName,
           let givenName = fullName.givenName,
           let familyName = fullName.familyName{
            userData["first_name"] = givenName
            userData["last_name"] = familyName
            KeychainItem.currentUserFirstName = givenName
            KeychainItem.currentUserLastName = familyName
        }else{
            userData["first_name"] = KeychainItem.currentUserFirstName
            userData["last_name"] = KeychainItem.currentUserLastName
        }
        guard let validEmai = email else {
            self.sceneDelegate?.createToastMessage("Login error")
            return
        }
        userData["email"] = validEmai
//        self.checkSocialMediaId(userData: userData,
//                                signUpType: .apple(id: appleIDCredential.user,
//                                                   email: validEmai))
        if let identityTokenData = appleIDCredential.identityToken,
           let identityTokenString = String(data: identityTokenData, encoding: .utf8) {
            debug(print: "Identity Token \(identityTokenString)")
        }
    }
}
extension LoginVC : ASAuthorizationControllerPresentationContextProviding {
    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
