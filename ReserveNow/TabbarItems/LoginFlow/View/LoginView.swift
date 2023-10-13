//
//  LoginView.swift
//  ReserveNow
//
//  Created by trioangle on 03/08/23.
//

import Foundation
import UIKit
//import FirebaseAuth
//import GoogleSignIn
//import FBSDKLoginKit
import AuthenticationServices

extension LoginVIew : CountryListVCDelegate {
    func countrySelected(_ selectedcode: String) {
        phoneCodeLbl.text = selectedcode
    }
    
     
}
class LoginVIew: BaseView {
    

    // MARK: - Outlets
    
    //MARK: Common
    @IBOutlet weak var backHolderView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var contentHolderVIew: UIView!
    @IBOutlet weak var googleView: UIView!
    @IBOutlet weak var appleView: UIView!
    @IBOutlet weak var facebookview: UIView!
    @IBOutlet weak var passwordValidationLbl: UILabel!
    @IBOutlet weak var signUpbtn: UIButton!
    @IBOutlet weak var signinLbl: UILabel!
    @IBOutlet weak var welcombackLbl: UILabel!
    
    @IBOutlet weak var appLogoIV: UIView!
    
    
    //MARK: - OTP Flow Signup
    @IBOutlet weak var mobileStack: UIStackView!
    @IBOutlet weak var phoneCodeView: UIView!
    @IBOutlet weak var phoneCodeLbl: UILabel!
    @IBOutlet weak var orView: UIView!
    @IBOutlet weak var signUpEmailTF: UITextField!
    @IBOutlet weak var mobileSubPhoneView: UIView!
    @IBOutlet weak var mobileSubEmailView: UIView!
    @IBOutlet weak var phoneNumberFld: UITextField!
    
    //MARK: - LOGIN FLOW
    @IBOutlet weak var credentialsStack: UIStackView!
    @IBOutlet weak var loginEmailorUsernameView: UIView!
    @IBOutlet weak var loginPasswordView: UIView!
    @IBOutlet weak var shoeHidePasswordView: UIView!
    @IBOutlet weak var showPasswordHolderIV: UIImageView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var closeholderView: UIView!
    
    @IBOutlet weak var serviceTilePageControl: UIPageControl!
    
    //MARK: - Collection VIew
    @IBOutlet weak var collectionViewExplore: UICollectionView!
    
  
    // MARK: - Properties

