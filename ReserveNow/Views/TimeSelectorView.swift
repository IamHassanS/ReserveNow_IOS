//
//  TimeSelectorView.swift
//  ReserveNow
//
//  Created by trioangle on 19/04/23.
//

import Foundation
import UIKit

enum SlotType {
    case morning
    case evening
    case noon
    case night
}

protocol TimeSelectorVCDelegate : AnyObject {
    func slotSelected(_ slot: SlotType)
}

class TimeSelectorView: BaseView {
    var timeVc: TimeSelectotVc!
    
  
    @IBOutlet weak var viewMorning: UIView!
    @IBOutlet weak var viewNoon: UIView!
    @IBOutlet weak var viewEvening: UIView!
    @IBOutlet weak var viewNight: UIView!
    @IBOutlet weak var contentHolderCurveView: UIView!
    
    @IBOutlet weak var viewBooktable: UIView!
    @IBOutlet weak var backHolderView: UIView!
    var slot: SlotType = .morning
    var isElevated = Bool()
    override func didLoad(baseVC: BaseViewController) {
        
        
        super.didLoad(baseVC: baseVC)
        self.timeVc = baseVC as? TimeSelectotVc
        
         setupUI()
         initViews()
    }
    
    func setupUI() {
        contentHolderCurveView.setSpecificCornersForTop(cornerRadius: self.height / 15)
        contentHolderCurveView.elevate(4, shadowColor: .lightGray, opacity: 0.5)
        backHolderView.elevate(4, shadowColor: .lightGray, opacity: 0.5)
        backHolderView.layer.cornerRadius = self.backHolderView.height / 2.3
        viewBooktable.elevate(4)
        viewBooktable.layer.cornerRadius = 15
    }
    
    func initViews() {
        self.viewBooktable.addTap {
            self.timeVc.delegate?.slotSelected(self.slot)
            self.timeVc.dismiss(animated: true)
        }
        
        viewMorning.addTap {
            self.slot = .morning
            self.viewMorning.elevate(4)
            self.viewNoon.elevate(0)
            self.viewEvening.elevate(0)
            self.viewNight.elevate(0)
        }
        viewNoon.addTap {
            self.slot = .noon
            self.viewMorning.elevate(0)
            self.viewNoon.elevate(4)
            self.viewEvening.elevate(0)
            self.viewNight.elevate(0)
        }
        viewEvening.addTap {
            self.slot = .evening
            self.viewMorning.elevate(0)
            self.viewNoon.elevate(0)
            self.viewEvening.elevate(4)
            self.viewNight.elevate(0)
        }
        viewNight.addTap {
            self.slot = .night
            self.viewMorning.elevate(0)
            self.viewNoon.elevate(0)
            self.viewEvening.elevate(0)
            self.viewNight.elevate(4)
        }
        backHolderView.addTap {
            self.timeVc.dismiss(animated: true)
        }
    }
}

