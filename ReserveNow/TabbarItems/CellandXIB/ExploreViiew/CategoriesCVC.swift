//
//  CategoriesCVC.swift
//  ReserveNow
//
//  Created by trioangle on 02/08/23.
//

import UIKit

//MARK: masked corners info

//layerMinXMinYCorner    top left corner
//layerMaxXMinYCorner    top right corner
//layerMinXMaxYCorner    bottom left corner
//layerMaxXMaxYCorner    bottom right corner

class CategoriesCVC: UICollectionViewCell {
    
    @IBOutlet weak var contentHolderView: UIView!
    @IBOutlet weak var imgViewCategory: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var lblDescription2: UILabel!
    
    @IBOutlet weak var lblDescription3: UILabel!
    
    @IBOutlet weak var lblDescription4: UILabel!
    
    
    
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgViewCategory.clipsToBounds = true
        imgViewCategory.layer.cornerRadius = 10
        imgViewCategory.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }

}
