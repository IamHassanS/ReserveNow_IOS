//
//  InfoCommentPopOverVC.swift
//  Gofer
//
//  Created by trioangle on 06/11/19.
//  Copyright © 2019 Trioangle Technologies. All rights reserved.
//

import UIKit

class InfoTVC: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension PopOverVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: InfoTVC = tableView.dequeueReusableCell(withIdentifier: "InfoTVC", for: indexPath) as! InfoTVC
        cell.titleLbl.text = strArr[indexPath.row]
        return cell
    }
    
    
}

class PopOverVC: UIViewController {
    
    
    @IBOutlet weak var contentTable: UITableView!
    
    let strArr = ["Edit", "Save", "Logout"]
    override func viewDidLoad() {
        super.viewDidLoad()
        toLOadData()
        // Do any additional setup after loading the view.
    }
    
    func toLOadData() {
        contentTable.delegate = self
        contentTable.dataSource = self
        contentTable.reloadData()
    }
    
    //MARK:- initWithStory
    class func initWithStory(preferredFrame size : CGSize,on host : UIView) -> PopOverVC{
        let infoWindow : PopOverVC = UIStoryboard.Main.instantiateViewController()
        infoWindow.preferredContentSize = size
        infoWindow.modalPresentationStyle = .popover
        let popover: UIPopoverPresentationController = infoWindow.popoverPresentationController!
        popover.delegate = infoWindow
        popover.sourceView = host
        popover.backgroundColor = UIColor(hex: "ECF2FB")
        popover.permittedArrowDirections = UIPopoverArrowDirection.up
        
        
        return infoWindow
    }

    
}
extension PopOverVC : UIPopoverPresentationControllerDelegate{
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}
extension UIViewController{
    func showPopOver(on host : UIView){
        let infoWindow = PopOverVC
            .initWithStory(preferredFrame: CGSize(width: self.view.frame.width,
                                                  height: 100),
                           on: host)
        self.presentInFullScreen(infoWindow, animated: true) {
            infoWindow.toLOadData()
        }
    }
}