    var loginVc: LoginVC!
    var isPasswoordVerified = false
    var isEmailVerified = false
    var isMobileVerifed = false
    var isSignupEmailVerified = false
    var isShowViewModified = Bool()
    var isHideViewModified = Bool()
    var pageType : pageType = .login
    var userState = Bool()
    var email = ""
    let facebookReadPermissions = ["public_profile",
                                   "email"]
    var data = [String]()
    private var indexOfCellBeforeDragging = 0
    var index: Int = 0
    lazy var toolBar : UIToolbar = {
        let tool = UIToolbar(frame: CGRect(origin: CGPoint.zero,
                                              size: CGSize(width: self.frame.width,
                                                           height: 30)))
        let done = UIBarButtonItem(barButtonSystemItem: .done,
                                   target: self,
                                   action: #selector(self.doneAction))
        tool.setItems([done], animated: true)
        tool.sizeToFit()
        return tool
    }()
    
    
    //MARK: - View LIfe cycle
    
    override func didLoad(baseVC: BaseViewController) {
        super.didLoad(baseVC: baseVC)
        self.loginVc = baseVC as? LoginVC
        initData()
        setupUI()
        cellregistration()
        toLOadData()
        initNotifcations()
       
    }
    override func didLayoutSubviews(baseVC: BaseViewController) {
        self.collectionViewExplore.layoutIfNeeded()
       // self.collectionViewExplore.centerContentHorizontalyByInsetIfNeeded(minimumInset: UIEdgeInsets.init(top: 8, left: 15, bottom: 8, right: 15))
    }

    
    
    func toLOadData() {
        for i in 0...2 {
            data.append("\(i)")
        }
        self.collectionViewExplore.dataSource = self
        self.collectionViewExplore.delegate = self
        self.collectionViewExplore.reloadData()
        if self.data.count > 2 {
            let indexPath = IndexPath(row: 1, section: 0)
            collectionViewExplore.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            serviceTilePageControl.numberOfPages = self.data.count
        }
    }
    
    func cellregistration() {
        self.collectionViewExplore.register(UINib.init(nibName: "LoginImageCVC", bundle: nil), forCellWithReuseIdentifier: "LoginImageCVC")
    }
    
    
    // MARK: - set pagination for collection view
    private func calculateSectionInset() -> CGFloat {
        let deviceIsIpad = UIDevice.current.userInterfaceIdiom == .pad
        let deviceOrientationIsLandscape = UIDevice.current.orientation.isLandscape
        let cellBodyViewIsExpended = deviceIsIpad || deviceOrientationIsLandscape
        let cellBodyWidth: CGFloat =  (self.collectionViewExplore.frame.size.width/1.12) + (cellBodyViewIsExpended ? 174 : 0)
        
   //     let buttonWidth: CGFloat = 50
        
        let inset = (collectionViewExplore.frame.width - cellBodyWidth) / 5
        return inset
    }
    
    private func indexOfMajorCell() -> Int {
        
        let inset: CGFloat =  calculateSectionInset()
        let itemWidth = (self.collectionViewExplore.frame.size.width/1.12) - inset * 2
        //
        let proportionalOffset = collectionViewExplore.contentOffset.x / itemWidth
        //let index = Int(round(proportionalOffset))
  
        var index: Int = 0
    
      
           // proportionalOffset = proportionalOffset - 0.5
     
            index = Int(proportionalOffset.rounded(.up))
      
       
        let safeIndex = max(0, min(data.count - 1, index))
        return safeIndex
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if let collect = scrollView as? UICollectionView {
            if collect == self.collectionViewExplore {
               // self.isForCategory = false
                indexOfCellBeforeDragging = indexOfMajorCell()
            }
        }
    }
        
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView == scrollView as? UICollectionView {
            if scrollView == self.collectionViewExplore {
                // Stop scrollView sliding:
                targetContentOffset.pointee = scrollView.contentOffset
                
                // calculate where scrollView should snap to:
                let indexOfMajorCell = self.indexOfMajorCell()
                
                // calculate conditions:
                let swipeVelocityThreshold: CGFloat = 1 // after some trail and error
                let hasEnoughVelocityToSlideToTheNextCell = indexOfCellBeforeDragging + 1 < data.count && velocity.x > swipeVelocityThreshold
                if indexOfCellBeforeDragging == 12 {
                    
                }
                let hasEnoughVelocityToSlideToThePreviousCell = indexOfCellBeforeDragging - 1 >= 0 && velocity.x < -swipeVelocityThreshold
                let majorCellIsTheCellBeforeDragging = indexOfMajorCell == indexOfCellBeforeDragging
                let didUseSwipeToSkipCell = majorCellIsTheCellBeforeDragging && (hasEnoughVelocityToSlideToTheNextCell || hasEnoughVelocityToSlideToThePreviousCell)
                
                if didUseSwipeToSkipCell {
                    
                    let snapToIndex = indexOfCellBeforeDragging + (hasEnoughVelocityToSlideToTheNextCell ? 1 : -1)
                    let inset: CGFloat = calculateSectionInset()
                    let itemWidth =  collectionViewExplore.frame.size.width - inset * 2
                    let toValue = itemWidth * CGFloat(snapToIndex)
                    
                    print(snapToIndex)
                    let indexPath = IndexPath(row: snapToIndex, section: 0)
                    self.collectionViewExplore.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                    
                    // Damping equal 1 => no oscillations => decay animation:
                    //                    UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: velocity.x, options: .allowUserInteraction, animations: {
                    //                        scrollView.contentOffset = CGPoint(x: toValue, y: 0)
                    //                        scrollView.layoutIfNeeded()
                    //                    }, completion: nil)
                    
                } else {
                    // This is a much better way to scroll to a cell:
                    
                    //  index = index + 1
                    let celltoScroll: Int = indexOfMajorCell
                    // print(exploreData.data[celltoScroll])
                    let indexPath = IndexPath(row: celltoScroll, section: 0)
                    self.collectionViewExplore.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                }
            }
        }
    }
    
