//
//  PushNotificationManager.swift
//  ReserveNow
//
//  Created by trioangle on 31/07/23.
//

import Foundation
import Firebase
import FirebaseMessaging
import UIKit


enum MakentPushNotificationNames : String{
    case Chat
}


class PushNotificationHandler : NSObject{
    private let application : UIApplication
    private let options :  [UIApplication.LaunchOptionsKey: Any]?
    private let messaging : Messaging
    var canUpdateChatData = Bool()
    private var registeredToken : String?{
        didSet{
            guard let newToken = self.registeredToken else{return}
            LocalStorage.shared.setSting(.deviceToken, text: newToken)
          //  self.callWSToUpdateDeviceToken()
        }
    }
    lazy var appDelegate : AppDelegate =  {
        return UIApplication.shared.delegate as! AppDelegate
    }()
    
//    public func firebaseLogin() {
//       let token =  LocalStorage.shared.getString(key: .fcmToken)
//        Auth.auth().signIn(withCustomToken: token) { (result, error) in
//            if let err = error {
//                print(err.localizedDescription)
//            }
//            else if let result = result {
////                print(result.description)
//                print("firebase login success")
//            }
//        }
//    }
    
    
    
//    public func firebaseLogout() {
//       try? Auth.auth().signOut()
//    }
    
    init(for application : UIApplication,
         usingOptions options :  [UIApplication.LaunchOptionsKey: Any]?) {
        self.application = application
        self.options = options
//        self.application.applicationIconBadgeNumber = 0
        
        self.messaging = Messaging.messaging()
       
        super.init()
     
        self.messaging.delegate = self
        FirebaseApp.configure()
                
       
//        NotificationCenter.default
//            .addObserver(
//                self,
//                selector: #selector(self.callWSToUpdateDeviceToken),
//                name: NSNotification.Name.UpdateDeviceToken,
//                object: nil)
        self.observeBackgroundNotification()
        
    }
    //MARK:- UDF
    /**
     Register for Apple APNS and Firebase Cloud messaging
     */
    func regiserForRemoteNotification(){
          if #available(iOS 10.0, *) {
              let center  = UNUserNotificationCenter.current()
              center.delegate = self
              center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
                  if error == nil{
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
               }
           }
       }else {
         let settings: UIUserNotificationSettings =
         UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
         application.registerUserNotificationSettings(settings)
       }
       
        self.registerForFCM()
   }
    /**
    UnRegister for Apple APNS and Firebase Cloud messaging
    - Note: Use when the user is logged out
    */
    func unRegisterForRemoteNotification(){
        self.application.unregisterForRemoteNotifications()
    }
    func didUpdateDeviceToken(_ deviceToken : Data){
        let tokenParts = deviceToken.map { //data -> String in
            return String(format: "%02.2hhx", $0)
        }
        print("Ø Token",tokenParts.joined())
        self.messaging.apnsToken = deviceToken
        
    }
    private func registerForFCM(){
        Messaging.messaging().token { (token, error) in
            if let error = error {
                print("Ø Error fetching remote instance ID: \(error)")
            }
            else if let result = token {
                print("Ø Remote instance ID token: \(result)")
                self.registeredToken = result
            }

        }
//        InstanceID.instanceID().instanceID { (result, error) in
//                    }
//        if let token = instanceId.token() ?? self.registeredToken{
//
//            // Disconnect previous FCM connection if it exists.
//            Messaging.messaging().disconnect()
//
//            Messaging.messaging().connect { (error) in
//                if error != nil {
//                    print("Unable to connect with FCM. \(error?.localizedDescription ?? "")")
//                } else {
//                    print("Connected to FCM.")
//                }
//            }
//
//        }
       
        }
    }

//MARK:- Firebase MessagingDelegate
extension PushNotificationHandler : MessagingDelegate{
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        self.registeredToken = fcmToken
    }
    
    
    
}


//MARK:- UNUserNotificationCenterDelegate



extension PushNotificationHandler : UNUserNotificationCenterDelegate{
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler:
        @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print(notification.request.content.userInfo)
        guard let notificationRequest = notification.request.content.userInfo as? JSON,
            
            let notification1 = MakentPushNotificationNames(rawValue: notificationRequest.string("key")) else{return}

        //MARK: HANDLE PUSH NOTIFICATION MANUALLY
        
//        let custom = notificationRequest["custom"] as Any
//        notifyUser(custom) { completion in
//           print("completed")
//        }
        
        //MARK: HANDLE PUSH NOTIFICATION MANUALLY ENDS
        
        self.pushNotificationHandler(shouldPresent: notification1,
                                     response: notificationRequest) { (options) in
            completionHandler(options)
        }
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler:
        @escaping () -> Void) {
        guard let json = response.notification.request.content.userInfo as? JSON,
              let notification = MakentPushNotificationNames(rawValue: json.string("key")) else{return}
        self.pushNotificationHandler(handle: notification, response: json)
    }
}

// MARK:- UDF

extension PushNotificationHandler {
    
    func notifyUser(_ notificationString : Any, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
        let data = convertStringToDictionary(text: notificationString as? String ?? String())
        handlePushNotificaiton(userInfo: data! as NSDictionary)
    }
    
    
    func convertStringToDictionary(text: String) -> JSON? {
        if let data = text.data(using: String.Encoding.utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? JSON
                
                return json
            } catch {
                print("Something went wrong")
            }
        }
        return nil
    }

    func pushNotificationHandler(shouldPresent notification : MakentPushNotificationNames,
                                 response : JSON,
                                 withCompletionHandler callBack : @escaping (UNNotificationPresentationOptions) -> Void){
        var options : UNNotificationPresentationOptions = [.sound,.alert,.badge]
        switch notification {
        case .Chat:
            NotificationEnum.messageReceived.postNotification()
            options = [.sound,.alert, .badge]
            
        }
        callBack(options)
    }
    func pushNotificationHandler(handle notification : MakentPushNotificationNames,
                                 response : JSON){
       
        switch notification {

        case .Chat:
            NotificationEnum.messageReceived.postNotification()
            break
        }
    }
    
    
    func observeBackgroundNotification() {
     //   NotificationEnum.networkStateChanged.removeObserver(self)
      //  NotificationEnum.addObserver(<#T##self: NotificationEnum##NotificationEnum#>)
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didEnterBackground(_:)), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didEnterForeground(_:)), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    
    @objc func didEnterBackground(_ notification:Notification) {
   
        
    }
    
    @objc func didEnterForeground(_ notification:Notification) {

    }

    func handlePushNotificaiton(userInfo: NSDictionary)
    {
      
        let preference = UserDefaults.standard
        print("notification data",userInfo)
        if userInfo["meeting_request"] != nil
        {
          //  self.route2Meeting_RequestInfo(WithInfo: userInfo)

            return

        }
        
        
    }
 
    
    
}
