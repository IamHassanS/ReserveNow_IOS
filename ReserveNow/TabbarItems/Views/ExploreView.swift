//
//  Views.swift
//  ReserveNow
//
//  Created by trioangle on 01/08/23.
//

import Foundation
import UIKit

extension ExploreView: MenuResponseProtocol {
    func routeToView(_ view: UIViewController) {
        print("")
    }
    
    func callAdminForManualBooking() {
        print("")
    }
    
    func openThemeActionSheet() {
        print("")
    }
    
    func changeFont() {
        print("")
    }
    
    func routeToHome(_ view: UIViewController) {
        print("")
    }
    
    
}

class ExploreView: BaseView {
    
    var exploreVC: ExploreVC!
    var index: Int = 0
    var data = [String]()
    private var indexOfCellBeforeDragging = 0
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var baseScrollView: UIScrollView!
    @IBOutlet weak var holderView: UIView!
    var isForCategory: Bool = false
    @IBOutlet weak var exploreLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var categoryLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionViewExplore: UICollectionView!
    @IBOutlet weak var collectionViewCategory: UICollectionView!
    
    @IBOutlet weak var menuHolderView: UIView!
    
    override func didLoad(baseVC: BaseViewController) {
        
        
            super.didLoad(baseVC: baseVC)
            self.exploreVC = baseVC as? ExploreVC
        Shared.instance.showLoader(in: self)
           //  setupUI()
           //  initViews()
            //cellRegistration()
            // toLoadData()
        cellregistration()
        toLOadData()
        setupUI()
        initView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            Shared.instance.removeLoader(in: self)
        }
        }
    
    func initView() {
        menuHolderView.addTap {
            print("::>--Tapped-->::")
            let menuvc = MenuVC.initWithStory(self)
            self.exploreVC.modalPresentationStyle = .overCurrentContext
            self.exploreVC.present(menuvc, animated: true)
        }
    }
    
    func setupUI() {
        if let layout = self.collectionViewExplore.collectionViewLayout as? UICollectionViewFlowLayout {

            layout.scrollDirection = .horizontal

        }
        
        if let layout = self.collectionViewCategory.collectionViewLayout as? UICollectionViewFlowLayout {

            layout.scrollDirection = .horizontal

        }
        self.collectionViewExplore.showsHorizontalScrollIndicator = false
        self.collectionViewCategory.showsHorizontalScrollIndicator = false
    }
    
    
    override func didLayoutSubviews(baseVC: BaseViewController) {
     
        self.collectionViewCategory.layoutIfNeeded()
        self.collectionViewExplore.layoutIfNeeded()
      
       self.collectionViewExplore.centerContentHorizontalyByInsetIfNeeded(minimumInset: UIEdgeInsets.init(top: 8, left: 15, bottom: 8, right: 15))
        self.collectionViewCategory.centerContentHorizontalyByInsetIfNeeded(minimumInset: UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15))
    }
    
    func toLOadData() {
 
        self.collectionViewCategory.dataSource = self
        self.collectionViewCategory.delegate = self
        self.collectionViewCategory.reloadData()
        
        
    
        self.collectionViewExplore.dataSource = self
        self.collectionViewExplore.delegate = self
        self.collectionViewExplore.reloadData()
    }
    
    func cellregistration() {
        collectionViewExplore.register(EmptyReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "EmptyReusableView")
        
       

        self.collectionViewExplore.register(UINib.init(nibName: "RestaurantsCVC", bundle: nil), forCellWithReuseIdentifier: "RestaurantsCVC")
        self.collectionViewCategory.register(UINib.init(nibName: "CategoriesCVC", bundle: nil), forCellWithReuseIdentifier: "CategoriesCVC")
    }
    
    private func calculateSectionInset() -> CGFloat {
        if isForCategory {
            let deviceIsIpad = UIDevice.current.userInterfaceIdiom == .pad
            let deviceOrientationIsLandscape = UIDevice.current.orientation.isLandscape
            let cellBodyViewIsExpended = deviceIsIpad || deviceOrientationIsLandscape
            let _: CGFloat =  (self.collectionViewCategory.frame.size.width / 1.46) + (cellBodyViewIsExpended ? 174 : 0)
            
       //     let buttonWidth: CGFloat = 50
            
            let inset = 0
            //(collectionViewCategory.frame.width - cellBodyWidth) / 5
         
            return CGFloat(inset)
        } else {
            let deviceIsIpad = UIDevice.current.userInterfaceIdiom == .pad
            let deviceOrientationIsLandscape = UIDevice.current.orientation.isLandscape
            let cellBodyViewIsExpended = deviceIsIpad || deviceOrientationIsLandscape
            let cellBodyWidth: CGFloat =  (self.collectionViewExplore.frame.size.width/1.12) + (cellBodyViewIsExpended ? 174 : 0)
            
       //     let buttonWidth: CGFloat = 50
            
            let inset = (collectionViewExplore.frame.width - cellBodyWidth) / 5
            return inset
        }
        

    }
    
