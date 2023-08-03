//
//  AppDelegate.swift
//  ReserveNow
//
//  Created by trioangle on 18/04/23.
//

import UIKit
import CoreData
import Firebase
import FirebaseMessaging
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?
    let makentTabBarCtrler = MainTabBarVC()
    static var shared : AppDelegate{
        return UIApplication.shared.delegate as! AppDelegate
    }
    var pushNotificationHanlder : PushNotificationHandler?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       // FirebaseApp.configure()
        self.window = UIWindow(frame:UIScreen.main.bounds)
      //  self.initializeObjects(for: application, usingOptions: launchOptions)
    //    self.initializeModules()
       // self.makeSplashView(isFirstTime: true)
       // setTabbarForSwithUsers()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, willEncodeRestorableStateWith coder: NSCoder) {
        self.pushNotificationHanlder?.regiserForRemoteNotification()
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "ReserveNow")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}


//MARK: - Toast Creation
extension AppDelegate {
    /// Display Toast Message

    func createToastMessage(_ strMessage:String, isSuccess: Bool =  false)
    {
        let lblMessage=UILabel(frame: CGRect(x: 0, y: (self.window?.frame.size.height)!+70, width: (UIApplication.shared.keyWindow?.frame.size.width)!, height: 70))
        lblMessage.tag = 500
        lblMessage.text = strMessage
       // lblMessage.textColor = (isSuccess) ? UIColor.appHostThemeColor : UIColor.red//appHostThemeColor
        lblMessage.backgroundColor = UIColor.white
      //  lblMessage.font = UIFont(name: Fonts.CIRCULAR_BOOK, size: CGFloat(15))
        lblMessage.textAlignment = NSTextAlignment.center
        lblMessage.numberOfLines = 0
        lblMessage.layer.shadowColor = UIColor.black.cgColor;
        lblMessage.layer.shadowOffset = CGSize(width:0, height:1.0);
        lblMessage.layer.shadowOpacity = 0.5;
        lblMessage.layer.shadowRadius = 1.0;
        moveLabelToYposition(lblMessage)
        UIApplication.shared.keyWindow?.addSubview(lblMessage)
        UIApplication.shared.keyWindow?.bringSubviewToFront(lblMessage)
    }
    
