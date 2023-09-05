//
//  BookingDetailsVC.swift
//  ReserveNow
//
//  Created by trioangle on 07/08/23.
//

import UIKit

class BookingDetailsVC: BaseViewController {

    @IBOutlet var bookingDetailsView: BookingDetailsView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    class func initWithStory() -> BookingDetailsVC {
        let bookingvc : BookingDetailsVC = UIStoryboard.Main.instantiateViewController()
       
        return bookingvc
    }

}
