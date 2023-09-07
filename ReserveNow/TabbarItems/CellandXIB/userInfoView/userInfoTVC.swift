//
//  userInfoTVCTableViewCell.swift
//  ReserveNow
//
//  Created by trioangle on 06/09/23.
//

import UIKit

class userInfoTVC: UITableViewCell {

    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var holderView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        holderView.elevate(4)
        holderView.layer.cornerRadius = 10
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
