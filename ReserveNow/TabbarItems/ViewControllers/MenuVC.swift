//
//  MenuVC.swift
//  Gofer
//
//  Created by trioangle on 12/04/19.
//  Copyright © 2019 Trioangle Technologies. All rights reserved.
//

import UIKit
import Foundation
//import SDWebImage

protocol MenuResponseProtocol {
    func routeToView(_ view : UIViewController)
    func callAdminForManualBooking()
    func openThemeActionSheet()
    func changeFont()
    func routeToHome(_ view: UIViewController)

}
extension MenuResponseProtocol where Self : UIViewController{
    func callAdminForManualBooking() {
       // self.checkMobileNumeber()
    }
    func openThemeActionSheet(){
        //self.openThemeSheet()
    }
    func routeToView(_ view: UIViewController) {
        self.hidesBottomBarWhenPushed = true
        self.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(view, animated: true)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "backAction"), object: self, userInfo: nil)
        self.navigationController?.pushViewController(view, animated: true)
        self.navigationController?.presentInFullScreen(view, animated: true, completion: nil)
    }
    func routeToHome(_ view: UIViewController) {
        self.hidesBottomBarWhenPushed = true
        self.modalPresentationStyle = .overFullScreen
        self.navigationController?.presentInFullScreen(view, animated: true, completion: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "backAction"), object: self, userInfo: nil)
        self.navigationController?.pushViewController(view, animated: true)
        self.navigationController?.presentInFullScreen(view, animated: true, completion: nil)
    }
    func changeFont() {
        //self.openChangeFontSheet()
    }
 
    //New_Handy_Splitup_Start
    // Laundry Splitup Start
    // Instacart Splitup Start
//    func popToGojek() {
//        //self.navigationController?.popToRootViewController(animated: true)
//        AppWebConstants.businessType = .Gojek
//        appDelegate.onSetRootViewController(viewCtrl: self)
//    }
//    func popToServiceType() {
//        //Delivery_NewSplitup_Start
//        // Laundry_NewSplitup_start
//        // Gofer_NewSplitup_start
//        // InstaCart_NewSplitup_start
//        if let vc = self.navigationController?.viewControllers.filter({$0.isKind(of: ServiceTypeVC.self)}).first {
//            self.navigationController?.popToViewController(vc,
//                                    animated: true)
//        } else {
//            self.navigationController?.pushViewController(ServiceTypeVC.initWithStory(),
//                                     animated: true)
//        }
        // InstaCart_NewSplitup_end
        // Gofer_NewSplitup_end
        // Laundry_NewSplitup_end
        //Delivery_NewSplitup_End
    }
  
    //New_Handy_Splitup_End
    // Laundry Splitup End
    // Instacart Splitup End
//}

class MenuVC: BaseViewController {
    func HidemiddleBtn(IsHide: Bool) {
        print("")
    }
    
    func promoCodeName(code: String) {
        
    }
    
    func promoUpdate(promoId: Int) {
        print("")
    }
    
    func promoDetailId(id: Int) {
    }
    
    func reloadPromo() {
    }
    
  
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.traitCollection.userInterfaceStyle == .dark ? .lightContent : .darkContent
    }
    func onFailure(error: String,for API : APIEnums) {
        print(error)
    }
    
    @IBOutlet weak var menuView : MenuView!

    
//    @IBOutlet weak var menuHeaderHeight: NSLayoutConstraint!
    
    var menuItems = [MenuItemModel]()
    var menuDelegate : MenuResponseProtocol?
  //  var accountViewModel : AccountViewModel?
    var dictParms = [String: Any]()
    var imageURL = ""
    //MARK:- view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTableDataSources()
        if Shared.instance.user_logged_in == true {
           // self.menuView.avatarName.text = Constants().GETVALUE(keyname: USER_FULL_NAME)

        }else{
            self.menuView.avatarImage.isHidden = true
            self.menuView.avatarName.text = "Not signed in"

        }
     
      //  self.imageURL = Constants().GETVALUE(keyname: USER_IMAGE_THUMB)
        self.menuView.avatarImage.contentMode = .scaleToFill
        self.menuView.avatarImage.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named:"DummyAvatar"))
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // self.setprofileInfo()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
   
    
    func initTableDataSources(){
        self.menuItems = self.getMenuItems()
        self.menuView.menuTable.reloadData()
    }