    func moveLabelToYposition(_ lblView:UILabel)
    {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIView.AnimationOptions(), animations: { () -> Void in
            lblView.frame = CGRect(x: 0, y: (self.window?.frame.size.height)!-70, width: (UIApplication.shared.keyWindow?.frame.size.width)!, height: 70)
            }, completion: { (finished: Bool) -> Void in
                self.onCloseAnimation(lblView)
        })
    }
    
    func onCloseAnimation(_ lblView:UILabel)
    {
        UIView.animate(withDuration: 0.3, delay: 3.5, options: UIView.AnimationOptions(), animations: { () -> Void in
            lblView.frame = CGRect(x: 0, y: (self.window?.frame.size.height)!+70, width: (UIApplication.shared.keyWindow?.frame.size.width)!, height: 70)
            }, completion: { (finished: Bool) -> Void in
                lblView.removeFromSuperview()
        })
    }
    
    func createToastMessage(_ strMessage:String,
                            bgColor: UIColor = .GuestThemeColor,
                            textColor: UIColor = .GuestThemeColor) {
        if #available(iOS 13.0, *) {
            guard let keyWindow = UIApplication.shared.connectedScenes
                    .filter({$0.activationState == .foregroundActive || $0.activationState == .background || $0.activationState == .foregroundInactive})
                    .compactMap({$0 as? UIWindowScene})
                    .first?.windows
                    .filter({$0.isKeyWindow}).first else { return }
            let lblMessage=UILabel(frame: CGRect(x: 0,
                                                 y: keyWindow.frame.height + 70,
                                                 width: keyWindow.frame.size.width,
                                                 height: 70))
            lblMessage.tag = 500
//            lblMessage.text = NetworkManager.instance.isNetworkReachable ? strMessage : "N0 internet connection" //CommonError.connection.localizedDescription
            lblMessage.text = strMessage
            lblMessage.textColor = .white
            lblMessage.backgroundColor = .GuestThemeColor
            //lblMessage.font = ToastTheme.MessageText.font
            lblMessage.textAlignment = NSTextAlignment.center
            lblMessage.numberOfLines = 0
            //lblMessage.layer.shadowColor = .GuestThemeColor.cgColor;
            lblMessage.layer.shadowOffset = CGSize(width:0, height:1.0);
            lblMessage.layer.shadowOpacity = 0.5;
            lblMessage.layer.shadowRadius = 1.0;
            moveLabelToYposition(lblMessage,
                                 win: keyWindow)
            keyWindow.addSubview(lblMessage)
        } else {
            guard let window = UIApplication.shared.keyWindow else{return}
            let lblMessage=UILabel(frame: CGRect(x: 0,
                                                 y: window.frame.size.height + 70,
                                                 width: window.frame.size.width,
                                                 height: 70))
            lblMessage.tag = 500
//            lblMessage.text = NetworkManager.instance.isNetworkReachable ? strMessage : "N0 internet connection" //CommonError.connection.localizedDescription
            lblMessage.text = strMessage
            lblMessage.textColor = .white
            lblMessage.backgroundColor = .GuestThemeColor
            //lblMessage.font = ToastTheme.MessageText.font
            lblMessage.textAlignment = NSTextAlignment.center
            lblMessage.numberOfLines = 0
            //lblMessage.layer.shadowColor = .GuestThemeColor.color.cgColor;
            lblMessage.layer.shadowOffset = CGSize(width:0, height:1.0);
            lblMessage.layer.shadowOpacity = 0.5;
            lblMessage.layer.shadowRadius = 1.0;
            moveLabelToYposition(lblMessage,
                                 win: window)
            window.addSubview(lblMessage)
        }
    }
    
    func createToastMessageForAlamofire(_ strMessage : String,
                                        bgColor: UIColor = .GuestThemeColor,
                                        textColor: UIColor = .GuestThemeColor,
                                        forView:UIView) {
        let lblMessage=UILabel(frame: CGRect(x: 0,
                                             y: (forView.frame.size.height)+70,
                                             width: (forView.frame.size.width),
                                             height: 70))
        lblMessage.tag = 500
    //    lblMessage.text = NetworkManager.instance.isNetworkReachable ? strMessage : "N0 internet connection"//CommonError.connection.localizedDescription
        lblMessage.textColor = .white
        lblMessage.backgroundColor = .GuestThemeColor
        //lblMessage.font = ToastTheme.MessageText.font
        lblMessage.textAlignment = NSTextAlignment.center
        lblMessage.numberOfLines = 0
        //lblMessage.layer.shadowColor = .GuestThemeColor.color.cgColor;
        lblMessage.layer.shadowOffset = CGSize(width:0, height:1.0);
        lblMessage.layer.shadowOpacity = 0.5;
        lblMessage.layer.shadowRadius = 1.0;
        downTheToast(lblView: lblMessage,
                     forView: forView)
        UIApplication.shared.keyWindow?.addSubview(lblMessage)
    }
    
    func downTheToast(lblView:UILabel,
                      forView:UIView) {
        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       options: .curveEaseInOut ,
                       animations: { () -> Void in
            lblView.frame = CGRect(x: 0,
                                   y: (forView.frame.size.height)-70,
                                   width: (forView.frame.size.width),
                                   height: 70)
        }, completion: { (finished: Bool) -> Void in
            self.closeTheToast(lblView,
                               forView: forView)
        })
    }
    
    func closeTheToast(_ lblView:UILabel,
                       forView:UIView) {
        UIView.animate(withDuration: 0.3,
                       delay: 3.5,
                       options: .curveEaseInOut,
                       animations: { () -> Void in
            lblView.frame = CGRect(x: 0,
                                   y: (forView.frame.size.height)+70,
                                   width: (forView.frame.size.width),
                                   height: 70)
        }, completion: { (finished: Bool) -> Void in
            lblView.removeFromSuperview()
        })
    }
    /// Show the Animation
    func moveLabelToYposition(_ lblView:UILabel,
                              win: UIWindow) {
        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       options: .curveEaseInOut,
                       animations: { () -> Void in
            lblView.frame = CGRect(x: 0,
                                   y: (win.frame.size.height)-70,
                                   width: win.frame.size.width,
                                   height: 70)
        }, completion: { (finished: Bool) -> Void in
            self.onCloseAnimation(lblView,
                                  win: win)
        })
    }
    // MARK: - close the Animation
    func onCloseAnimation(_ lblView:UILabel,
                          win: UIWindow) {
        UIView.animate(withDuration: 0.3,
                       delay: 3.5,
                       options: .curveEaseInOut,
                       animations: { () -> Void in
            lblView.frame = CGRect(x: 0,
                                   y: (win.frame.size.height)+70,
                                   width: (win.frame.size.width),
                                   height: 70)
        }, completion: { (finished: Bool) -> Void in
            lblView.removeFromSuperview()
        })
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     //   self.pushNotificationHanlder?.regiserForRemoteNotification()
    }
    
    
    
    
    
    
}


