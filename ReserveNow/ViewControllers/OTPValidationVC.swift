//
//  OTPValidationVC.swift
//  ReserveNow
//
//  Created by trioangle on 06/09/23.
//

import UIKit

class OTPValidationVC: BaseViewController {

    @IBOutlet var otpValidationView: OTPValidationView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    class func initWithStory() -> OTPValidationVC {
        let bookingvc : OTPValidationVC = UIStoryboard.Main.instantiateViewController()
       
        return bookingvc
    }
}