//    private func configureCollectionViewLayoutItemSize() {
//
//        if isForCategory {
//
//
//            let inset: CGFloat = calculateSectionInset() // This inset calculation is some magic so the next and the previous cells will peek from the sides. Don't worry about it
//            categoryLayout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
//
//            categoryLayout.itemSize = CGSize(width: (self.collectionViewCategory.frame.size.width / 1.46) - inset * 2, height: (collectionViewCategory.frame.size.height / 2))
//
//        } else {
//            let inset: CGFloat = calculateSectionInset() // This inset calculation is some magic so the next and the previous cells will peek from the sides. Don't worry about it
//            exploreLayout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
//
//            exploreLayout.itemSize = CGSize(width: (self.collectionViewExplore.frame.size.width/1.12) - inset * 2, height: 288)
//        }
//
//
//    }
    
    private func indexOfMajorCell() -> Int {
        //dont reduce or increae cell size will affect paging.
        if isForCategory {
            
            let inset: CGFloat = calculateSectionInset()
            let itemWidth = (self.collectionViewCategory.frame.size.width / 1.46) - inset * 2
            let proportionalOffset = collectionViewCategory.contentOffset.x / itemWidth
            let index = Int(round(proportionalOffset))
            let safeIndex = max(0, min(data.count, index))
            return safeIndex
        } else {
            
            let inset: CGFloat =  calculateSectionInset()
            let itemWidth = (self.collectionViewExplore.frame.size.width/1.12) - inset * 2
            //
            var proportionalOffset = collectionViewExplore.contentOffset.x / itemWidth
            //let index = Int(round(proportionalOffset))
      
            var index: Int = 0
        
          
               // proportionalOffset = proportionalOffset - 0.5
         
                index = Int(proportionalOffset.rounded(.up))
          
           
            let safeIndex = max(0, min(data.count - 1, index))
            return safeIndex
        }

    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
       // self.topBarViewVisibility(scrollView)
        if let collect = scrollView as? UICollectionView {
            if collect == self.collectionViewExplore {
                self.isForCategory = false
                indexOfCellBeforeDragging = indexOfMajorCell()
            }   else if collect == self.collectionViewCategory {
                self.isForCategory = true
                indexOfCellBeforeDragging = indexOfMajorCell()
            }
        }


    }
    
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        if scrollView == scrollView as? UICollectionView {
            if scrollView == self.collectionViewExplore {
                self.isForCategory = false
                // Stop scrollView sliding:
                targetContentOffset.pointee = scrollView.contentOffset

                // calculate where scrollView should snap to:
                let indexOfMajorCell = self.indexOfMajorCell()

                // calculate conditions:
                let swipeVelocityThreshold: CGFloat = 1 // after some trail and error
                let hasEnoughVelocityToSlideToTheNextCell = indexOfCellBeforeDragging + 1 < data.count && velocity.x > swipeVelocityThreshold
                if indexOfCellBeforeDragging == 12 {

                }
                let hasEnoughVelocityToSlideToThePreviousCell = indexOfCellBeforeDragging - 1 >= 0 && velocity.x < -swipeVelocityThreshold
                let majorCellIsTheCellBeforeDragging = indexOfMajorCell == indexOfCellBeforeDragging
                let didUseSwipeToSkipCell = majorCellIsTheCellBeforeDragging && (hasEnoughVelocityToSlideToTheNextCell || hasEnoughVelocityToSlideToThePreviousCell)

                if didUseSwipeToSkipCell {

                    let snapToIndex = indexOfCellBeforeDragging + (hasEnoughVelocityToSlideToTheNextCell ? 1 : -1)
                    let inset: CGFloat = calculateSectionInset()
                    let itemWidth =  collectionViewExplore.frame.size.width - inset * 2
                    let toValue = itemWidth * CGFloat(snapToIndex)

                  print(snapToIndex)
                    let indexPath = IndexPath(row: snapToIndex, section: 0)
                    self.collectionViewExplore.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)

                    // Damping equal 1 => no oscillations => decay animation:
//                    UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: velocity.x, options: .allowUserInteraction, animations: {
//                        scrollView.contentOffset = CGPoint(x: toValue, y: 0)
//                        scrollView.layoutIfNeeded()
//                    }, completion: nil)

                } else {
                    // This is a much better way to scroll to a cell:

                  //  index = index + 1
                    let celltoScroll: Int = indexOfMajorCell
                   // print(exploreData.data[celltoScroll])
                    let indexPath = IndexPath(row: celltoScroll, section: 0)
                    self.collectionViewExplore.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                }
            }    else  if scrollView == self.collectionViewCategory {
                self.isForCategory = true
                // Stop scrollView sliding:
                targetContentOffset.pointee = scrollView.contentOffset

                // calculate where scrollView should snap to:
                let indexOfMajorCell = self.indexOfMajorCell()
                // calculate conditions:
                let swipeVelocityThreshold: CGFloat = 1 // after some trail and error
                let hasEnoughVelocityToSlideToTheNextCell = indexOfCellBeforeDragging + 1 < self.data.count && velocity.x > swipeVelocityThreshold
                let hasEnoughVelocityToSlideToThePreviousCell = indexOfCellBeforeDragging - 1 >= 0 && velocity.x < -swipeVelocityThreshold
                let majorCellIsTheCellBeforeDragging = indexOfMajorCell == indexOfCellBeforeDragging
                let didUseSwipeToSkipCell = majorCellIsTheCellBeforeDragging && (hasEnoughVelocityToSlideToTheNextCell || hasEnoughVelocityToSlideToThePreviousCell)

                if didUseSwipeToSkipCell {

                    var snapToIndex = indexOfCellBeforeDragging + (hasEnoughVelocityToSlideToTheNextCell ? 1 : -1)
                    let inset: CGFloat = calculateSectionInset()
                    let itemWidth =  (self.collectionViewCategory.frame.size.width / 1.46) - inset * 2
                    let toValue = itemWidth * CGFloat(snapToIndex)

                  print(snapToIndex)
                    let celltoScroll: Int = snapToIndex * 2
                    let count = self.data.count
                    if  celltoScroll >= self.data.count {
                        let indexPath = IndexPath(row: count, section: 0)
                        self.collectionViewCategory.selectItem(at: indexPath, animated: true, scrollPosition: .right)
                    } else {
                        let indexPath = IndexPath(row: celltoScroll, section: 0)
                        self.collectionViewCategory.selectItem(at: indexPath, animated: true, scrollPosition: .left)
                    }

                   // print(exploreData.data[celltoScroll])



//                  celltoScroll = indexOfMajorCell
//
//                    // Damping equal 1 => no oscillations => decay animation:
//                    UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: velocity.x, options: .allowUserInteraction, animations: {
//                        scrollView.contentOffset = CGPoint(x: toValue, y: 0)
//                        scrollView.layoutIfNeeded()
//                    }, completion: nil)

                } else {
                    // This is a much better way to scroll to a cell:

                  //  index = index + 1
                    let celltoScroll: Int = indexOfMajorCell * 2
                    let indexPath = IndexPath(row: celltoScroll, section: 0)
                    self.collectionViewCategory.selectItem(at: indexPath, animated: true, scrollPosition: .left)
                   // let celltoScroll: Int = snapToIndex * 2
                    let count = self.data.count
                    if  celltoScroll >= self.data.count {
                        let indexPath = IndexPath(row: count, section: 0)
                        self.collectionViewCategory.selectItem(at: indexPath, animated: true, scrollPosition: .right)
                    } else {
                        let indexPath = IndexPath(row: celltoScroll, section: 0)
                        self.collectionViewCategory.selectItem(at: indexPath, animated: true, scrollPosition: .left)
                    }
                   // print(exploreData.data[celltoScroll])



                }
            }
        }

    }
    
    
    
}


