//
//  MapFilterVC.swift
//  ReserveNow
//
//  Created by trioangle on 15/05/23.
//

import UIKit
import MapKit
//import GoogleMaps

class MapFilterVC: BaseViewController {

    @IBOutlet var mapFilterView: MapFilterView!
    let appdelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
    class func initWithStory() -> MapFilterVC {
        let exploreVc : MapFilterVC = UIStoryboard.Main.instantiateViewController()
        return exploreVc
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
