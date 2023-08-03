//
//  ViewController.swift
//  ReserveNow
//
//  Created by trioangle on 18/04/23.
//

import UIKit

class HomeVc: BaseViewController {
    
    @IBOutlet var homeView: HomeView!
 
    let addressDict : [String: Any] = [
        "longitude": "30.31527",
        "latitude": "59.93688",
        "formatted1": "Nevskiy prospekt 10, Saint Petersburg",
        "formatted2": "Russian Federation"
    ]

    let tagsDict : [String: Any] = [
        "fish": true,
        "italian": true,
        "friends": true
    ]


    
    override func viewDidLoad() {
        super.viewDidLoad()
        let restaurantDict = [
            "name": "Grand Royal",
            "suggested": true,
            "address": addressDict,
            "tags": tagsDict,
            "category": "$$$$",
            "description": "Lorem ipsum dolor si.",
            "shortDescription": "an",
            "collectionName": "Relaxing with friends",
            "distance": "1324",
            "country": "Russian Federation",
            "Region": "North-West region",
            "city": "Saint Petersburg"
            ] as [String : Any]
      //  let dbconfig = DataBaseConfigure(addressDict: addressDict, tagsDict: tagsDict, restaurantDict: restaurantDict)
       //  dbconfig.toRetriveData()
    }
    
    
    class func initWithStory() -> HomeVc {
        let home : HomeVc = UIStoryboard.Main.instantiateViewController()
        return home
    }


}