extension ExploreView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionViewExplore{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantsCVC", for: indexPath) as! RestaurantsCVC
            
            cell.viewBg.elevate(4)
//            cell.viewBg.layer.cornerRadius = 15
//            cell.imgViewCars.layer.cornerRadius = 15
            return cell
        } else if collectionView == self.collectionViewCategory{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCVC", for: indexPath) as! CategoriesCVC
            cell.contentHolderView.elevate(1)
            
            cell.contentHolderView.layer.cornerRadius = 10
            return cell
            
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
  
         if collectionView == self.collectionViewExplore{
            return CGSize.init(width: (self.collectionViewExplore.frame.size.width/1.12), height: collectionViewExplore.height - 10)
            //288
            //self.view.frame.size.height * 0.365
        }
        else if collectionView == self.collectionViewCategory{
            return CGSize.init(width: (self.collectionViewCategory.frame.size.width / 1.46), height: collectionView.bounds.height / 2.2)
        }
        else {
            return CGSize.init(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = HomeVc.initWithStory()
        vc.hidesBottomBarWhenPushed = true
        self.exploreVC.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            
            if collectionView == self.collectionViewExplore{
                if let cell = collectionView.cellForItem(at: indexPath) as? RestaurantsCVC {
                    cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                }
           }
           else if collectionView == self.collectionViewCategory{
               if let cell = collectionView.cellForItem(at: indexPath) as? CategoriesCVC {
                   cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
               }
           }
            
     
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        
        
        
        UIView.animate(withDuration: 0.5) {
            
            
            if collectionView == self.collectionViewExplore{
                if let cell = collectionView.cellForItem(at: indexPath) as? RestaurantsCVC {
                    cell.transform = CGAffineTransform(scaleX: 1, y: 1)

                }
           }
           else if collectionView == self.collectionViewCategory{
               if let cell = collectionView.cellForItem(at: indexPath) as? CategoriesCVC {
                   cell.transform = CGAffineTransform(scaleX: 1, y: 1)

               }
           }
            
            
     
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        //1
        switch kind {
        //2
        case UICollectionView.elementKindSectionHeader:
            //3
            
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind,withReuseIdentifier: "EmptyReusableView",for: indexPath) as! EmptyReusableView
   

    
            return footer
            
        case UICollectionView.elementKindSectionFooter:
            
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind,withReuseIdentifier: "EmptyReusableView",for: indexPath) as! EmptyReusableView
            
            return footer
            
        default:
            fatalError("Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if collectionView == self.collectionViewCategory {
            return CGSize(width: self.width, height: self.height / 10)
        } else {
            return CGSize()
        }
       
    }
    
    
}


extension UICollectionView {
    func centerContentHorizontalyByInsetIfNeeded(minimumInset: UIEdgeInsets) {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout,
            layout.scrollDirection == .horizontal else {
                assertionFailure("\(#function): layout.scrollDirection != .horizontal")
                return
        }

        if layout.collectionViewContentSize.width > frame.size.width {
            contentInset = minimumInset
        } else {
            contentInset = UIEdgeInsets(top: minimumInset.top,
                                        left: (frame.size.width - layout.collectionViewContentSize.width) / 2,
                                        bottom: minimumInset.bottom,
                                        right: 0)
        }
    }
}
