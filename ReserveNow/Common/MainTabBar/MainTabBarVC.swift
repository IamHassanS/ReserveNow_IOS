//
//  MainTabBarVC.swift
//  ReserveNow
//
//  Created by trioangle on 01/08/23.
//

import UIKit

class MainTabBarVC: UITabBarController, UITabBarControllerDelegate {
    
     //  let sharedAppDelegate:AppDelegate =  UIApplication.shared.delegate as! AppDelegate
    var homeNavigation : UINavigationController!
    
    private let indicatorView: UIView = {
          let view = UIView()
          view.backgroundColor = .black
          return view
      }()
    
    private lazy var indicatorWidth: Double = tabBar.bounds.width / CGFloat(tabBar.items?.count ?? 1)
    private var indicatorColor: UIColor = .black
    
    var menuButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.addSubview(indicatorView)
      //  self.menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: tabBar.bounds.height / 1.7, height: tabBar.bounds.height / 1.7))
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: self.tabBar.bounds.minY, width: self.tabBar.bounds.width, height: self.tabBar.bounds.height), cornerRadius: 10).cgPath
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        layer.shadowRadius = 25.0
        layer.shadowOpacity = 0.3
        layer.borderWidth = 1.0
        layer.opacity = 1.0
        layer.isHidden = false
        layer.masksToBounds = false
        layer.fillColor = UIColor.white.cgColor
        self.tabBar.layer.insertSublayer(layer, at: 0)
        
        tabBar.barTintColor = UIColor.white
        self.tabBar.backgroundColor = UIColor.clear
       // self.tabBar.itemWidth = (self.view.frame.width / 5) - 40
        self.tabBar.itemPositioning = .centered
        self.delegate = self
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundImage = nil
        self.tabBar.barStyle = UIBarStyle.black
        self.tabBar.setValue(true, forKey: "hidesShadow")
         self.tabBar.backgroundColor = .clear
        setupMiddleButton()
        guestTabBarSetup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Position the line indicator at the bottom of the selected tab item
        menuButton.frame = CGRect.init(x: self.tabBar.center.x - (self.tabBar.frame.size.height / 1.2 / 2) , y: (tabBar.bottom - tabBar.height / 0.7), width: self.tabBar.frame.size.height  , height: self.tabBar.frame.size.height)
        //self.view.bounds.height - (view.bottom - view.height / 1.15)
        self.view.bringSubviewToFront(self.menuButton)
      //  moveIndicator()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.menuButton.removeFromSuperview()
    }
    
    func setupMiddleButton() {
      
        _ = menuButton.frame

        menuButton.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        //menuButtonFrame

        menuButton.backgroundColor = .clear
       
        menuButton.setImage(UIImage(named: "TabIcon"), for: .normal)
     
        menuButton.borderWidth = 0

      //  menuButton.cornerRadius = 12

    
      //  menuButton.layer.cornerRadius = menuButto
        //(self.tabBar.frame.size.height / 1.7) / 2
       // menuButton.layer.borderColor = UIColor.ThemeYellow.cgColor
        view.addSubview(menuButton)

        menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)

        view.layoutIfNeeded()
    }
    
    @objc
    private func menuButtonAction(sender: UIButton) {
           selectedIndex = 2
        indicatorView.removeFromSuperview()
      //  appdelegate.generateMakentLoginFlowChange(tabIcon: 2)
      
       }
    
    func moveIndicator(at index: Int=0) {
        let itemWidth = (tabBar.bounds.width / CGFloat(tabBar.items?.count ?? 1))
        let xPosition = (CGFloat(index) * itemWidth) + ((itemWidth / 2) - (indicatorWidth / 2))

        UIView.animate(withDuration: 0.3) { [self] in
            self.indicatorView.frame = CGRect(x: xPosition,
                                              y: 1,
                                              width: self.indicatorWidth,
                                              height: 1)
            self.indicatorView.backgroundColor = self.indicatorColor
        }
    }
    
    func guestTabBarSetup(_ index:Int? = 0) {
        
        //let storyboard = UIStoryboard(name: "TabBarItems", bundle: nil)
        let lang1 = Language.getCurrentLanguage().getLocalizedInstance()
        UITabBar.appearance().tintColor =  UIColor.appHostThemeColor
        UITabBar.appearance().barTintColor = UIColor.white
        //SharedVariables.sharedInstance.homeType = HomeType.all
        
        //MARK: - HOME
        
        let homeTabVC = UIViewController()
        homeTabVC.view.backgroundColor = .label
        //HomeVc.initWithStory()
      
        homeNavigation = UINavigationController(rootViewController: homeTabVC)
        let controller1 = UIViewController()
        
        controller1.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        let nav1 = UINavigationController(rootViewController: homeTabVC)
        
        let icon1 = UITabBarItem(title: lang1.expl_Title.capitalized, image: UIImage(named: "ic_search"), selectedImage: UIImage(named: "ic_search"))
        nav1.tabBarItem = icon1
        
        //MARK: - WishList
        
        let controller2 = UIViewController()
        controller2.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 2)
        let wishlistVC = UIViewController()
        wishlistVC.view.backgroundColor = .yellow
      
        
        let nav2 = UINavigationController(rootViewController: wishlistVC)
        
        let icon2 = UITabBarItem(title: "Saved", image: UIImage(named: "ic_heart"), selectedImage: UIImage(named: "ic_heart"))
        nav2.tabBarItem = icon2
        
        //MARK: - Trips
        
        let controller3 = UIViewController()
        controller3.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 3)
        let tripsVC = ExploreVC.initWithStory()
        tripsVC.view.backgroundColor = .gray
   
        
        let nav3 = UINavigationController(rootViewController: tripsVC)
        
        let icon3 = UITabBarItem(title: "", image: UIImage(named: "ic_trips"), selectedImage: UIImage(named: "ic_trips"))
        nav3.tabBarItem = icon3
        
        //MARK: - Inbox
        
        let controller4 = UIViewController()
        controller4.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 4)
        let inboxVC = UIViewController()
        inboxVC.view.backgroundColor = .systemTeal
      
        
        let nav4 = UINavigationController(rootViewController: inboxVC)
        
        let icon4 = UITabBarItem(title: "Inbox", image: UIImage(named: "ic_inbox"), selectedImage: UIImage(named: "ic_inbox"))
        nav4.tabBarItem = icon4
        
        //MARK: Profile or Login
        
        let controller5 = UIViewController()
        controller5.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 5)
        
        