    // MARK: - Functionalities for Setting up view UI
    
    func setupUI() {
        if let layout = self.collectionViewExplore.collectionViewLayout as? UICollectionViewFlowLayout {

            layout.scrollDirection = .horizontal

        }
        self.collectionViewExplore.showsHorizontalScrollIndicator = false
        appLogoIV.elevate(4)
        appLogoIV.layer.cornerRadius = 20
        closeholderView.elevate(4)
        closeholderView.layer.cornerRadius = closeholderView.height / 2
        googleView.elevate(4)
        appleView.elevate(4)
        facebookview.elevate(4)
        loginPasswordView.layer.cornerRadius =  loginPasswordView.height / 2
        loginPasswordView.elevate(4)
        loginEmailorUsernameView.layer.cornerRadius =  loginPasswordView.height / 2
        loginEmailorUsernameView.elevate(4)
        mobileSubEmailView.elevate(4)
        mobileSubEmailView.layer.cornerRadius =  loginPasswordView.height / 2
        mobileSubPhoneView.elevate(4)
        mobileSubPhoneView.layer.cornerRadius =  loginPasswordView.height / 2
        if  Shared.instance.selectedPhoneCode.isEmpty {
            self.phoneCodeLbl.text = "+91"
        } else {
            self.phoneCodeLbl.text = Shared.instance.selectedPhoneCode
        }
        checkButtonStatus(true)
        passwordValidationLbl.isHidden = true
        signUpbtn.elevate(4)
        signUpbtn.layer.cornerRadius = signUpbtn.height / 2
   
        mobileStack.isUserInteractionEnabled = true
        topView.setSpecificCornersForBottom(cornerRadius: 25)
        
       
    }
    
    
    // MARK: - Functionalities for Setting up pagetypes
    
    enum pageType {
        case login
        case signup
        case email
        case phone
        case def
        
    }
    
    func setPagetype(pageType: pageType) {
        switch pageType {
        case .login:
            self.pageType = .login
            self.mobileStack.isHidden = true
            self.credentialsStack.isHidden = false
            signUpbtn.setTitle("Login", for: .normal)
            self.passwordValidationLbl.text = "Password should be alphanumeric, special character, min 8 char & max16, combination upper case."
            welcombackLbl.text = "Welcome back"
            self.signinLbl.isHidden = false
            self.signinLbl.text = "Sign up with mobile"
            self.backHolderView.isHidden = true
           // self.emailTF.becomeFirstResponder()
            
        case .signup:
            welcombackLbl.text = "Signup"
            self.pageType = .signup
            self.mobileStack.isHidden = false
            self.credentialsStack.isHidden = true
//            mobileSubEmailView.isHidden = false
//            mobileSubPhoneView.isHidden = false
//            orView.isHidden = false
            signUpbtn.setTitle("Send OTP", for: .normal)
            backHolderView.isHidden = true
           
        case .email:
            self.pageType = .email
            self.mobileStack.isHidden = false
            self.credentialsStack.isHidden = true
            mobileSubEmailView.isHidden = false
            mobileSubPhoneView.isHidden = true
            self.passwordValidationLbl.text = "Enter valid Email"
            signUpbtn.setTitle("Send OTP", for: .normal)
            orView.isHidden = true
            self.signinLbl.text = "Already have an Account? then sign in."
          //  backHolderView.isHidden = false
            backHolderView.isHidden = true
            self.signUpEmailTF.becomeFirstResponder()
        case .phone:
            self.pageType = .phone
            self.mobileStack.isHidden = false
            self.credentialsStack.isHidden = true
            mobileSubEmailView.isHidden = true
            mobileSubPhoneView.isHidden = false
            orView.isHidden = true
            self.passwordValidationLbl.text = "Enter valid Mobile number"
            signUpbtn.setTitle("Send OTP", for: .normal)
            self.signinLbl.text = "Already have an Account? then sign in."
            self.phoneNumberFld.becomeFirstResponder()
            backHolderView.isHidden = true
         //   backHolderView.isHidden = false
        case .def:
            self.pageType = .signup
            self.mobileStack.isHidden = false
            self.credentialsStack.isHidden = true
            mobileSubEmailView.isHidden = false
            mobileSubPhoneView.isHidden = false
            orView.isHidden = false
            signUpbtn.setTitle("Send OTP", for: .normal)
            backHolderView.isHidden = true
        }
    }
    
