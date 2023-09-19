//
//  MenuView.swift
//  GoferHandy
//
//  Created by trioangle on 07/09/20.
//  Copyright © 2020 Trioangle Technologies. All rights reserved.
//

import Foundation
import Alamofire


class MenuView : BaseView{
    
    var menuVC :  MenuVC!
    //MARK: Outlets
    @IBOutlet weak var sideMenuHolderView : UIView!
    @IBOutlet weak var avatarImage : UIImageView!
    @IBOutlet weak var avatarName : UILabel!
    @IBOutlet weak var menuTable : UITableView!
    @IBOutlet weak var logoutLbl: UILabel!
    @IBOutlet weak var bottomView : UIView!
    @IBOutlet weak var logoutIV: UIImageView!
    @IBOutlet weak var bottomContentView: UIView!
    @IBOutlet weak var contentBgView: UIView!
    @IBOutlet weak var helloLbl: UIView!
    @IBOutlet weak var headerView : UIView!
    
    @IBOutlet weak var closeBtn: UIButton!
    //MARK:- life cycle
    override func didLoad(baseVC: BaseViewController) {
        super.didLoad(baseVC: baseVC)
        self.menuVC = baseVC as? MenuVC
        self.initView()
        self.initGestures()
        self.ThemeUpdate()
    }
    override func willAppear(baseVC: BaseViewController) {
        super.willAppear(baseVC: baseVC)
        self.showMenu()
    }
    //MARK:- initializers
    func initView(){
        closeBtn.isHidden = true
        closeBtn.setTitle("", for: .normal)
        self.bottomContentView.cornerRadius = 12
        if Shared.instance.user_logged_in == true {
            self.avatarImage.isHidden = false
            var frame = headerView.frame
            frame.size.height = 150
            self.headerView.frame = frame
            self.menuTable.tableHeaderView = headerView
            self.avatarName.text = "RIYA"
            self.logoutLbl.text = "Logout"
        } else {
            var frame = headerView.frame
            frame.size.height = 60
            self.headerView.frame = frame
            self.menuTable.tableHeaderView = headerView
            self.avatarImage.isHidden = true
            self.helloLbl.isHidden = true
            self.avatarName.text = "Not signed in"
            self.logoutLbl.text = "Sign in"
        }
       // self.avatarName.textAlignment = isRTL ? .right : .left
        self.menuTable.delegate = self
        self.menuTable.dataSource = self
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
            self.avatarImage.cornerRadius = 50
        }
        self.menuTable.tableHeaderView = self.headerView
        self.menuTable.tableFooterView = self.bottomView
        self.menuTable.layoutIfNeeded()
        NotificationCenter.default.addObserver(self, selector: #selector(hideMenu), name: Notification.Name("hideMenu"), object: nil)
    }
    
    @objc func hideMenu() {
        self.hideMenuAndDismiss()
    }
    
    func ThemeUpdate() {
//        self.menuTable.customColorsUpdate()
//        self.darkModeChange()
//        self.logoutLbl.customColorsUpdate()
//        self.logoutLbl.textColor = .black
//        self.backgroundColor = UIColor.IndicatorColor.withAlphaComponent(0.5)
//        self.avatarName.customColorsUpdate()
//        self.helloLbl.customColorsUpdate()
//        self.helloLbl.text = lang.hello_Tit
//        self.helloLbl.font = self.isDarkStyle ?
//            AppTheme.Fontlight(size: 16).font :
//            AppTheme.Fontbold(size: 16).font
//        self.bottomContentView.customColorsUpdate()
//        self.menuVC.commonAlert.ThemeChange()
//        self.menuTable.reloadData()
//        self.contentBgView.customColorsUpdate()
    }
    
    
    @IBAction func didTapCloseBtn(_ sender: Any) {
        
        hideMenuAndDismiss()
    }
    
    @IBAction func topSettAct(_ sender:UIButton){
        print("Sett")
        let _selectedItem = self.menuVC.menuItems[5]
        self.menuVC.menuDelegate?.routeToView(_selectedItem.viewController!)
        self.menuVC.dismiss(animated: false, completion: nil)
    }
    
