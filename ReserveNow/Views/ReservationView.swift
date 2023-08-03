//
//  ReservationView.swift
//  ReserveNow
//
//  Created by trioangle on 19/04/23.
//

import Foundation
import UIKit




class ReservationView: BaseView {
    
    enum  TableType {
        case fourPerson
        case aboveFourPerson
    }
    
    
    func toSetTableType(_ tableType: TableType) {
        switch tableType {
            
        case .fourPerson:
            chairTransform4Person()
        case .aboveFourPerson:
            chairTransform6Person()
        }
    }
    @IBOutlet weak var plusBtnOutlet: UIButton!
    
    @IBOutlet weak var MinesBtnOutlet: UIButton!
    
    @IBOutlet weak var personcountView: UIView!
    
    @IBOutlet weak var sixPersonCountView: UIView!
    
    @IBOutlet weak var backHolderView: UIView!
    @IBOutlet weak var contentCurveView: UIView!
    @IBOutlet weak var scollView: UIScrollView!
    @IBOutlet weak var timeSelector: UIView!
    
    @IBOutlet weak var slotLabel: UILabel!
    
    @IBOutlet weak var reservationDatesFld: UITextField!
    @IBOutlet weak var reservationHolderView: UIView!
    @IBOutlet weak var FourpersonsView
    : UIView!
    
    
    @IBOutlet weak var sixpersonsView
    : UIView!
    
    @IBOutlet weak var topChair
    : UIImageView!
    
    @IBOutlet weak var rightChair
    : UIImageView!
    
    
    @IBOutlet weak var leftChair
    : UIImageView!
    
    
    @IBOutlet weak var bottomChair
    : UIImageView!
    
    @IBOutlet weak var sixPerRightTpo: UIImageView!
    
    
    @IBOutlet weak var sixPerTop: UIImageView!
    
    
    @IBOutlet weak var sixPerRightBottom: UIImageView!
    
    @IBOutlet weak var sixPerBottom: UIImageView!
    
    @IBOutlet weak var sixPerLeftBottom: UIImageView!
    
    @IBOutlet weak var sixPerLeftTop: UIImageView!
    
    @IBOutlet weak var bookTableView: UIView!
    
    @IBOutlet weak var countLbl: UILabel!
    
    @IBOutlet weak var sixPerCountLbl: UILabel!
    @IBOutlet weak var fourPerCountLbl: UILabel!
    var reserveVc: ReservationVc!
    var tableType: TableType = .fourPerson
    var IncresedCount = 1
    var MinIntraction = true
    var PlusIntraction = true
    var dobPicker:UIDatePicker?
    var dobAPIData: String?
    override func didLoad(baseVC: BaseViewController) {
        
        
        super.didLoad(baseVC: baseVC)
        self.reserveVc = baseVC as? ReservationVc
      //  toSetTableType(self.tableType)
         setupUI()
         initViews()
    }
    
    func setupUI() {
        toSetTableType(tableType)
        contentCurveView.elevate(4, shadowColor: .lightGray, opacity: 0.5)
        contentCurveView.setSpecificCornersForTop(cornerRadius: self.height / 20)
        scollView.setSpecificCornersForTop(cornerRadius: self.height / 20)
        backHolderView.elevate(4, shadowColor: .lightGray, opacity: 0.5)
        backHolderView.layer.cornerRadius = self.backHolderView.height / 2.3
        
        personcountView.layer.cornerRadius = self.personcountView.height / 2.3
        
        
        sixPersonCountView.layer.cornerRadius = self.personcountView.height / 3
        
        timeSelector.layer.cornerRadius = self.timeSelector.height / 4
        timeSelector.elevate(4, shadowColor: .lightGray, opacity: 0.5)
        
        reservationHolderView.layer.cornerRadius = self.reservationHolderView.height / 4
        reservationHolderView.elevate(4, shadowColor: .lightGray, opacity: 0.5)
        
        bookTableView.layer.cornerRadius = 15
        bookTableView.elevate(4, shadowColor: .lightGray, opacity: 0.5)
        plusBtnOutlet.setTitle("", for: .normal)
        MinesBtnOutlet.setTitle("", for: .normal)
        plusBtnOutlet.layer.cornerRadius = plusBtnOutlet.height / 2.3
        
        MinesBtnOutlet.layer.cornerRadius = MinesBtnOutlet.height / 2.3
        
    }
    