    @objc func doneAction(){
        isHideViewModified = false
        isShowViewModified = false
        self.endEditing(true)
        self.checkButtonStatus(false)
    }
    
    func  initData(){
        emailTF.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordTF.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        phoneNumberFld.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        signUpEmailTF.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        emailTF.delegate = self
        passwordTF.delegate = self
        phoneNumberFld.delegate = self
        signUpEmailTF.delegate = self
        phoneNumberFld.keyboardType = .numberPad
        setToolBar(self.toolBar)
        let state = !LocalStorage.shared.getBool(key: LocalStorage.LocalValue.isUserLoggedin)
        self.userState = state
        signinLbl.isHidden = state
        self.setPagetype(pageType: state == true ? .login : .signup)
        signinLbl.addTap {
            self.setPagetype(pageType: self.pageType == .login ? .signup : .login)
            self.signinLbl.text = self.pageType == .login ? "Sign up with mobile" : "Already have an Account? then sign in."
            self.passwordValidationLbl.text = ""
        }
        
        closeholderView.addTap {
            self.loginVc.sceneDelegate?.setTabbarForSwithUsers()
        }
        

        phoneCodeView.addTap {
            let vc = CountryListVC.initWithStory()
            vc.delegate = self
            vc.modalTransitionStyle = .coverVertical
            self.loginVc.navigationController?.present(vc, animated: true)
        }
        phoneNumberFld.addTap {
            self.setPagetype(pageType: .phone)
        }
        signUpEmailTF.addTap {
            self.setPagetype(pageType: .email)
        }
        
        backHolderView.addTap {
            self.setPagetype(pageType: .def)
        }
        shoeHidePasswordView.addTap {
            self.showPasswordHolderIV.image =  self.showPasswordHolderIV.image == UIImage(systemName: "eye") ?  UIImage(systemName: "eye.slash.fill") : UIImage(systemName: "eye")
            self.passwordTF.isSecureTextEntry = self.showPasswordHolderIV.image == UIImage(systemName: "eye.slash.fill") ? true : false
            
        }
        googleView.addTap {
           // self.doGoogleLogin()
        }
        appleView.addTap {
            self.handleLogInWithAppleIDButtonPress()
        }

    }

    func setToolBar(_ bar : UIToolbar){
        self.phoneNumberFld.inputAccessoryView = bar
        self.emailTF.inputAccessoryView = bar
        passwordTF.inputAccessoryView = bar
        signUpEmailTF.inputAccessoryView = bar
    }
    
    
    func initNotifcations() {
 
//        NotificationEnum.UIKeyboardWillShowNotification.addObserver(self, selector: "keyboardWillShow:")
//        NotificationEnum.UIKeyboardWillHideNotification.addObserver(self, selector: "keyboardWillHide:")
        
       // NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
      //  NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    deinit {
        NotificationEnum.removeobserver.removeAll(self)
    }
    
