//
//  Views.swift
//  ReserveNow
//
//  Created by trioangle on 01/08/23.
//

import Foundation
import UIKit

extension ExploreView: MenuResponseProtocol {
    func routeToView(_ view: UIViewController) {
        print("")
       // self.hidesBottomBarWhenPushed = true
        self.exploreVC.modalPresentationStyle = .fullScreen
        self.exploreVC.navigationController?.pushViewController(view, animated: true)
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "backAction"), object: self, userInfo: nil)
//        self.navigationController?.pushViewController(view, animated: true)
//        self.navigationController?.presentInFullScreen(view, animated: true, completion: nil)
        
    }
    
    func callAdminForManualBooking() {
        print("")
    }
    
    func openThemeActionSheet() {
        print("")
    }
    
    func changeFont() {
        print("")
    }
    
    func routeToHome(_ view: UIViewController) {
        print("")
    }
    
    
}

class ExploreView: BaseView {
    
    var exploreVC: ExploreVC!

    @IBOutlet weak var topContentsHolderView: UIView!
    @IBOutlet weak var baseScrollView: UIScrollView!
    @IBOutlet weak var holderView: UIView!

    @IBOutlet weak var searchHolderView: UIView!
    
    @IBOutlet weak var menuHolderView: UIView!
    
    override func didLoad(baseVC: BaseViewController) {
        
        
            super.didLoad(baseVC: baseVC)
            self.exploreVC = baseVC as? ExploreVC
        Shared.instance.showLoader(in: self)

        cellregistration()
        toLOadData()
        setupUI()
        initView()
       // setupUI()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            Shared.instance.removeLoader(in: self)
        }
        }
    
    func setupUI() {
        searchHolderView.layer.borderWidth = 1
        searchHolderView.layer.borderColor = UIColor.lightGray.cgColor
        searchHolderView.elevate(2)
        searchHolderView.layer.cornerRadius = 10
        topContentsHolderView.elevate(2)
        topContentsHolderView.layer.cornerRadius =  topContentsHolderView.height / 2
    }
    
    func initView() {
        menuHolderView.addTap {
            print("::>--Tapped-->::")
            let menuvc = MenuVC.initWithStory(self)
            self.exploreVC.modalPresentationStyle = .custom
            menuvc.menuDelegate = self
            self.exploreVC.navigationController?.present(menuvc, animated: true)
            
      
        }
    }
    
    
    
    override func didLayoutSubviews(baseVC: BaseViewController) {
     

    }
    
    func toLOadData() {
 
//        self.collectionViewCategory.dataSource = self
//        self.collectionViewCategory.delegate = self
//        self.collectionViewCategory.reloadData()
//
//
//
//        self.collectionViewExplore.dataSource = self
//        self.collectionViewExplore.delegate = self
//        self.collectionViewExplore.reloadData()
    }
    
    func cellregistration() {

    }
    
    
    

    
  
    

    
    
    

    
    
    
}





