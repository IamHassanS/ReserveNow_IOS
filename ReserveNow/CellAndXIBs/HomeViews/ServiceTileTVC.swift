//
//  ServiceListTVC.swift
//  GoferHandy
//
//  Created by Trioangle on 28/07/21.
//  Copyright © 2021 Vignesh Palanivel. All rights reserved.
//

import UIKit

class ServiceListTVC: UITableViewCell {

    //---------------------------------------
    // MARK: - Outlets
    //---------------------------------------
    
    @IBOutlet weak var exclusionImageView: UIImageView!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var contentStack: UIStackView!
    @IBOutlet weak var serviceTitleStack: UIStackView!
    @IBOutlet weak var serviceIcon: UIImageView!
    @IBOutlet weak var serviceTitleLbl: UILabel!
    @IBOutlet weak var serviceDescriptionLbl: UILabel!
    @IBOutlet weak var serviceImage: UIImageView!
    
    //---------------------------------------
    // MARK: - Local Variables
    //---------------------------------------
    

    
    //---------------------------------------
    // MARK: - View Controller Functions
    //---------------------------------------
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.setTheme()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.initLayer()
        }
    }
    
    func initLayer() {
        self.holderView.cornerRadius = 20
//        if isRTLLanguage {
//            self.serviceImage.roundCorners(corners: [.topLeft,.bottomLeft], radius: 20)
//            self.exclusionImageView.roundCorners(corners: .bottomLeft, radius: 20)
//        } else {
            self.serviceImage.roundCorners(corners: [.topRight,.bottomRight], radius: 20)
            self.exclusionImageView.roundCorners(corners: .bottomRight, radius: 20)
      //  }
        
        self.holderView.elevate(2)
    }
    
    func setTheme() {

    }
    

}