    func addDatePicker() {
        self.dobPicker = UIDatePicker()
        dobPicker?.datePickerMode = UIDatePicker.Mode.date
        if #available(iOS 13.4, *) {
            dobPicker?.preferredDatePickerStyle = .wheels
            }
        let calendar = Calendar(identifier: .gregorian)
      //  dobPicker?.locale = Language.getCurrentLanguage().locale
        let currentDate = Date()
        var comps = DateComponents()
        comps.year = -18
        let maxDate = calendar.date(byAdding: comps, to: currentDate)
        dobPicker?.maximumDate = maxDate
        dobPicker?.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControl.Event.valueChanged)
        reservationDatesFld.inputView = self.dobPicker
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.removeDatePicker))
        toolbar.setItems([spaceButton,doneButton], animated: false)
        reservationDatesFld.inputAccessoryView = toolbar
        reservationDatesFld.inputView = dobPicker
        
    }
    
    @objc func removeDatePicker() {
        self.reservationDatesFld.resignFirstResponder()
        self.dobPicker = nil
    }
    
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateFormat = "dd-MM-yyyy"
      //  dateFormatter.locale = Language.getCurrentLanguage().locale
        dateFormatter.calendar = .current
        reservationDatesFld.text = dateFormatter.string(from: sender.date)
        //dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.locale = Locale(identifier: "en_US")
        self.dobAPIData = dateFormatter.string(from: sender.date)
    }
    
    func  initViews() {
        reservationDatesFld.delegate = self
        self.countLbl.text = "1"
        backHolderView.addTap {
            self.reserveVc.navigationController?.popViewController(animated: true)
        }
        PlusBtnCheckStatus()
        
        timeSelector.addTap {
            let time = TimeSelectotVc.initWithStory()
            time.delegate = self
            time.view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
            time.modalPresentationStyle = .overCurrentContext
            self.reserveVc.present(time, animated: true)
        }
        
        
        
        plusBtnOutlet.addTapIntraction(Intraction: self.PlusIntraction) { [self] in
            
           
            self.IncresedCount += 1
            countLbl.text = "\(self.IncresedCount)"
            self.PlusBtnCheckStatus()
           
            
            
        }
        
        MinesBtnOutlet.addTapIntraction(Intraction: self.PlusIntraction) { [self] in
            
            
            if self.IncresedCount == 0 {
                self.MinIntraction = false
    //            self.IncresedCount = model.minimum_purchase_qty
                countLbl.text = "\(self.IncresedCount)"
    //            var totalPrice : Float = self.priceAmount * Float(self.IncresedCount)
    //            cell.TotalPriceValueLbl.text = "\(model.currency_symbol)\(String(format: "%.2f", totalPrice))"
                self.PlusBtnCheckStatus()
            } else {
                self.IncresedCount -= 1
               countLbl.text = "\(self.IncresedCount)"
    //            var totalPrice : Float = self.priceAmount * Float(self.IncresedCount)
    //            cell.TotalPriceValueLbl.text = "\(model.currency_symbol)\(String(format: "%.2f", totalPrice))"
                self.PlusBtnCheckStatus()
            }
            
        
            
            
           
            
        }
        
        
        
        
    }
    
    func chairTransform4Person() {
        
        UIView.transition(with: self.FourpersonsView, duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: { [self] in
            sixpersonsView.isHidden = true
            FourpersonsView.isHidden = false
                      })
        
    
        fourPerCountLbl.text = "\(countLbl.text!) persons"
        topChair.alpha = 1
        rightChair.alpha = 0.3
        leftChair.alpha = 0.3
        bottomChair.alpha = 0.3
        
        
        bottomChair.transform =  topChair.transform.rotated(by: .pi)        // 180˚

        rightChair.transform = topChair.transform.rotated(by: .pi / 2)    // 90˚

        leftChair.transform = topChair.transform.rotated(by: .pi * 1.5)  // 270˚
      
        if countLbl.text == "1" {
             
        } else   if countLbl.text == "1" {
            topChair.alpha = 1
        } else if countLbl.text == "2" {
            topChair.alpha = 1
            rightChair.alpha = 1
        } else if countLbl.text == "3" {
            topChair.alpha = 1
            rightChair.alpha = 1
            leftChair.alpha = 1
        } else if countLbl.text == "4" {
            topChair.alpha = 1
            rightChair.alpha = 1
            leftChair.alpha = 1
            bottomChair.alpha = 1
        }
    }
    
    func chairTransform6Person() {
        
        
        UIView.transition(with: self.sixpersonsView, duration: 1,
                          options: .transitionCrossDissolve,
                          animations: { [self] in
            FourpersonsView.isHidden = true
            sixpersonsView.isHidden = false
                      })
        
   
        sixPerCountLbl.text = "\(countLbl.text!) persons"
        sixPerBottom.alpha = 0.3
        sixPerLeftBottom.alpha = 0.3
        
        sixPerRightTpo.alpha = 1
        sixPerRightBottom.alpha = 1
        sixPerRightBottom.alpha = 1
        sixPerTop.alpha = 1
        
        sixPerBottom.transform = topChair.transform.rotated(by: .pi)
        sixPerRightTpo.transform = topChair.transform.rotated(by: .pi / 2)
        sixPerRightBottom.transform = topChair.transform.rotated(by: .pi / 2)
        
        sixPerLeftTop.transform = topChair.transform.rotated(by: .pi * 1.5)
        sixPerLeftBottom.transform = topChair.transform.rotated(by: .pi * 1.5)
        
        if countLbl.text == "5" {
            sixPerBottom.alpha = 1
        } else if countLbl.text == "6" {
            sixPerBottom.alpha = 1
            sixPerLeftBottom.alpha = 1
        }
        
    }
    
    
    
    

 //   self.IncresedCount =  ""
    
    func checkNextButtonStatus() {
        print("Checked")
    }
    
    func PlusBtnCheckStatus() {
        
        MinesBtnOutlet.isUserInteractionEnabled =  countLbl.text ==  "1" ? false : true
        plusBtnOutlet.isUserInteractionEnabled =
        countLbl.text == "6" ? false : true
        MinesBtnOutlet.tintColor = MinesBtnOutlet.isUserInteractionEnabled ? .black : .gray.withAlphaComponent(0.5)
        plusBtnOutlet.tintColor = plusBtnOutlet.isUserInteractionEnabled ? .black : .gray.withAlphaComponent(0.5)
        
        if countLbl.text == "5" || countLbl.text == "6" {
            self.toSetTableType(.aboveFourPerson)
        } else {
            self.toSetTableType(.fourPerson)
        }
        
    }
    
    
    
 
}



extension ReservationView: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.reservationDatesFld {
            self.addDatePicker()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("begin...")
    }
    
    @IBAction
    private func textFieldDidChange(textField: UITextField) {
        self.checkNextButtonStatus()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


extension ReservationView: TimeSelectorVCDelegate {
    func slotSelected(_ slot: SlotType) {
        self.slotLabel.text = "Selected"
    }
    
    
}
