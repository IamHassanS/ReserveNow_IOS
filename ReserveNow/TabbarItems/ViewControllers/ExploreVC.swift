//
//  HomeVC.swift
//  Makent
//
//  Created by trioangle on 07/04/23.
//

import UIKit

class ExploreVC: BaseViewController {
    
    @IBOutlet var exploreview: ExploreView!
    
    var sharedAppDelegate = UIApplication.shared.delegate as? AppDelegate
    var appDelegate = UIApplication.shared.delegate as? AppDelegate
    
  
    var stretchableTableHeaderView : HFStretchableTableHeaderView! = nil
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    class func initWithStory() -> ExploreVC {
        let homeVC : ExploreVC = UIStoryboard.TabBarItems.instantiateViewController()
        return homeVC
    }
    

}