//        let token = UserDefaults.standard.string(forKey: "Token2")
        
        let token = Constants().GETVALUE(keyname: "")
        var FirstVC = UIViewController()
        var ProfileTittle = "Profile"
        
        if token == "" {
            FirstVC = LoginVC.initWithStory()
            //UserInfoVC.initWithStory()
     
            //LoginVC.initWithStory()
//            let loginVC = LoginVc.initWithStory()
//            loginVC.hidesBottomBarWhenPushed = true
//            ProfileTittle = lang1.login_Title.capitalized
//            FirstVC = loginVC
            let inboxVC = UIViewController()
            inboxVC.view.backgroundColor = .systemBackground
        }else {
            let inboxVC = UIViewController()
            inboxVC.view.backgroundColor = .systemBackground
//            let accountStroyBoard = UIStoryboard(name: "ProfileMainStoryboard", bundle: nil)
//            let loginVC = accountStroyBoard.instantiateViewController(withIdentifier: "ProfileMainVC") as! ProfileMainVC
//             loginVC.ProfileVM = ProfileViewModel()
//            ProfileTittle = lang1.profi_Title.capitalized
//            FirstVC = loginVC
        }
        
               
        
    
        let nav5 = UINavigationController(rootViewController: FirstVC)
        
        let icon5 = UITabBarItem(title: ProfileTittle, image: UIImage(named: "ic_profile"), selectedImage: UIImage(named: "ic_profile"))
        nav5.tabBarItem = icon5
        
        nav1.isNavigationBarHidden = true
        nav2.isNavigationBarHidden = true
        nav3.isNavigationBarHidden = true
        nav4.isNavigationBarHidden = true
        nav5.isNavigationBarHidden = true
        let controllers = [nav1,nav2,nav3,nav4,nav5]
        self.viewControllers = controllers
        self.selectedIndex = index!
      //  setTitleAdjustment()
    }
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let items = tabBar.items else { return }
      //  if tabBar.
        if tabBar.selectedItem?.title == "" {
            indicatorView.removeFromSuperview()
            return
        } else {
            tabBar.addSubview(indicatorView)
            moveIndicator(at: items.firstIndex(of: item) ?? 0)
        }
    }
    
    
    
}
