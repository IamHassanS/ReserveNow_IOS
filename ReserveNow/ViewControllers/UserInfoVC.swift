//
//  UserInfoVC.swift
//  ReserveNow
//
//  Created by trioangle on 06/09/23.
//

import UIKit

class UserInfoVC: BaseViewController {
    @IBOutlet weak var userinfoView: UserInfoView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    class func initWithStory() -> UserInfoVC {
        let userInfo : UserInfoVC = UIStoryboard.Main.instantiateViewController()
       
        return userInfo
    }

}
