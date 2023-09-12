//
//  GetUserInfoVC.swift
//  ReserveNow
//
//  Created by trioangle on 12/09/23.
//

import UIKit

class GetUserInfoVC: BaseViewController {

    @IBOutlet var getUserInfoView: GetUserInfoView!
    var validate: validationTypes = .email
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getUserInfoView.validationType = self.validate
        // Do any additional setup after loading the view.
    }
    
    class func initWithStory(_ validationType: validationTypes) -> GetUserInfoVC {
        
        let loginVC : GetUserInfoVC = UIStoryboard.TabBarItems.instantiateViewController()
        loginVC.validate = validationType
        return loginVC
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