    @objc
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            //let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
           
//            var frame = self.credentialsStack.frame
//            frame.origin.y -= keyboardSize.height / 2
//            //keyboardSize.height / 2
// if emailTF.isFirstResponder && !isShowViewModified {
//     isShowViewModified = true
//     UIView.transition(with: credentialsStack, duration: 0.33,
//       options: [.curveEaseOut],
//                       //, .transitionFlipFromTop
//       animations: {
//         self.credentialsStack.frame = frame
//
//         self.contentHolderVIew.backgroundColor = .black.withAlphaComponent(0.5)
//         self.credentialsStack.alpha = 1
//
//       },
//       completion: nil
//     )
//     print("")
// } else if passwordTF.isFirstResponder && !isShowViewModified  {
//     isShowViewModified = true
     UIView.transition(with: credentialsStack, duration: 0.33,
       options: [.curveEaseOut],
                 //, .transitionFlipFromTop]
       animations: {
         if self.frame.origin.y == 0 {
               self.frame.origin.y -= keyboardSize.height
           }
         self.contentHolderVIew.backgroundColor = .black.withAlphaComponent(0.5)
         self.credentialsStack.alpha = 1
       },
       completion: nil
     )
//     print("")
// }
          
        
        }
    }
    
    @objc
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            var frame = self.credentialsStack.frame
//            frame.origin.y += keyboardSize.height / 2
// if emailTF.isFirstResponder && !isHideViewModified {
//     isHideViewModified = true
//     UIView.transition(with: credentialsStack, duration: 0.33,
//       options: [.curveEaseOut],
//                       //, .transitionFlipFromBottom
//       animations: {
//         self.credentialsStack.frame = frame
//         self.contentHolderVIew.backgroundColor = .white
//       },
//       completion: nil
//     )
//
//     print("")
// } else if passwordTF.isFirstResponder && !isHideViewModified  {
//     isHideViewModified = true
     UIView.transition(with: credentialsStack, duration: 0.33,
       options: [.curveEaseOut],
       animations: {
         //, .transitionFlipFromBottom
         if self.frame.origin.y != 0 {
                   self.frame.origin.y = 0
               }
         self.contentHolderVIew.backgroundColor = .white
       },
       completion: nil
     )