    func initGestures(){
        self.sideMenuHolderView.addAction(for: .tap) {
            self.hideMenuAndDismiss()
        }
        self.bottomContentView.addAction(for: .tap) {
//            if Shared.instance.user_logged_in == true {
//                self.menuVC.presentAlertWithTitle(title: self.lang.appName, message: self.lang.logout_msg, options: self.lang.okBtn_Tit,self.lang.cancelBtn_Tit, completion: {
//                    (optionss) in
//                    switch optionss {
//                    case 0:
//                        var params = self.menuVC.dictParms
//                        params["access_token"] = Constants().GETVALUE(keyname:USER_ACCESS_TOKEN)
//                        self.menuVC.callLogoutAPI(params: params)
//                    case 1:
//                        self.hideMenuAndDismiss()
//                    //self.menuVC.dismiss(animated: false, completion: nil)
//                    default:
//                        break
//                    }
//                })
//            } else {
//                let vc = LoginVC.initWithStory()
//                vc.modalPresentationStyle = .fullScreen
//                vc.hidesBottomBarWhenPushed = true
//                self.menuVC.present(vc, animated: true, completion: nil)
//            }
            
        }
//        self.settingIV.addAction(for: .tap) {
//            let _selectedItem = self.menuVC.menuItems[7]
//            self.menuVC.menuDelegate?.routeToView(_selectedItem.viewController!)
//            self.menuVC.dismiss(animated: false, completion: nil)
//        }
//        self.settingIV.isHidden = true
        
        // MARK: ---------->  Views Having Same Guesture Menu Fun <-------
        let views = [avatarImage,
                     avatarName]
        views.forEach { (view) in
            if let view = view {
                view.addAction(for: .tap) {
//                    guard let model = self.menuVC.accountViewModel else {return}
//                    let propertyView : ViewProfileVC  = .initWithStory(accountVM: model)
                
                   // self.menuVC.menuDelegate?.routeToView(propertyView)
                    
                   // self.menuVC.dismiss(animated: false, completion: nil)
                }
            }
        }
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handleMenuPan(_:)))
        self.sideMenuHolderView.addGestureRecognizer(panGesture)
        self.sideMenuHolderView.isUserInteractionEnabled = true
    }
    //MARK: UDF, gestures  and animations
    
    private var animationDuration : Double = 1.0
    private let aniamteionWaitTime : TimeInterval = 0.15
    private let animationVelocity : CGFloat = 5.0
    private let animationDampning : CGFloat = 2.0
    private let viewOpacity : CGFloat = 0.3
    var isRTLLanguage : Bool { get { return Language.getCurrentLanguage().isRTL } }
    func showMenu(){
        let isRTL = isRTLLanguage
        let rtlValue : CGFloat =  -1
        //isRTL ? 1 :
        let width = self.frame.width
        self.sideMenuHolderView.transform =  CGAffineTransform(translationX: rtlValue * width,y: 0)
        //isRTL ? CGAffineTransform(translationX: 1 * width,y: 0)  :
        self.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        while animationDuration > 1.6{
            animationDuration = animationDuration * 0.1
        }
        UIView.animate(withDuration: animationDuration,
                       delay: aniamteionWaitTime,
                       usingSpringWithDamping: animationDampning,
                       initialSpringVelocity: animationVelocity,
                       options: [.curveEaseOut,.allowUserInteraction],
                       animations: {
                        self.sideMenuHolderView.transform = .identity
                        self.backgroundColor = UIColor.black.withAlphaComponent(self.viewOpacity)
                       }, completion: nil)
    }

    func hideMenuAndDismiss(){
        let isRTL = isRTLLanguage
        let rtlValue : CGFloat = isRTL ? 1 : -1
      //  isRTL ? 1 :
        let width = self.frame.width
        while animationDuration > 1.6{
            animationDuration = animationDuration * 0.1
        }
        UIView.animate(withDuration: animationDuration,
                       delay: aniamteionWaitTime,
                       usingSpringWithDamping: animationDampning,
                       initialSpringVelocity: animationVelocity,
                       options: [.curveEaseOut,.allowUserInteraction],
                       animations: {
                        self.sideMenuHolderView.transform = CGAffineTransform(translationX: width * rtlValue,
                                                                              y: 0)
                        self.backgroundColor = UIColor.black.withAlphaComponent(0.0)
                       }) { (val) in
            
            self.menuVC.dismiss(animated: false, completion: nil)
        }
        
        
    }
    @objc func handleMenuPan(_ gesture : UIPanGestureRecognizer){
        let isRTL = isRTLLanguage
        let _ : CGFloat =  isRTL ? 1 : -1
        //isRTL ? 1 :
        let translation = gesture.translation(in: self.sideMenuHolderView)
        let xMovement = translation.x
        //        guard abs(xMovement) < self.view.frame.width/2 else{return}
        var opacity = viewOpacity * (abs(xMovement * 2)/(self.frame.width))
        opacity = (1 - opacity) - (self.viewOpacity * 2)
        print("~opcaity : ",opacity)
        switch gesture.state {
        case .began,.changed:
            guard isRTL && ( xMovement > 0) || !isRTL && (xMovement < 0) else {return}
           // isRTL && || !isRTL &&
            
            self.sideMenuHolderView.transform = CGAffineTransform(translationX: xMovement, y: 0)
            self.backgroundColor = UIColor.black.withAlphaComponent(opacity)
        default:
            let velocity = gesture.velocity(in: self.sideMenuHolderView).x
            self.animationDuration = Double(velocity)
            if abs(xMovement) <= self.frame.width * 0.25{//show
                self.sideMenuHolderView.transform = .identity
                self.backgroundColor = UIColor.black.withAlphaComponent(self.viewOpacity)
            }else{//hide
                self.hideMenuAndDismiss()
            }
            
        }
    }
}
extension MenuView : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.menuVC.menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:MenuTCell.identifier ) as! MenuTCell
        guard let item = self.menuVC.menuItems.value(atSafe: indexPath.row) else{return cell}
        cell.ThemeUpdate()
        cell.lblName?.text = item.title
        if let image = item.imgName {
            cell.menuIcon?.image = UIImage(named: image)?.withRenderingMode(.alwaysTemplate)
            cell.menuIcon?.clipsToBounds = true
            //cell.menuIcon?. contentMode = .scaleAspectFit
        }else{
           // cell.menuIcon?.image = nil
        }
        cell.menuIcon?.isHidden = true
      //  cell.lblName?.textAlignment = .left
        // isRTL ? .right :


        cell.contentView.addAction(for: .tap) {
            
            if indexPath.row == 0 {
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "backAction"), object: self, userInfo: nil)
               // self.hideMenuAndDismiss()
            }
            
            self.menuVC.dismiss(animated: false, completion: {
                let _selectedItem = self.menuVC.menuItems[indexPath.row]
                if let vc = _selectedItem.viewController{
                    if cell.lblName?.text == "Language" {
                        //let vc = ChangeLanguageVC.initWithStory()
                        self.menuVC.menuDelegate?.routeToHome(vc)
                    } else {
                        self.menuVC.menuDelegate?.routeToView(vc)
                    }
                    //self.menuVC.menuDelegate?.routeToView(vc)
                }else{
//                    if cell.lblName?.text == self.lang.language_Tit {
//                        let vc = ChangeLanguageVC.initWithStory()
//                        vc.isFromMenu = true
//                        self.menuVC.menuDelegate?.routeToHome(vc)
//                    } else if cell.lblName?.text == "LangCommon.font" {
//                        self.menuVC.menuDelegate?.changeFont()
//                    }
//                    else if cell.lblName?.text == "LangCommon.backToHome" {
//                        self.menuVC.menuDelegate?.popToGojek()
//                    }
//
//                    else {
//                        self.menuVC.menuDelegate?.openThemeActionSheet()
//                    }
                   
                }
            })
        
        }
        cell.holderView.backgroundColor = .gray
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? MenuTCell else {return}
        cell.holderView.backgroundColor = .gray
        cell.holderView.cornerRadius = 15
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? MenuTCell else {return}
        cell.holderView.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
        cell.holderView.cornerRadius = 15
    }
    
}

class MenuTCell: UITableViewCell
{
    @IBOutlet weak var lblName: UILabel?
    @IBOutlet weak var menuIcon: UIImageView?
    @IBOutlet weak var holderView: UIView!
    static let identifier = "MenuTCell"
    
    func ThemeUpdate() {
//        self.contentView.backgroundColor = self.isDarkStyle ? .DarkModeBackground : .TertiaryColor
//        self.backgroundColor = self.isDarkStyle ? .DarkModeBackground : .TertiaryColor
//       // holderView.backgroundColor = .clear
//        self.lblName?.customColorsUpdate()
    }
}