//    func getGoferMenuItems() -> [MenuItemModel]{
//        var goferItems = [MenuItemModel]()
//        let paymentItem = MenuItemModel(withTitle: LangCommon.paymentStatus.capitalized, VC: check2.initWithStory())
//        let tripView = check2.initWithStory()
//
//        //mainStory.instantiateViewController(withIdentifier: "TripsVC") as! TripsVC
//        let listTripsItem = MenuItemModel(withTitle: LangCommon.yourBooking.capitalized, VC: tripView)
//
//        let walletItem = MenuItemModel(withTitle: LangCommon.wallet, VC: WishListVc.initWithStory())
//
//        let referralItem = MenuItemModel(withTitle: LangCommon.referral, VC: check2.initWithStory())
//
////        let settingsView = SettingsVC.initWithStory(accountViewModel: self.accountViewModel!)
////        settingsView.delegate = self
////        let settingItem = MenuItemModel(withTitle: LangCommon.settings, VC:settingsView )
//
//
//        goferItems.append(paymentItem)
//        goferItems.append(listTripsItem)
//        goferItems.append(walletItem)
//
//        goferItems.append(referralItem)
//
//
//
//
//        return goferItems
//    }
    
    func getMenuItems() -> [MenuItemModel] {
        var menuitems = [MenuItemModel]()
      //  return menuitems
//
//
       let dashBoard  = UIViewController()
        dashBoard.view.backgroundColor = .red
            //.initWithStory()
//
//        Homeview.hidesBottomBarWhenPushed = false
      //  AppDelegate.shared.onSetRootViewController(viewCtrl: Homeview)
//
        let dashBoardItem = MenuItemModel(withTitle: "Dashboard",
                                        image: UIImage(systemName: "list.dash.header.rectangle"),
                                        VC: dashBoard)
        
        let squareOne  = UIViewController()
        squareOne.view.backgroundColor = .orange
        
        let squareOneItem = MenuItemModel(withTitle: "Square One",
                                        image: UIImage(systemName: "square.split.2x2.fill"),
                                        VC: dashBoard)
        
        
        let dataPage  = UIViewController()
        dataPage.view.backgroundColor = .yellow
        
        let dataPageItem = MenuItemModel(withTitle: "Data Page",
                                        image: UIImage(systemName: "info.bubble.fill"),
                                        VC: dashBoard)
//
//
//        let accountView = ViewAccountVC.initWithStory()
//        accountView.isFromMenu = true
//
//        let accountItem = MenuItemModel(withTitle: self.lang.profile_Tit.capitalized,
//                                          image: "Your Bookings",
//                                          VC: accountView)
//
//
//        let purchaseView =  PurchaseHistoryVC.initWithStory()
//        purchaseView.Ispush = true
//        let purchaseItem = MenuItemModel(withTitle: self.lang.purchase_history_Tit,
//                                       image: "wallet-icon-select",
//                                       VC: purchaseView)
//
//        let wishListItem = MenuItemModel(withTitle: self.lang.my_wishlist_Tit,
//                                         image: "Invite Friends",
//                                         VC: WishListVc.initWithStory())
//        var languageItem = MenuItemModel(withTitle: self.lang.language_Tit,
//                                         image: "",
//                                         VC: ChangeLanguageVC.initWithStory())
//
//
//        if Shared.instance.user_logged_in == true {
            menuitems.append(dashBoardItem)
        menuitems.append(squareOneItem)
        menuitems.append(dataPageItem)
//            cliqBuyItems.append(accountItem)
//            cliqBuyItems.append(purchaseItem)
//            cliqBuyItems.append(wishListItem)
//            cliqBuyItems.append(languageItem)
//        } else {
//            cliqBuyItems.append(homeItem)
//            cliqBuyItems.append(languageItem)
//        }
//
        return menuitems
    }
    
    //MARK:- initWithStory
    class func initWithStory(_ delegate : MenuResponseProtocol?)-> MenuVC{
        
        let view : MenuVC = UIStoryboard.Main.instantiateViewController()
        view.modalPresentationStyle = .overCurrentContext

        view.menuDelegate = delegate


        
        return view
    }
    
//    class func initWithStory() -> Homevc {
//        let splash : Homevc = UIStoryboard.cliqbuy_Common.instantiateViewController()
//        return splash
//    }
    // MARK: LOGOUT API CALL
    /*
     */
//    func callLogoutAPI(params: JSON) {
//        self.accountViewModel?.callLogoutAPI(param: params) {(result) in
//            switch result {
//            case .success:
//                dump(result)
//            case .failure(let error):
//                print("Error:::", error.localizedDescription)
//            }
//        }
//    }
    
    func callLogoutAPI(params: JSON) {

        //var param: JSON = JSON()

//        Shared.instance.showLoader(in: self.view)
//        self.accountViewModel?.callLogoutAPI(parms: params) { (result) in
//            switch result {
//            case .success(let responseDict):
//                    Shared.instance.removeLoader(in: self.view)
//                    Shared.instance.user_logged_in = false
//                self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: {
//                        let userDefaults = UserDefaults.standard
//                        userDefaults.set("", forKey:"getmainpage")
//                        userDefaults.synchronize()
//                        userDefaults.removeObject(forKey: USER_ACCESS_TOKEN)
//                        userDefaults.removeObject(forKey: USER_EMAIL_ID)
//                        userDefaults.removeObject(forKey: USER_ID)
//                        userDefaults.removeObject(forKey: USER_IMAGE_THUMB)
//                        userDefaults.removeObject(forKey: USER_FULL_NAME)
//                        Shared.instance.user_logged_in = false
//                        AppDelegate.shared.onSetRootViewController(viewCtrl: self)
//                    })
//            case .failure(let error):
//                print("\(error.localizedDescription)")
//                Shared.instance.removeLoader(in: self.view)
//
//            }
//        }
    }
    
    func removeAllNotication() {
//        for observer in Shared.instance.notifObservers {
//            NotificationCenter.default.removeObserver(observer)
//        }
//        Shared.instance.notifObservers.removeAll()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.menuView.ThemeUpdate()
    }
    // AFTER USER LOGOUT, WE SHOULD RESET WORK/HOME LOCATION DETAILS

    
    
}


class MenuItemModel{
    var title : String
    var imgName : UIImage?
    var viewController : UIViewController?
    var vm : BaseModel?
    init(withTitle title :String,image : UIImage? = nil,VC : UIViewController?, vm: BaseModel? = BaseModel() ){
        self.title = title
        self.imgName = image
        self.viewController = VC
        self.vm = vm
    }
}
class CellMenus: UITableViewCell
{
    @IBOutlet var lblName: UILabel?
}

