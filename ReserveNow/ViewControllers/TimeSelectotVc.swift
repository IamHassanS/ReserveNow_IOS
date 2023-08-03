//
//  TimeSelectotVc.swift
//  ReserveNow
//
//  Created by trioangle on 19/04/23.
//

import UIKit

class TimeSelectotVc: BaseViewController {

    
    
    @IBOutlet var timeSelectorView: TimeSelectorView!
    weak var delegate: TimeSelectorVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

    class func initWithStory() -> TimeSelectotVc {
        let home : TimeSelectotVc = UIStoryboard.Main.instantiateViewController()
        return home
    }

}