extension AppDelegate{
    
    func initializeObjects(for application : UIApplication,
                           usingOptions options: [UIApplication.LaunchOptionsKey: Any]? ){
        self.pushNotificationHanlder =
            PushNotificationHandler(for: application,
                                    usingOptions: options)
    }
    /**
     To initialize 3rd party modules
     */
    func initializeModules(){
        //Push notification and FCM
        self.pushNotificationHanlder?.regiserForRemoteNotification()
//        self.pushNotificationHanlder?.getRegisteredFCMToken({ (token) in
//
//
//        })
    }

}


extension AppDelegate {
    
    //MARK: - Splash screen functionalities
    
    func makeSplashView(isFirstTime:Bool)
    {
        let splashView = SplashVC.initWithStory()
        splashView.isFirstTimeLaunch = isFirstTime
        window!.rootViewController = splashView
        window!.makeKeyAndVisible()
    }
    

        
       //MARK: - Tabbar functionalities
        
        func generateMakentLoginFlowChange(tabIcon: Int) -> UITabBarController
        {
         //getMainPage == "customer" ||
//            let getMainPage =  userDefaults.object(forKey: "getmainpage") as? NSString
//            if getMainPage == "customer" || Constants().GETVALUE(keyname: USER_ACCESS_TOKEN) != "" {
//                print("getMainPage", getMainPage)
//                print("Token", Constants().GETVALUE(keyname: USER_ACCESS_TOKEN))
//                Shared.instance.user_logged_in = true
//            } else {
//                Shared.instance.user_logged_in = false
//            }
//            self.lastSelectedIndex = tabIcon
//            self.setSemantic()
//            if isHost ?? false {
//                makentTabBarCtrler.setupHostTabBar(tabIcon)
//            } else {
//                makentTabBarCtrler.guestTabBarSetup(tabIcon)
//            }
           makentTabBarCtrler.guestTabBarSetup(tabIcon)
           
            return makentTabBarCtrler
        }
        
        func setSemantic(){
            UIView.appearance().semanticContentAttribute = Language.getCurrentLanguage().getSemantic
            self.makentTabBarCtrler.tabBar.semanticContentAttribute = Language.getCurrentLanguage().getSemantic
        }
        
        func setTabbarForSwithUsers()
        {
            
            //∂reset_dates
          //  self.resetFilersDates()
//
//            let getMainPage =  userDefaults.object(forKey: "getmainpage") as? NSString
//            if getMainPage == "customer" || Constants().GETVALUE(keyname: USER_ACCESS_TOKEN) != "" {
//                print("getMainPage", getMainPage)
//                print("Token", Constants().GETVALUE(keyname: USER_ACCESS_TOKEN))
//                Shared.instance.user_logged_in = true
//            } else {
//                Shared.instance.user_logged_in = false
//            }
//            //self.lastSelectedIndex = tabIcon
//            self.setSemantic()
//            //makentTabBarCtrler.guestTabBarSetup(tabIcon)
//    //        window?.rootViewController = makentTabBarCtrler
//    //        self.window?.makeKeyAndVisible()
//
//
//            var SetHost = Constants().GETVALUE(keyname: Switch_To_Host) == "" ? switchHostEnum.Guest.rawValue : Constants().GETVALUE(keyname: Switch_To_Host)
//
//            Constants().STOREVALUE(value: SetHost, keyname: Switch_To_Host)
//
//            var IsHost = Constants().GETVALUE(keyname: Switch_To_Host)
//
//            IsHost == switchHostEnum.Guest.rawValue ? self.generateMakentLoginFlowChange(tabIcon: 0) : self.generateMakentHostTabbarController()
//            tabBarHeight = (self.makentTabBarCtrler.tabBar.frame.height)
            
            let splashVc = self.generateMakentLoginFlowChange(tabIcon: 0)
           // splashVc.settabbar()
            let navControler = UINavigationController(rootViewController: splashVc)
            self.window?.rootViewController?.presentInFullScreen(navControler, animated: true, completion: nil)
            
            
            
//            self.pushNotificationHanlder?.regiserForRemoteNotification()
//          let mainTabBarCtrler =  self.generateMakentLoginFlowChange(tabIcon: 0)
//
//            window = UIWindow(frame: UIScreen.main.bounds)
//            window?.rootViewController = mainTabBarCtrler
//            self.window?.makeKeyAndVisible()
         
         
            
        }
        
