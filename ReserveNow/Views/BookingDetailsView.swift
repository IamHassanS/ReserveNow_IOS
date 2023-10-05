//
//  BookingDetailsView.swift
//  ReserveNow
//
//  Created by trioangle on 07/08/23.
//

import Foundation
import UIKit

extension BookingDetailsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProfileVCV = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileVCV", for: indexPath) as! ProfileVCV
        cell.addTap {
            cell.circle.animateSpinner()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.width / 4, height: collectionView.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    
    }
    
    
}


class BookingDetailsView: BaseView, ProgressButtonDelegates {
    func didActivateProgress() {
        print("Swipe")
        self.tripProgressBtn.initialize(self, ProgressState.loading)
    }
    
    @IBOutlet weak var statusCollectionView: UICollectionView!
    var bookingDetailsVC: BookingDetailsVC!
    @IBOutlet weak var backholderView: UIView!
    @IBOutlet weak var tripProgressBtn : ProgressButton!
    override func didLoad(baseVC: BaseViewController) {
        self.bookingDetailsVC = baseVC as? BookingDetailsVC
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
            self.tripProgressBtn.initialize(self, ProgressState.normal)
            self.initView()
           // self.initNotification()
            
         
        }
    }
    
    func initView() {
        if let layout = self.statusCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {

            layout.scrollDirection = .horizontal

        }
        statusCollectionView.register(UINib(nibName: "ProfileVCV", bundle: nil), forCellWithReuseIdentifier: "ProfileVCV")
        statusCollectionView.delegate = self
        statusCollectionView.dataSource = self
        self.tripProgressBtn.setTitleColor(.appGuestThemeColor, for: .normal)
       // self.tripProgressBtn.titleLabel?.setFont(font: .medium(size: .BODY))
        backholderView.layer.cornerRadius = backholderView.height / 2
        backholderView.elevate(4)
        backholderView.addTap {
            self.bookingDetailsVC.navigationController?.popViewController(animated: true)
        }
    }
}
