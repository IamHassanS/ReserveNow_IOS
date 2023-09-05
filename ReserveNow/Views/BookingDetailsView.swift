//
//  BookingDetailsView.swift
//  ReserveNow
//
//  Created by trioangle on 07/08/23.
//

import Foundation
import UIKit
class BookingDetailsView: BaseView, ProgressButtonDelegates {
    func didActivateProgress() {
        print("Swipe")
        self.tripProgressBtn.initialize(self, ProgressState.normal)
    }
    
    var bookingDetailsVC: BookingDetailsVC!
    @IBOutlet weak var backholderView: UIView!
    @IBOutlet weak var tripProgressBtn : ProgressButton!
    override func didLoad(baseVC: BaseViewController) {
        self.bookingDetailsVC = baseVC as? BookingDetailsVC
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
            self.tripProgressBtn.initialize(self, ProgressState.normal)
            self.initView()
           // self.initNotification()
            
         
        }
    }
    
    func initView() {
        self.tripProgressBtn.setTitleColor(.appGuestThemeColor, for: .normal)
        self.tripProgressBtn.titleLabel?.setFont(font: .medium(size: .BODY))
        backholderView.layer.cornerRadius = backholderView.height / 2
        backholderView.elevate(4)
        backholderView.addTap {
            self.bookingDetailsVC.navigationController?.popViewController(animated: true)
        }
    }
}
