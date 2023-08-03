

import UIKit

protocol MapFilterRoomCVCDelegate: AnyObject {
    func toPassWishListData(_ param: [String: Any])
}

class MapFilterRoomCVC: UICollectionViewCell {
    
    @IBOutlet weak var ratingStackView: UIStackView!
    @IBOutlet weak var instantBookIV: UIImageView!
    @IBOutlet weak var roomImageView: UIImageView!
    @IBOutlet weak var selectionLabel: UILabel!
    @IBOutlet weak var whishListButtonOutlet: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var covideImageView: UIImageView!
   
   weak var delegate: MapFilterRoomCVCDelegate?
    var wishListParam = [String: Any]()
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code


    }

    
}
