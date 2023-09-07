//
//  CountryListVCViewController.swift
//  ReserveNow
//
//  Created by trioangle on 07/09/23.
//

import UIKit



protocol CountryListVCDelegate: AnyObject {
    func countrySelected(_ selectedcode: String)
}


class countryTVC: UITableViewCell {
    
    @IBOutlet weak var codeLbl: UILabel!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    
    override class func awakeFromNib() {
        //
    }
}


class CountryListVC: BaseViewController {
    
    
    enum SwipeState {
      case full
      case middle
      case dismiss
    }

    enum TypeOfSwipe {
      case left
      case right
      case up
      case down
      case none
    }
    
    @IBOutlet weak var dismissView : UIView!
    @IBOutlet weak var hoverView : UIView!
    @IBOutlet weak var countryTable: UITableView!
    
    var currentState : SwipeState = .middle
    var currentSwipe : TypeOfSwipe = .none
    weak var delegate : CountryListVCDelegate?
    lazy var staticCountryArray : [CountryModel] = {
        let path = Bundle.main.path(forResource: "CallingCodes", ofType: "plist")
        let arrCountryList = NSMutableArray(contentsOfFile: path!)!
        
        let countriesArray : [CountryModel] = arrCountryList
                   .compactMap({$0 as? JSON})
                   .compactMap({CountryModel($0)})
        return countriesArray
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        print(staticCountryArray.count)
        self.currentState = .middle
        self.stateBasedAnimation(state: self.currentState)
        self.dismissView.backgroundColor = .clear
        toloadData()
        setupGesture()
        // Do any additional setup after loading the view.
    }
    
    
    func toloadData() {
        countryTable.delegate = self
        countryTable.dataSource = self
        countryTable.reloadData()
    }
    
    func setupGesture() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeDown.direction = .down
        self.hoverView.addGestureRecognizer(swipeDown)
    }
    
    func swipe(state: SwipeState,
               swipe: TypeOfSwipe) {
        switch state {
        case .full:
            switch swipe {
            case .down:
                self.currentState = .middle
            default:
                print("\(swipe) not Handled")
            }
        case .middle:
            switch swipe {
            case .down:
                self.currentState = .dismiss
            case .up:
                self.currentState = .full
            default:
                print("\(swipe) not Handled")
            }
        default:
            print("\(state) not Handled")
        }
        self.stateBasedAnimation(state: self.currentState)
    }
    
    @objc
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case .right:
                print("Swiped right")
                self.currentSwipe = .right
            case .down:
                print("Swiped down")
                self.currentSwipe = .down
            case .left:
                print("Swiped left")
                self.currentSwipe = .left
            case .up:
                print("Swiped up")
                self.currentSwipe = .up
            default:
                break
            }
            self.swipe(state: self.currentState,
                       swipe: self.currentSwipe)
        }
        
    }
    
    func stateBasedAnimation(state: SwipeState) {
      UIView.animate(withDuration: 0.7) {
        switch state {
        case .full:
          self.hoverView.transform = .identity
            self.hoverView.frame.size.height = self.view.frame.height + 30
          self.hoverView.removeSpecificCorner()
        case .middle:
            self.hoverView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.midY)
            self.hoverView.frame.size.height = (self.view.frame.height/2) + 30
      
        case .dismiss:
            self.hoverView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.maxY)
          self.hoverView.frame.size.height = 30
       
        }
      } completion: { (isCompleted) in
        if isCompleted && state == .dismiss {
          self.dismiss(animated: true) {
            print("Select Lanaguage is Completely Dismissed")
          }
        }
      }
    }

    class func initWithStory() -> CountryListVC {
        let loginVC : CountryListVC = UIStoryboard.TabBarItems.instantiateViewController()
        return loginVC
    }

}


extension CountryListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return staticCountryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let modal = staticCountryArray[indexPath.row]
        let cell: countryTVC = tableView.dequeueReusableCell(withIdentifier: "countryTVC", for: indexPath) as! countryTVC
        cell.codeLbl.text = modal.dial_code
        cell.nameLbl.text = modal.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let modal = staticCountryArray[indexPath.row]
        
        self.dismiss(animated: true) {
            Shared.instance.selectedPhoneCode = "\(modal.dial_code)"
            self.delegate?.countrySelected("\(modal.dial_code)")
        }
    }
    
    
}
