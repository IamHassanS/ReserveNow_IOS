//
//  ProfileVCV.swift
//  ReserveNow
//
//  Created by trioangle on 18/09/23.
//

import UIKit

class ProfileVCV: UICollectionViewCell {
    var check = true
    var  circle  = InstagramProfileSpinner()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .white
         circle = InstagramProfileSpinner(frame: CGRect(x: 0, y: 0, width: self.width, height: self.height))
        addSubview(circle)
        let url = URL(string: "https://images.pexels.com/photos/450271/pexels-photo-450271.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260")
        circle.avatarURL = url
       
        
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 10) { [self] in
//            circle.removeAnimation()
//        }
    }
}


