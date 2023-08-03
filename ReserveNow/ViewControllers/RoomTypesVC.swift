//
//  RoomTypesVC.swift
//  Makent
//
//  Created by trioangle on 04/05/23.
//

import UIKit

class RoomTypesVC: BaseViewController {
    let homeModal = HomeViewModal()
    var roomOptions: RoomOptions?
    var pageType: RoomTypesView.PageTypes = .roomType
    var  data = [FilterAmenities]()
    var delegate: RoomTypesViewDelegate?
    @IBOutlet var roomTypeView: RoomTypesView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.roomTypeView.pageType = self.pageType
        
        // Do any additional setup after loading the view.
    }
    

    class func initWithStory() -> RoomTypesVC {
        let type : RoomTypesVC = UIStoryboard.guest_flow.instantiateViewController()
        return type
    }
    
    
    func toGetRoomOptions(_ param: [String: Any]? = [String: Any]()) {
        Shared.instance.showLoader(in: self.view, loaderType: .makentLoader)
 
        homeModal.toGetRoomOptions(params: param ??  [String: Any](), { (result) in
            switch result {
                
            case .success(let responseDict):
                if responseDict.statuscode == "1" {
                    Shared.instance.removeLoader(in: self.view)
                    dump(responseDict)
                    self.roomTypeView.roomOptions = responseDict.roomType!
                    self.roomOptions = responseDict
                   // self.roomTypeView.appendContents()
                    self.roomTypeView.toLoadData()
                } else {
                    Shared.instance.removeLoader(in: self.view)
                }
            case .failure(let error):
                Shared.instance.removeLoader(in: self.view)
                print("\(error.localizedDescription)")
            }
        })
    }
    
    
}
