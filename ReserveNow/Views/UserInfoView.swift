//
//  UserInfoView.swift
//  ReserveNow
//
//  Created by trioangle on 06/09/23.
//

import Foundation
import UIKit

extension UserInfoView:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: userInfoTVC = tableView.dequeueReusableCell(withIdentifier: "userInfoTVC", for: indexPath) as! userInfoTVC
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.height / 5
    }
    
    
    
}


class UserInfoView: BaseView, UIGestureRecognizerDelegate {
   
    @IBOutlet weak var lblUserInfo: UILabel!
    @IBOutlet weak var contentTable: UITableView!
    @IBOutlet weak var tableHeaderView: UIView!
    var userInfoVC :  UserInfoVC!
    override func didLoad(baseVC: BaseViewController) {
        super.didLoad(baseVC: baseVC)
        self.userInfoVC = baseVC as? UserInfoVC
        initActions()
        setupUI()
        tapAction()
    }
    
    func initActions() {
        
    }
    
    func setupUI() {
        contentTable.register(UINib(nibName: "userInfoTVC", bundle: nil), forCellReuseIdentifier: "userInfoTVC")
        contentTable.tableHeaderView = tableHeaderView
      //  toConfigureDynamicHeader()
        setBioLabel(count: 50, str: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
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
           let str = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
           setBioLabel(count: str.count, str: str)
           toConfigureDynamicHeader()
print("Tapped")
       }
    
    func setBioLabel(count: Int, str: String) {
        let first2Chars = String(str.prefix(count)) // first2Chars = "My"
      //  self.profileview.bioheight.constant = 100
        let newStr = String(format: "%@..Read More", first2Chars)
        //                        print(newStr.count)
        self.lblUserInfo.attributedText =  self.makeAttributeTextColor(originalText: newStr as NSString, normalText: first2Chars as NSString, attributeText: "..Read More", font: (UIFont.systemFont(ofSize: 14, weight: .regular)))
       // toConfigureDynamicHeader()
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
