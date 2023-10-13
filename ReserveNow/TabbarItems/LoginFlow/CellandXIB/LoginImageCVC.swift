//
//  LoginImageCVC.swift
//  ReserveNow
//
//  Created by trioangle on 13/10/23.
//

import UIKit

class LoginImageCVC: UICollectionViewCell {
    
    @IBOutlet weak var contentHolderView: UIView!
    
    @IBOutlet weak var imageHolderVIew: UIView!
    
    @IBOutlet weak var imageIV: UIImageView!
    
    @IBOutlet weak var descriptionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        

    }
    
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
                    self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                }, completion: nil)
            } else {
                UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
                    self.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion: nil)
            }
        }
    }
    

}
