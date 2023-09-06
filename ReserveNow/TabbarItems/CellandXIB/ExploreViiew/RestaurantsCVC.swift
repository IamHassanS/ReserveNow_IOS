//
//  RestaurantsCVC.swift
//  ReserveNow
//
//  Created by trioangle on 02/08/23.
//


import UIKit

class RestaurantsCVC: UICollectionViewCell {
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var imgViewCars: UIImageView!
    @IBOutlet weak var viewImgBg: UIView!
    @IBOutlet weak var imgWishList: UIImageView!
    @IBOutlet weak var lbLRating: UILabel!
    @IBOutlet weak var lblTripsCountPlace: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var starRating: UILabel!
    @IBOutlet weak var InstantBookimg: UIImageView!
    
    
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
        let path = UIBezierPath(roundedRect:imgViewCars.bounds,
                                byRoundingCorners:[.topRight, .topLeft],
                                cornerRadii: CGSize(width: 15, height:  15))

        let maskLayer = CAShapeLayer()

        maskLayer.path = path.cgPath
        imgViewCars.layer.mask = maskLayer
      //  viewBg.layer.cornerRadius = 15
        imgViewCars.clipsToBounds = true
        viewImgBg.clipsToBounds = true
        viewImgBg.layer.cornerRadius = 12
        imgViewCars.layer.cornerRadius = 12
        imgViewCars.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewImgBg.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
    }
}