//     print("")
// }
    
        }
    }
    

    
    @IBAction func didTapLoginBtn(_ sender: Any) {
        
        if self.pageType == .login {
            // !userState &&
            Shared.instance.showLoader(in: self)
            let email = self.emailTF.text!
            let password = self.passwordTF.text!
//            FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) {success , failure in
//                Shared.instance.removeLoader(in: self)
//                if failure == nil {
//                    LocalStorage.shared.setBool(LocalStorage.LocalValue.isUserLoggedin, value: true)
//
//                    let vc = UserInfoVC.initWithStory()
//                    vc.hidesBottomBarWhenPushed = false
//                    self.loginVc.navigationController?.pushViewController(vc, animated: true)
//                }
//            }
            let vc = ExploreVC.initWithStory()
            vc.hidesBottomBarWhenPushed = true
            self.loginVc.navigationController?.pushViewController(vc, animated: true)
            
            }
        else if self.pageType == .signup || self.pageType == .phone  {
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
        }


    }
    
    func callOTPPage() {
        if self.pageType == .signup  || self.pageType == .phone {
            guard let number = self.phoneNumberFld.text , !number.isEmpty else {return}
            Shared.instance.showLoader(in: self)
            let validNumStr = Shared.instance.selectedPhoneCode == "" ? "+91\(number)" :  "\(Shared.instance.selectedPhoneCode)\(number)"
//            AuthManager.shared.authenticatePhoneNumber(number: validNumStr) { isValid in
//                Shared.instance.removeLoader(in: self)
//               if isValid {
//                    let otp = OTPValidationVC.initWithStory()
//                   // otp.hidesBottomBarWhenPushed = true
//                    self.loginVc.navigationController?.pushViewController(otp, animated: true)
//                } else {
//                    self.loginVc.sceneDelegate?.createToastMessage("Sorry an error occured please try again later.", isFromWishList: true)
//                }
//            }
            
            let otp = OTPValidationVC.initWithStory()
           // otp.hidesBottomBarWhenPushed = true
            self.loginVc.navigationController?.pushViewController(otp, animated: true)
        } else {
            let otp = GetUserInfoVC.initWithStory(.email)
           // otp.hidesBottomBarWhenPushed = true
            self.loginVc.navigationController?.pushViewController(otp, animated: true)
        }
        
     
        
     
    }
    
    
    

    
    @IBAction
    private func textFieldDidChange(textField: UITextField) {
        if self.pageType == .login {
            if textField == self.emailTF {
                guard let email = textField.text, !email.isEmpty else {
                    
                    return}
                if email.isValidMail {
                    isEmailVerified = true
                    passwordValidationLbl.isHidden = true
                    passwordValidationLbl.text = ""
                    checkButtonStatus(false)
                } else {
                  //  self.loginVc.sceneDelegate?.createToastMessage("Enter Valid Email", isFromWishList: true)
                    passwordValidationLbl.isHidden = false
                    passwordValidationLbl.text = "Please enter valid email"
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
                    passwordValidationLbl.text = "Password should be alphanumeric, special character, min 8 char & max16, combination upper case."
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
                
            } else if textField == self.signUpEmailTF {
                guard let email = textField.text, !email.isEmpty else {
                    
                    return}
                if email.isValidMail {
                    self.isSignupEmailVerified = true
                    passwordValidationLbl.isHidden = true
                    checkButtonStatus(false)
                } else {
                    self.isSignupEmailVerified = false
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
        } else if self.pageType == .phone {
            if isMobileVerifed {
                self.signUpbtn.alpha = 1
                self.signUpbtn.isUserInteractionEnabled = true
            } else {
                self.signUpbtn.alpha = 0.5
                self.signUpbtn.isUserInteractionEnabled = false
            }
        } else  if self.pageType == .email {
            if isSignupEmailVerified {
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

extension LoginVIew {
    
    //MARK: Google Login
//    func doGoogleLogin() {
//        guard  let googlePlist = PlistReader<GooglePlistKeys>(),
//               let clinetId : String = googlePlist.value(for: .clientId) else {
//                   print("Google Client ID Missing")
//                   return }
//        SocialLoginsHandler.shared.doGoogleLogin(VC: self.loginVc,
//                                                 clientID: clinetId) { result in
//            switch result {
//            case .success(let user):
//                print("\(user.accessToken)")
//                Global_UserProfile = UserProfileDataModel()
//                if let userID = user.userID,
//                   let profile = user.profile {
//
//                    Global_UserProfile.firstName = profile.givenName ?? ""
//                    Global_UserProfile.lastName =  profile.familyName ?? ""
//                    Global_UserProfile.emailID = profile.email
//
//
//                    let givenName = profile.givenName
//                    let familyName = profile.familyName
//                    let email = profile.email
//                    var dicts = [String: Any]()
//                    dicts["email"] = email
//                    self.email = email
//                    //self.loginVC.auth_type = "google"
//                   // self.loginVC.auth_id = user.userID ?? ""
//                    dicts["name"] = givenName! + familyName!
//                    dicts["provider"] =  "google"
//                    dicts["auth_type"] = "google"
//                    dicts["auth_id"] = user.userID
//                    if SocialLoginsHandler.shared.doGoogleHasProfile() {
//                        let dimension = round(120 * UIScreen.main.scale)
//                        let imageURL = profile.imageURL(withDimension: UInt(dimension))
//                        dicts["avatar_original"] = imageURL?.absoluteString
//                        Global_UserProfile.userImage = imageURL?.absoluteString ?? ""
//                    }
////                    self.loginVC.checkSocialMediaId(userData: dicts,
////                                                           signUpType: .google(id: userID))
//                    let vc = GetUserInfoVC.initWithStory(.socialLogin)
//
//                    self.loginVc.navigationController?.pushViewController(vc, animated: true)
//
//                } else {
//                    print("Data Missing")
//                }
//            case .failure(let error):
//                print(error)
//                self.loginVc.sceneDelegate?.createToastMessage(error.localizedDescription, isFromWishList: true)
//            }
//        }
//    }

    //MARK: Apple Login
    func handleLogInWithAppleIDButtonPress() {
        guard #available(iOS 13.0, *) else{return}
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self.loginVc
        authorizationController.presentationContextProvider = self.loginVc
        authorizationController.performRequests()
    }


    //MARK: Facebook Login
//    func doFacebookLogin() {
//        SocialLoginsHandler.shared.doFacebookLogin(permissions: self.facebookReadPermissions,
//                                                   ViewController: self.loginVc) { result in
//            switch result {
//            case .success(let fbResult):
//                if fbResult.doFacebookImagePermissionCheck() {
//                    let width = 1024
//                    let height = width
//                    SocialLoginsHandler.shared.doGetFacebookUserDetails(graphPath: "me",
//                                                                        parameters: ["fields": "id, name, first_name, last_name, birthday, email, picture.width(\(width)).height(\(height))"]) { response in
//                        switch response {
//                        case .success(let facebookResult):
//                            debug(print: "facebookResult : \(facebookResult.userDetails)")
//                            let userdetails = facebookResult.userDetails
//                            let email = userdetails.string("email")
//                            let firstName = userdetails.string("first_name")
//                            let lastName = userdetails.string("last_name")
//                            let fbID = userdetails.int("id")
//                            let fbImage = ((userdetails["picture"]as? JSON)?["data"] as? JSON)?.string("url")
////                            Constants().STOREVALUE(value: facebookResult.accessToken,
////                                                   keyname: CEO_FacebookAccessToken)
////                            // Store Details
////                            Constants().STOREVALUE(value: firstName,
////                                                   keyname: USER_FIRST_NAME)
////                            Constants().STOREVALUE(value: lastName,
////                                                   keyname: USER_LAST_NAME)
////                            Constants().STOREVALUE(value: fbID.description,
////                                                   keyname: USER_FB_ID)
////                            Constants().STOREVALUE(value: fbImage ?? "",
////                                                   keyname: USER_IMAGE_THUMB)
//                            let dict : [String : Any] = ["email" : email,
//                                                         "name" : firstName + lastName,
//                                                         "provider" : "facebook",
//                                                         "avatar_original" : fbImage ?? "",
//                                                         "auth_type": "facebook",
//                                                    ]
////                            self.loginVc.checkSocialMediaId(userData: dict,
////                                                                   signUpType: .facebook(id: fbID.description))
//                            SocialLoginsHandler.shared.doFacebookLogout()
//                        case .failure(let error):
//                            SocialLoginsHandler.shared.doFacebookLogout()
//                            self.loginVc.sceneDelegate?.createToastMessage(error.localizedDescription, isFromWishList: true)
//                        }
//                    }
//                }
//            case .failure(let error):
//                SocialLoginsHandler.shared.doFacebookLogout()
//                self.loginVc.sceneDelegate?.createToastMessage(error.localizedDescription, isFromWishList: true)
//            }
//        }
//    }

}


        extension LoginVIew : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
            func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                return data.count
            }
            func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
              
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoginImageCVC", for: indexPath) as! LoginImageCVC
                    
                   // cell.viewBg.elevate(4)
                cell.contentHolderView.elevate(4)
                cell.contentHolderView.layer.cornerRadius = 12
                cell.imageHolderVIew.layer.cornerRadius =  cell.imageHolderVIew.height / 2
                cell.imageIV.layer.cornerRadius =  cell.imageIV.height / 2
                cell.gradientView.setSpecificCornersForBottom(cornerRadius: 12)
               // cell.gradientView.setGradient()
                    return cell
              
            }
            
            func collectionView(_ collectionView: UICollectionView,
                                layout collectionViewLayout: UICollectionViewLayout,
                                sizeForItemAt indexPath: IndexPath) -> CGSize {
                   return CGSize.init(width: (self.collectionViewExplore.frame.size.width/1.12), height: collectionViewExplore.height - 10)
                   //288
                   //self.view.frame.size.height * 0.365
               
            }
            
            func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
                UIView.animate(withDuration: 0.5) {
                    if collectionView == self.collectionViewExplore{
                        if let cell = collectionView.cellForItem(at: indexPath) as? RestaurantsCVC {
                            cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                        }
                    }
                }
            }
            
            
            func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
                UIView.animate(withDuration: 0.5) {
                    if collectionView == self.collectionViewExplore{
                        if let cell = collectionView.cellForItem(at: indexPath) as? RestaurantsCVC {
                            cell.transform = CGAffineTransform(scaleX: 1, y: 1)

                        }
                   }
                }
            }
            
            
        }


extension LoginVIew: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let collect = scrollView as? UICollectionView {
            if collect == self.collectionViewExplore {
                let visibleRect = CGRect(origin: self.collectionViewExplore.contentOffset, size: self.collectionViewExplore.bounds.size)
                let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
                if let visibleIndexPath = self.collectionViewExplore.indexPathForItem(at: visiblePoint) {
                    self.serviceTilePageControl.currentPage = visibleIndexPath.row
                }
            }
        }
        
    }
}
