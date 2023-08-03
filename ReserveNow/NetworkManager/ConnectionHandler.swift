import Foundation
import UIKit
import Alamofire

final class ConnectionHandler : NSObject {
    static let shared = ConnectionHandler()
    private let alamofireManager : Session
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var preference = UserDefaults.standard
    let strDeviceType = "1"
    let strDeviceToken = Utilities.sharedInstance.getDeviceToken()
    var handler = LocalCacheHandler()
    
    override init() {
        print("Singleton initialized")
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 300 // seconds
        configuration.timeoutIntervalForResource = 500
        alamofireManager = Session.init(configuration: configuration,
                                        serverTrustManager: .none)//Alamofire.SessionManager(configuration: configuration)
    }
    func getRequest(for api : APIEnums,
                    params : Parameters) -> APIResponseProtocol{
        if api.method == .get {
            return self.getRequest(forAPI: APIUrl + api.rawValue,
                                   params: params,
                                   CacheAttribute: api.cacheAttribute ? api : .none)
        } else {
            return self.postRequest(forAPI: APIUrl + api.rawValue,
                                    params: params)
        }
    }
    
    func getRequest(forAPI api: String,
                    params: JSON,
                    CacheAttribute: APIEnums) -> APIResponseProtocol {
        let responseHandler = APIResponseHandler()
        var parameters = params
        let startTime = Date()

//        if parameters["language"] == nil,
//           let language : String =  UserDefaults.value(for: .default_language_option){
//            parameters["language"] = language
//        }
        

        alamofireManager.request(api,
                                 method: .get,
                                 parameters: parameters,
                                 encoding: URLEncoding.default,
                                 headers: nil)
            .responseJSON { (response) in
                print("Å api : ",response.request?.url ?? ("\(api)\(params)"))
                let endTime = Date()
                
                self.networkChecker(with: startTime, EndTime: endTime, ContentData: response.data)
                
                guard response.response?.statusCode != 503 else { // Web Under Maintenance
                    //self.webServiceUnderMaintenance()
                 //   Shared.instance.removeLoaderInWindow()
                    return
                }
                
                
//                guard response.response?.statusCode != 500 else { // Web Under Maintenance
//                    //self.webServiceUnderMaintenance()
//                    Shared.instance.removeLoaderInWindow()
//                    return
//                }
                
                guard response.response?.statusCode != 401 else{//Unauthorized
                    if response.request?.url?.description.contains(APIUrl) ?? false{
                        //self.doLogoutActions()
                    }
                    return
                }
                switch response.result {
                case .success(let value):
                    let json = value as! JSON

                    let error = json.string("error")
                    guard error.isEmpty else{
                        if error == "user_not_found"
                            && response.request?.url?.description.contains(APIUrl) ?? false{
                           // self.doLogoutActions()
                        }
                        return
                    }
                    if json.isSuccess
                        || !api.contains(APIUrl)
                        || response.response?.statusCode == 200 {
                        
                        responseHandler.handleSuccess(value: value,data: response.data ?? Data())
                    }else{
                        responseHandler.handleFailure(value: json.status_message)
                    }
                case .failure(let error):
                    if error._code == 13 {
                        responseHandler.handleFailure(value: "No internet connection.".localizedCapitalized)
                    } else if error._code == 500 {
                        responseHandler.handleFailure(value: "")
                    } else {
                        responseHandler.handleFailure(value: error.localizedDescription)
                    }
                }
            }
        
        
        return responseHandler
    }
    
