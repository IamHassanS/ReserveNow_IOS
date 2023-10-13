//
//  UserInfoView.swift
//  ReserveNow
//
//  Created by trioangle on 06/09/23.
//

import Foundation
import UIKit
//import FirebaseAuth
import SDWebImage
extension UserInfoView: PopOverVCDelegate {
    func didTapRow(_ index: Int) {
        if index == 2 {
          
//            do {
//                try FirebaseAuth.Auth.auth().signOut()
//                LocalStorage.shared.setBool(LocalStorage.LocalValue.isUserLoggedin, value: false)
//                self.userInfoVC.sceneDelegate?.generateMakentLoginFlowChange(tabIcon: 4)
//            } catch {
//                print("Error")
//            }
            
        }
    }
    
    
}


extension UserInfoView:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: userInfoTVC = tableView.dequeueReusableCell(withIdentifier: "userInfoTVC", for: indexPath) as! userInfoTVC
      //  cell.iconImg.image = UIImage(named: "gearshape.fill")
  
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.height / 5
    }
    
    
    
}


class UserInfoView: BaseView, UIGestureRecognizerDelegate {
    @IBOutlet weak var navBack: UIButton!
   
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var topNavView: UIView!
    @IBOutlet weak var optView: UIView!
    @IBOutlet weak var optBtn: UIButton!
    @IBOutlet weak var lblUserInfo: UILabel!
    @IBOutlet weak var contentTable: UITableView!
    @IBOutlet weak var tableHeaderView: UIView!
    var userInfoVC :  UserInfoVC!
    var isExtended : Bool = false
    let str = "A user profile is a collection of settings and information associated with a user. It contains critical information that is used to identify an individual, such as their name, age, portrait photograph and individual characteristics such as knowledge or expertise."
    let images =   ["gearshape.fill", "person.crop.circle", "cloud.fill", "bubble.left.fill", "hand.raised.fill", "hourglass.end", "mobileverify", "key.fill"]
    override func didLoad(baseVC: BaseViewController) {
        super.didLoad(baseVC: baseVC)
        self.userInfoVC = baseVC as? UserInfoVC
        self.userInfoVC.navigationController?.setNavigationBarHidden(true, animated:true)
        initActions()
        setupUI()
        tapAction()
    }
    
    func initActions() {
        self.addTap {
 
        }
        optBtn.addTarget(self, action: #selector(didTapOptBtn), for: .touchUpInside)

    }

    @objc func didTapOptBtn() {
        print("Tapped -->")
        let vc = PopOverVC.initWithStory(preferredFrame: CGSize(width: self.width / 3, height: self.height / 5), on: self.optBtn)
        vc.delegate = self
        self.userInfoVC.navigationController?.present(vc, animated: true)
        
    }
    
    func setupUI() {
        
        contentTable.register(UINib(nibName: "userInfoTVC", bundle: nil), forCellReuseIdentifier: "userInfoTVC")
        navBack.setTitle("", for: .normal)
        optBtn.setTitle("", for: .normal)
        contentTable.tableHeaderView = tableHeaderView
      //  toConfigureDynamicHeader()
        setBioLabel(count: 50, str: str, isExtended: false)
        self.userImage.layer.cornerRadius = self.userImage.height / 2
      //  self.userImage.sd_setImage(with: URL(string:Global_UserProfile.userImage),
                                   //   completed: nil)
     //   lblUserName.text = Global_UserProfile.firstName
        toConfigureDynamicHeader()
    }
    
    func toConfigureDynamicHeader() {
        let tempHeader = self.getViewExactHeight(view: self.tableHeaderView)
        self.tableHeaderView.frame.size.height = tempHeader.frame.height
        toloadContentTable()
    }
    
    
    func toloadContentTable() {
        contentTable.delegate = self
        contentTable.dataSource = self
        contentTable.reloadData()
    }
    
    func tapAction() {
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.labelAction(gesture:)))
        self.lblUserInfo.addGestureRecognizer(tap)
        self.lblUserInfo.isUserInteractionEnabled = true
        tap.delegate = self
    }
    
    
    
    func getViewExactHeight(view:UIView)->UIView {
       
        let height = view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        var frame = view.frame
        if height != frame.size.height {
            frame.size.height = height
            view.frame = frame
        }
        return view
    }
    
    @objc func labelAction(gesture: UITapGestureRecognizer)
       {
           let str = self.str
           setBioLabel(count: isExtended ? 50 : str.count, str: str, isExtended: !self.isExtended)
           toConfigureDynamicHeader()
     

       }
    
    func setBioLabel(count: Int, str: String, isExtended: Bool) {
        self.isExtended = isExtended
        let first2Chars = String(str.prefix(count)) // first2Chars = "My"
      //  self.profileview.bioheight.constant = 100
        let newStr = isExtended ? String(format: "%@..read less", first2Chars) :  String(format: "%@..read more", first2Chars)
        //                        print(newStr.count)
        self.lblUserInfo.attributedText =  self.makeAttributeTextColor(originalText: newStr as NSString, normalText: first2Chars as NSString, attributeText: isExtended ? "..read less" : "..read more", font: (UIFont.systemFont(ofSize: 14, weight: .regular)))
    }
    
    func makeAttributeTextColor(originalText : NSString ,normalText : NSString, attributeText : NSString , font : UIFont) -> NSMutableAttributedString
     {
         let attributedString = NSMutableAttributedString(string: originalText as String, attributes: [NSAttributedString.Key.font:font])
         if #available(iOS 15.0, *) {
             attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.tintColor, range: NSMakeRange(normalText.length, attributeText.length))
         } else {
             attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSMakeRange(normalText.length, attributeText.length))
             // Fallback on earlier versions
         }
         
         return attributedString
     }
}
