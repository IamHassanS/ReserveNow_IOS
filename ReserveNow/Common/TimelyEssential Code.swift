import CoreGraphics
import UIKit

enum ProgressState{
    case normal
    case loading
}
protocol ProgressButtonDelegates {
    func didActivateProgress()
}
class ProgressButton : UIButton{

    var dragImg = UIImageView()
    var loaderPadding : CGFloat = 3
   
    private var pState : ProgressState = .normal
    private var maxFrame : CGRect!
    private var minFrame : CGRect!
    private var spinnerView = JTMaterialSpinner()
    private var delegate : ProgressButtonDelegates?
    
    private let dragImgMaxAlpha : CGFloat = 0.35
    private let minAlapha : CGFloat = 0.0
    fileprivate var title = String()
    var btnState : ProgressState {
        get{return pState}
        set{self.pState = newValue}
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func initialize(_ delegate : ProgressButtonDelegates, _ state: ProgressState)
                    
    {
        self.delegate = delegate
        self.dragImg.image = UIImage(systemName: "arrowshape.forward.fill")
        //?.withRenderingMode(.alwaysTemplate)
        self.dragImg.tintColor = .white
        self.dragImg.alpha = dragImgMaxAlpha
        self.btnState = .normal
        self.maxFrame = self.frame
        self.minFrame = CGRect(x: maxFrame.midX - maxFrame.height / 2,
                               y: maxFrame.minY,
                               width: maxFrame.height,
                               height: maxFrame.height)
        let upPadding = maxFrame.height * 0.1
        self.dragImg.frame = CGRect(x: 0,
                                    y: -upPadding,
                                    width: maxFrame.height * 1.2,
                                    height: maxFrame.height * 1.2)
//        if isRTLLanguage {
//            self.dragImg.frame = CGRect(x: maxFrame.maxX - maxFrame.height * 1.2,
//                                        y: -upPadding,
//                                        width: maxFrame.height * 1.2,
//                                        height: maxFrame.height * 1.2)
//            self.dragImg.transform = CGAffineTransform(scaleX: -1, y: 1)
//        }
        
        
        self.spinnerView.frame =  CGRect(x: (maxFrame.midX - maxFrame.height / 2) + self.loaderPadding,
                                         y: maxFrame.minY + self.loaderPadding,
                                         width: maxFrame.height - self.loaderPadding * 2,
                                         height: maxFrame.height - self.loaderPadding * 2)
     
        self.addSubview(self.dragImg)
        self.bringSubviewToFront(self.dragImg)
        self.spinnerView.circleLayer.lineWidth = 3
        self.spinnerView.circleLayer.strokeColor = UIColor.HostThemeColor.cgColor
        
        self.superview?.addSubview(self.spinnerView)
        self.superview?.bringSubviewToFront(self.spinnerView)
        self.spinnerView.isUserInteractionEnabled = false
        self.spinnerView.alpha = 0
        self.spinnerView.beginRefreshing()
        //self.oncli
        let slideGesture = UIPanGestureRecognizer(target: self, action: #selector(self.slidePanHanlder(_:)))
        self.dragImg.addGestureRecognizer(slideGesture)
        self.dragImg.isUserInteractionEnabled = true
    }
    func setTitle(_ title: String) {
        self.title = title
        if self.btnState != .loading{
            // Handy Splitup Start
            self.setTitle(title, for: .normal)
        }
        
    }
//    func set2Trip(state : TripStatus){
//        self.tState = state
//        self.setState(.normal)
//        // Handy Splitup Start
//        switch self.businessId {
//        case .Delivery:
//            self.setTitle(state.getDeliveryDisplayText)
//        default:
//            // Handy Splitup End
//            self.setTitle(state.getDisplayText)
//            // Handy Splitup Start
//        }
//        // Handy Splitup End
//    }
    @objc func slidePanHanlder(_ gesture : UIPanGestureRecognizer){
        let translation = gesture.translation(in: self.dragImg)
        let xMovement = translation.x
        self.titleLabel?.text = ""
        switch gesture.state {
        case .began,.changed:
//            if isRTLLanguage {
//                self.dragImg.transform = CGAffineTransform(translationX: xMovement, y: 0).concatenating(CGAffineTransform(scaleX: -1, y: 1))
//                self.titleLabel?.alpha = 1 - (-xMovement / self.frame.width)
//            } else {
                
                self.dragImg.transform = CGAffineTransform(translationX: xMovement, y: 0)
                self.titleLabel?.alpha = 1 - (xMovement / self.frame.width)
           // }
        default:
            if xMovement > self.frame.midX {
                guard xMovement > 0 && xMovement < self.frame.width else {return}
                self.setState(.loading)
                self.dragImg.alpha = minAlapha
                self.titleLabel?.alpha = 0
            }else{
                self.titleLabel?.alpha = 1
                self.setState(.normal)
            }
//            if isRTLLanguage {
//                self.dragImg.transform =  CGAffineTransform.identity.concatenating(CGAffineTransform(scaleX: -1, y: 1))
//            } else {
                self.dragImg.transform = .identity
           // }
        }
    }
    func setState(_ state : ProgressState){
        DispatchQueue.main.async {
            self.btnState = state
            self.setTitle("", for: .normal)
            self.isUserInteractionEnabled = state != .loading
            UIView.animate(withDuration: 0.6,
                           animations: {
                            switch self.btnState{
                            case .loading:
                                self.spinnerView.frame = self.frame
                                self.clipsToBounds = true
                                //self.frame = self.minFrame
                                self.layer.frame = self.minFrame
                                self.layer.cornerRadius = self.minFrame.height * 0.5
                                self.spinnerView.alpha = 1
                                self.dragImg.alpha = self.minAlapha
                                self.setTitle( "" , for: .normal)
                            default:
                                self.clipsToBounds = true
                                // self.frame = self.maxFrame
                                self.layer.frame = self.maxFrame ?? self.frame
//                                self.layer.cornerRadius = (self.minFrame?.height ??  45) * 0.05
                                self.layer.cornerRadius = (self.minFrame?.height ??  45) * 0.15
                                self.spinnerView.alpha = 0
                                self.dragImg.alpha = self.dragImgMaxAlpha
//                                self.setTitle(self.title, for: .normal)
                                
                            }
                            self.translatesAutoresizingMaskIntoConstraints = true
                           }) { (_) in
                //  self.setTitle(state == .loading ? "" : self.title, for: .normal)
                if state == ProgressState.loading{
                    self.delegate?.didActivateProgress()
                    self.titleLabel?.alpha = 0
                }else{
                    self.setTitle(self.title)
                    self.titleLabel?.alpha = 1
                }
            }
            
        }
    }
}


//func scrollViewDidScroll(_ scrollView: UIScrollView) {
//       let visibleRect = CGRect(origin: self.bannercollectionview.contentOffset, size: self.bannercollectionview.bounds.size)
//       let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
//       if let visibleIndexPath = self.bannercollectionview.indexPathForItem(at: visiblePoint) {
//           self.serviceTilePageControl.currentPage = visibleIndexPath.row
//       }
//   }


//func scrollViewDidScroll(_ scrollView: UIScrollView) {
//    if let table = scrollView as? UITableView {
//
//        if pageType == .stays {
//
//            if table == self.exploreTable {
//                if self.exploreData == nil {
//                    return
//                }
//
//                if (((table.contentOffset.y + self.exploreTable.frame.size.height) > self.exploreTable.contentSize.height && !isLoadingMorePages )){
//                    var param = [String: Any]()
//                    isLoadingMorePages = true
//                    if self.staysPage >= (self.exploreData?.totalPage)!{
//                        print("Page LImit reached")
//                    } else {
//                        self.staysPage = self.exploreData!.currentPage! + 1
//                        print("API Called")
//                        param["page"] = staysPage
//                        param["token"] = LocalStorage.shared.getString(key: .access_token)
//                        stayFilterParam.merge(param) {(_,new) in new}
//
//                        self.exploreVc.toGetExploreData(stayFilterParam)
//                    }
//                } else {
//                    print("Not to call")
//                }
//            }
//        }
//
//    }
//}


//func toGetExploreData(_ param: [String: Any]? = [String: Any](), _ page: Int = 1) {
//// https://makent81.trioangledemo.com/api/explore?language=en&page=1&token=
//   Shared.instance.showLoader(in: self.view, loaderType: .makentLoader)
//    var param: JSON = param ?? [String: Any]()
//
//    if param.isEmpty {
//        param["page"] = 1
//        param["token"] = LocalStorage.shared.getString(key: .access_token)
//    }
//
//    homeViewmodal.getExploreData(params: param, { (result) in
//        switch result {
//
//        case .success(let responseDict):
//            if responseDict.status_code == "1" {
//                Shared.instance.removeLoader(in: self.view)
//                self.exploreView.isLoadingMorePages = false
//                dump(responseDict)
//                LocalStorage.shared.setSting(.minPrice, text: responseDict.minPrice ?? "")
//                LocalStorage.shared.setSting(.maxPrice, text: responseDict.maxPrice ?? "")
//
//                LocalStorage.shared.setSting(.minSize, text: responseDict.boat_min_size ?? "")
//                LocalStorage.shared.setSting(.maxSize, text: responseDict.boat_max_size ?? "")
//
//                self.exploreData = responseDict
//                self.exploreView.exploreData = self.exploreData
//                self.exploreView.details.append(contentsOf: responseDict.details ?? [Details]())
//
//            } else {
//                Shared.instance.removeLoader(in: self.view)
//                self.exploreView.isForStays = true
//                self.exploreView.details.removeAll()
//                self.exploreView.toswitchPage(.noResults)
//            }
//            self.exploreView.toLoadStaysData()
//        case .failure(let error):
//            Shared.instance.removeLoader(in: self.view)
//            print("\(error.localizedDescription)")
//        }
//    })
//}


//override func didLayoutSubviews(baseVC: BaseViewController) {
//    super.didLayoutSubviews(baseVC: baseVC)
//    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//        if self.priceTable.contentSize.height + 10 >=  self.height - self.height * 0.07 - 10 {
//            self.priceViewHeight.constant = self.height - self.height * 0.07 - 50
//        } else {
//            self.priceViewHeight.constant = self.priceTable.contentSize.height + 10
//        }
//    }
//}


//extension UIApplication {
//
//    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
//
//        if let nav = base as? UINavigationController {
//            return getTopViewController(base: nav.visibleViewController)
//
//        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
//            return getTopViewController(base: selected)
//
//        } else if let presented = base?.presentedViewController {
//            return getTopViewController(base: presented)
//        }
//        return base
//    }
//}


//let newNav = UINavigationController(rootViewController: chatView)
//
//let viewController2 = UIApplication.getTopViewController()
//print(viewController2)
//let viewController = UIApplication.shared.keyWindow?.rootViewController
//if viewController2 is CommonChatVC {
//    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationReceived"), object: nil)
//} else {
//    currentNav.hidesBottomBarWhenPushed = true
//
//    currentNav.presentInFullScreen(newNav, animated: true)
//    //currentNav.navigationController?.pushViewController(chatView, animated: true)
//}


//if (appDelegate.window?.subviews.contains(self.composeView))! {
//    appDelegate.window?.subviews.forEach({
//        print("þþþþ \($0)")
//        print("þþþþ \($0 is MessageComposerView)")
//        if ($0 is MessageComposerView){
//            appDelegate.window!.removeAddedSubview(view: $0)
//        }
//
//        //appDelegate.window?.removeAddedSubview(view: $0)
//    })
//   // appDelegate.window!.removeAddedSubview(view: self.composeView)
//}

//move to target

//if Bundle(identifier: "com.trioangle.makent.FlutterWave")?.path(forResource: "FlutterWave", ofType: "storyboardc") != nil {
//    print("target is there")
//}
//
//let storyBoard = UIStoryboard(name: "FlutterWave", bundle: Bundle(identifier: "com.trioangle.makent.FlutterWave"))
//        let contactView = storyBoard.instantiateViewController(withIdentifier: "FlutterWaveAddPayoutVC")
////        self.navigationController?.pushViewController(FlutterWaveAddPayoutVC.initWithStory(pageType: .flutterwave, payoutDelegate: self), animated: true)
//UserDefaults.standard.set("Flutterwave", forKey: "PageType")
//self.navigationController?.pushViewController(contactView, animated: true)


//extension UILabel {
//    func setMultiColorString(_ attrkeyString: String, _ sessionTitle: String, _ originalString: String) {
////        let keyFont = attrkeyString
////        let sessionTitle = sessionTitle
////        let orginalTxt = originalString
//   //     self.attributedText = MakentSupport().addAttributeFont(originalText: orginalTxt, attributedText: keyFont as String, attributedFontName: Fonts.CIRCULAR_BOOK, attributedColor:  .appHostThemeColor, attributedFontSize: 14)
//
//        let attrs1 = [NSAttributedString.Key.font : UIFont(name: Fonts.CIRCULAR_BOOK, size: 14), NSAttributedString.Key.foregroundColor : UIColor.appHostThemeColor]
//
//        let attrs2 = [NSAttributedString.Key.font : UIFont(name: Fonts.CIRCULAR_BOOK, size: 14), NSAttributedString.Key.foregroundColor : UIColor.black]
//
//        let attributedString1 = NSMutableAttributedString(string:attrkeyString, attributes:attrs1)
//
//        let attributedString2 = NSMutableAttributedString(string: " \(sessionTitle)", attributes:attrs2)
//
//        attributedString1.append(attributedString2)
//        self.attributedText = attributedString1
//
//    }
//}
