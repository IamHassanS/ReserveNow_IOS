//
//  WishListHeaderView.swift
//  CollectionView
//
//  Created by trioangle on 22/06/22.
//

import Foundation
import UIKit
final class EmptyReusableView: UICollectionReusableView {
    static let identifier = "EmptyReusableView"
    
    let wishlistLabel: UILabel = {
        let lbl = UILabel()
        if #available(iOS 13.0, *) {
            lbl.textColor = .label
        } else {
            // Fallback on earlier versions
        }
        lbl.text = "Wishlist"
        lbl.font = UIFont.systemFont(ofSize: 26, weight: .medium)
        lbl.numberOfLines = 0 //line wrap
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if #available(iOS 13.0, *) {
            backgroundColor = .systemBackground
        } else {
            // Fallback on earlier versions
        }
        clipsToBounds = true
        addSubViews()
       // addBtnActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(wishlistLabel)
    }
    
    private func addSubViews() {
        wishlistLabel.frame = CGRect(x: 18.75, y: 20, width: frame.size.width, height: frame.height)
    }
    

}