    func postRequest(forAPI api: String, params: JSON) -> APIResponseProtocol {
        let responseHandler = APIResponseHandler()
        var parameters = params
        let startTime = Date()
//        if let token = UserDefaults.value(for: .access_token)  ?? ""{
//            parameters["token"] = token
//        }
//        parameters["user_type"] = Global_UserType
//        parameters["device_id"] = strDeviceToken
//        parameters["device_type"] = strDeviceType
        alamofireManager.request(api,
                                 method: .post,
                                 parameters: parameters,
                                 encoding: URLEncoding.default,
                                 headers: nil)
            .responseJSON { (response) in
                print("Å api : ",response.request?.url ?? ("\(api)\(parameters)"))
                
                let endTime = Date()
                
                self.networkChecker(with: startTime, EndTime: endTime, ContentData: response.data)
                
                guard response.response?.statusCode != 401 else{//Unauthorized
                    if response.request?.url?.description.contains(APIUrl) ?? false{
                        //self.doLogoutActions()
                    }
                    return
                }
                
                guard response.response?.statusCode != 503 else { // Web Under Maintenance
                    //self.webServiceUnderMaintenance()
                    return
                }
                switch response.result{
                case .success(let value):
                    let json = value as! JSON
                    let error = json.string("error")
                    guard error.isEmpty else{
                        if error == "user_not_found"
                            && response.request?.url?.description.contains(APIUrl) ?? false{
                            //self.doLogoutActions()
                        }
                        return
                    }
                    if json.isSuccess
                        || !api.contains(APIUrl)
                        || response.response?.statusCode == 200{
                        
                        responseHandler.handleSuccess(value: value,data: response.data ?? Data())
                    }else{
                        responseHandler.handleFailure(value: json.status_message)
                    }
                case .failure(let error):
                    if error._code == 13 {
                        responseHandler.handleFailure(value: "No internet connection.".localizedCapitalized)
                    } else {
                        responseHandler.handleFailure(value: error.localizedDescription)
                    }
                }
            }
        
        
        return responseHandler
    }
    
    
    func imageUploadService(urlString:String, parameters:[String:Any], image:[UIImage]?=nil, imageName:[String] = ["image"], isDocument: Bool? = false, docurl: URL? = URL(string: ""), complete:@escaping (_ response: [String:Any]) -> Void, onError : @escaping ((Error?)-> Void)) {
            
        Shared.instance.showLoaderInWindow()
        UIApplication.shared.beginIgnoringInteractionEvents()
       
       
        AF.upload(multipartFormData: { (multipartFormData) in
           
            if let doc = docurl, doc != URL(string: "") {
                var fileData = Data()
                let imageType = docurl?.getMimeType()
                
                //docurl?.getMimeType()
                let fileName =   docurl?.lastPathComponent
                //String(Date().timeIntervalSince1970 * 1000) + ".\(imageType ?? "")"
                do {
                    fileData = try! Data(contentsOf: docurl!)
                    
                }
                    let imgData: Data? = fileData
                    if imgData != nil {
                        multipartFormData.append(fileData, withName: "image",fileName: fileName, mimeType: "\(imageType ?? "")")
                    }
            } else {
                if let images = image,images.count > 0 {
                    for (index,orgimage) in images.enumerated() {
                        let imageType = "jpeg"
                        let fileName = String(Date().timeIntervalSince1970 * 1000) + "Image.\(imageType)"
                        let imgData: Data? = orgimage.jpegData(compressionQuality: 0.4)
                        if imgData != nil {
                            multipartFormData.append(imgData!, withName: imageName[index],fileName: fileName, mimeType: "\(imageName)/\(imageType)")
                        }
                    }

                }
            }
            
            

            
            for (key, value) in parameters {
                multipartFormData.append(String(describing: value).data(using: String.Encoding.utf8, allowLossyConversion: true)!, withName: key)
            } //Optional for extra parameters
        }, to: "\("")\(urlString)")
        .responseJSON(completionHandler: { response in
            Shared.instance.removeLoaderInWindow()
                UIApplication.shared.endIgnoringInteractionEvents()
           
           switch response.result {
           case .success(let value):
               let responseDict = value as! [String : Any]
//            if self.userIsActive(from: responseDict)  {
//                print("ØØ  \(responseDict)")
//                complete(responseDict)
//            }
               print(responseDict)
           case .failure(let error):
               print(error)
               onError(error)
               if error._code == 4 {
                  // self.appDelegatee.createToastMessage("We are having trouble fetching the menu. Please try again.")
               }
               else {
                //   self.appDelegatee.createToastMessage(error.localizedDescription)
               }
           }
           
           
          

       })
    }
    
    
    func networkChecker(with StartTime:Date,
                        EndTime: Date,
                        ContentData: Data?) {
        
        let dataInByte = ContentData?.count
        
        if let dataInByte = dataInByte {
            
            // Standard Values
            let standardMinContentSize : Float = 3
            let standardKbps : Float = 2
            
            // Kb Conversion
            let dataInKb : Float = Float(dataInByte / 1000)
            
            // Time Interval Calculation
            let milSec  = EndTime.timeIntervalSince(StartTime)
            let duration = String(format: "%.01f", milSec)
            let dur: Float = Float(duration) ?? 0
            
            // Kbps Calculation
            let Kbps = dataInKb / dur
            
            if dataInKb > standardMinContentSize {
                if Kbps < standardKbps {
                    print("å:::: Low Network Kbps : \(Kbps)")
                    self.appDelegate.createToastMessage("LOW NETWORK")
                } else {
                    print("å:::: Normal NetWork Kbps : \(Kbps)")
                }
            } else {
                print("å:::: Small Content : \(Kbps)")
            }
            
        }
    }
    
}