        func generateMakentHostTabbarController() -> UITabBarController
        {
            
            
            self.setsemantic()
            self.makentTabBarCtrler.guestTabBarSetup()
            window?.rootViewController = makentTabBarCtrler
         
            //self.window?.makeKeyAndVisible()
            self.pushNotificationHanlder?.regiserForRemoteNotification()

            return makentTabBarCtrler
        }
        
        func setsemantic() {
            UIView.appearance().semanticContentAttribute = Language.getCurrentLanguage().getSemantic
            self.makentTabBarCtrler.tabBar.semanticContentAttribute = Language.getCurrentLanguage().getSemantic
        }
        
     //   func logOutDidFinish()
//        {
//            //MARK: REMOVE CORE DATA VALUES
//    //        CoreDataSupport.sharedInstance.migrateCoreData()
//    //        arrWishListData.removeAll()
//
//
//            if let controllersArray = self.makentTabBarCtrler.viewControllers {
//
//
//                for tempVC: UIViewController in controllersArray
//                {
//                    tempVC.removeFromParent()
//                }
//            }
//            LocalStorage.shared.setSting(.access_token)
//
//
//            LocalStorage.shared.setSting(.full_name)
//            LocalStorage.shared.setSting(.first_name)
//            LocalStorage.shared.setSting(.last_name)
//            LocalStorage.shared.setSting(.user_image)
//            LocalStorage.shared.setInt(.userID)
//            LocalStorage.shared.setSting(.user_birthday)
//
//    //        SharedVariables.sharedInstance.userToken = ""
//            Shared.instance.showBadgeOnChat = false
//            showBadgeOnChat(Show: true)
//            Constants().STOREVALUE(value: "", keyname: USER_ACCESS_TOKEN)
//            LocalStorage.shared.setSting(.localCurrencySymbol)
//            LocalStorage.shared.setSting(.orgCurrencySymbol)
//            userDefaults.set("", forKey:"getmainpage")
//            userDefaults.synchronize()
//    //        self.resetFilersDates()
//    //        self.lastPageMaintain = ""
//
//            let SetHost = switchHostEnum.Guest.rawValue
//
//            Constants().STOREVALUE(value: SetHost, keyname: Switch_To_Host)
//
//            var IsHost = Constants().GETVALUE(keyname: Switch_To_Host)
//
//
//            self.generateMakentLoginFlowChange(tabIcon: 0, false)
//        }
        
        
        
//        func showBadgeOnChat(Show: Bool) {
//
//            var lang = Language.getCurrentLanguage().getLocalizedInstance()
//
//            self.makentTabBarCtrler.tabBar.items?.forEach({ (item) in
//                if item.title == lang.inbox_Title.capitalized {
//
//                    if Show {
//                        item.badgeColor = .red
//                        item.badgeValue = ""
//                    }else {
//
//                        item.badgeColor = nil
//                        item.badgeValue = nil
//                    }
//
//
//
//                }
//            })
//
//
//
//        }
        
//        func showBadgeOnReservation(Show: Bool) {
//
//            var lang = Language.getCurrentLanguage().getLocalizedInstance()
//
//            self.makentTabBarCtrler.tabBar.items?.forEach({ (item) in
//                if item.title == lang.reser_Tit.capitalized{
//                    if Show {
//                        item.badgeColor = .red
//                        item.badgeValue = ""
//                    }else {
//                        print("")
//                    }
//                }
//            })
//        }
        

    
}


extension UIApplication {

    class func topViewController(_ viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = viewController as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return topViewController(presented)
        }
        return viewController
    }
}
