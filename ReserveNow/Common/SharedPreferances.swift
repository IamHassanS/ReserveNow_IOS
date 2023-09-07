import Foundation
import UIKit

typealias GifLoaderValue = (loader:UIView,
                            count : Int)

class Shared {
    private init(){}
    static let instance = Shared()
    fileprivate let preference = UserDefaults.standard
   // let delegate = UIApplication.shared.delegate as! AppDelegate
   var user_logged_in = true
    
    fileprivate var gifLoaders : [UIView:GifLoaderValue] = [:]
    var hotels = Hotels()
    var countryList = [CountryModel]()
    var selectedPhoneCode: String = ""
}
//MARK:- UserDefaults property observers


//MARK:- alert
extension Shared{
    func showLoaderInWindow(){
        DispatchQueue.main.async {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            if let window = appDelegate.window{
                self.showLoader(in: window)
            }
        }
        
    }
    func removeLoaderInWindow(){
        DispatchQueue.main.async {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            if let window = appDelegate.window{
                self.removeLoader(in: window)
            }
        }
    }
    func showLoader(in view : UIView) {
        guard Shared.instance.gifLoaders[view] == nil else{return}
        DispatchQueue.main.async {
            let gifValue : GifLoaderValue
            if let existingLoader = self.gifLoaders[view]{
                gifValue = (loader: existingLoader.loader,
                            count: existingLoader.count + 1)
            } else {
                let gif = self.getLoaderGif(forFrame: view.bounds)
                view.addSubview(gif)
                gif.frame = view.frame
                gif.center = view.center
                gifValue = (loader: gif,count: 1)
            }
            Shared.instance.gifLoaders[view] = gifValue
        }
    }
    
    func removeLoader(in view : UIView) {
        guard let existingLoader = self.gifLoaders[view] else{
            return
        }
        let newCount = existingLoader.count - 1
        if newCount == 0 {
            Shared.instance.gifLoaders[view]?.loader.removeFromSuperview()
            Shared.instance.gifLoaders.removeValue(forKey: view)
        }else{
            Shared.instance.gifLoaders[view] = (loader: existingLoader.loader,
                                                count: newCount)
        }
    }
    func getLoaderGif(forFrame parentFrame: CGRect) -> UIView {
        let jeremyGif = UIImage.gifImageWithName("loader")
        let view = UIView()
        view.backgroundColor = UIColor.appGuestThemeColor.withAlphaComponent(0.05)
        view.frame = parentFrame
        let imageView = UIImageView(image: jeremyGif)
        imageView.tintColor = .appGuestThemeColor
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        imageView.center = view.center
        view.addSubview(imageView)
        view.tag = 2596
        return view
    }
    func isLoading(in view : UIView? = nil) -> Bool{
        if let _view = view,
            let _ = self.gifLoaders[_view]{
            return true
        }
        if let window = AppDelegate.shared.window,
            let _ = self.gifLoaders[window]{
            return true
        }
        return false
    }
}
