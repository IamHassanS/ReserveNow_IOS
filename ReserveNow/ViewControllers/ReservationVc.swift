//
//  ReservationVc.swift
//  ReserveNow
//
//  Created by trioangle on 19/04/23.
//

import UIKit

class ReservationVc: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    class func initWithStory() -> ReservationVc {
        let reserve : ReservationVc = UIStoryboard.Main.instantiateViewController()
        return reserve
    }

}
