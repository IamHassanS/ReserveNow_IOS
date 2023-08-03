//
//  RoomTypesView.swift
//  Makent
//
//  Created by trioangle on 04/05/23.
//

import Foundation

protocol RoomTypesViewDelegate: AnyObject {
    
    func conTentsSelected(_ isToload: Bool)
}

class RoomTypesView: BaseView {
    
    enum PageTypes {
        case roomType
        case PropertyType
        case amentitiyType
    }
    
    var roomTypesVC: RoomTypesVC!
    var roomOptions = [Types]()
    
    @IBOutlet weak var navigationVIew: UIView!
    @IBOutlet weak var backHolderView: UIView!
    @IBOutlet weak var tableHolderVIew: UIView!
    @IBOutlet weak var roomsTable: UITableView!
    @IBOutlet weak var saveHolderView: UIView!
    @IBOutlet weak var saveLbl: UILabel!
    var pageType: PageTypes = .roomType
   
    //let lang = Language.getCurrentLanguage().getLocalizedInstance()
    var selectedTypes = [String]()
    var selectedRoomOptions = ""
    override func didLoad(baseVC: BaseViewController) {
        super.didLoad(baseVC: baseVC)
        self.roomTypesVC = baseVC as? RoomTypesVC
        setupUI()
        initTaps()
        if pageType == .roomType {
            callAPI()
        }
        
        cellRegistration()
        
    }
    
    func toLoadData() {
        roomsTable.delegate = self
        roomsTable.dataSource = self
        roomsTable.reloadData()
    }
    func cellRegistration() {
        roomsTable.register(UINib(nibName: "FilterRoomOptionsTVC", bundle: nil), forCellReuseIdentifier: "FilterRoomOptionsTVC")
        roomsTable.register(CategoryTitleHeader.self, forHeaderFooterViewReuseIdentifier: CategoryTitleHeader.identifier)
        
    }
    
    func  callAPI() {
        var param = [String: Any]()
        param["token"] = LocalStorage.shared.getString(key: .access_token)
        self.roomTypesVC.toGetRoomOptions(param)
    }
    
    func setupUI() {
        roomsTable.separatorStyle = .none
        backHolderView.elevate(4)
        backHolderView.layer.cornerRadius = backHolderView.roundCorner
        
        saveHolderView.elevate(4)
        saveHolderView.layer.cornerRadius = 25
        
        saveHolderView.backgroundColor = .appHostThemeColor.withAlphaComponent(0.5)
        saveLbl.textColor = .systemBackground
        saveLbl.text = lang.save_Tit
        saveLbl.setFont(font: .medium(size: .BODY))
        saveHolderView.isUserInteractionEnabled = false
        
        if pageType == .roomType {
            
        } else {
            var isAnySelected = Bool()
            for i in 0...roomTypesVC.data.count - 1 {
                if self.roomTypesVC.data[i].isselected  {
                    isAnySelected = true
                }
            }
            if isAnySelected {
                checkBtnStatus(true)
            }
        }

    }
    
    func initTaps() {
        backHolderView.addTap {
            
            self.roomTypesVC.navigationController?.popViewController(animated: true)
        }
        
        saveHolderView.addTap {
            
            self.appendContents()
            self.roomTypesVC.delegate?.conTentsSelected(true)
            self.roomTypesVC.navigationController?.popViewController(animated: true)
        }
    }
    
    func appendContents() {
    
        if pageType == .roomType {
            for i in 0...roomOptions.count - 1 {
           
                if roomOptions[i].isselected {
                  
                    self.selectedTypes.append("\(roomOptions[i].id!)")
                }
            }
            selectedRoomOptions = selectedTypes.joined(separator: ",")
            Shared.instance.selectedRoomID = selectedRoomOptions
        } else  {
            for i in 0...self.roomTypesVC.data.count - 1 {
            
                if self.roomTypesVC.data[i].isselected {
                  
                    self.selectedTypes.append("\(self.roomTypesVC.data[i].id!)")
                }
            }
            selectedRoomOptions = selectedTypes.joined(separator: ",")
            if pageType == .amentitiyType  {
                Shared.instance.selectedAmenitiesID = selectedRoomOptions
            } else if pageType == .PropertyType {
                Shared.instance.selectedPropertyID = selectedRoomOptions
            }
          
        }
        
        

    }
    
    func checkBtnStatus(_ isSelected: Bool) {
        if isSelected {
            saveHolderView.backgroundColor = .appHostThemeColor
            saveHolderView.isUserInteractionEnabled = true
        } else {
            saveHolderView.backgroundColor = .appHostThemeColor.withAlphaComponent(0.5)
            saveHolderView.isUserInteractionEnabled = false
        }
   
    }
}


extension RoomTypesView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if pageType == .roomType {
            return self.roomOptions.count
        } else {
            return self.roomTypesVC.data.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FilterRoomOptionsTVC = roomsTable.dequeueReusableCell(withIdentifier: "FilterRoomOptionsTVC", for: indexPath) as! FilterRoomOptionsTVC
        
        cell.noteLbl.isHidden = true
        cell.delegate = self
        cell.selfIndex = indexPath.row
        
        if self.pageType == .roomType {
            let modal = roomOptions[indexPath.row]
            
            cell.optionsTit.text = modal.name!
            if modal.isShared  == "Yes"
            {
                cell.noteLbl.isHidden = false
                cell.noteLbl.text = "\(lang.shareroom_Msg)"
            }
            
            if modal.isselected {
                print("Highlight::")
                cell.noteLbl.textColor = .appHostThemeColor
                cell.optionsTit.textColor = .appHostThemeColor
            }
            else {
                print("Not to Highlight::")
                cell.noteLbl.updateTextColor()
                cell.optionsTit.updateTextColor()
                
            }
        } else {
            let modal = self.roomTypesVC.data[indexPath.row]
            cell.noteLbl.isHidden = true
            cell.delegate = self
            cell.selfIndex = indexPath.row
            cell.optionsTit.text = modal.name!
            if modal.isselected {
                print("Highlight::")
                cell.noteLbl.textColor = .appHostThemeColor
                cell.optionsTit.textColor = .appHostThemeColor
            }
            else {
                print("Not to Highlight::")
                cell.noteLbl.updateTextColor()
                cell.optionsTit.updateTextColor()
                
            }
        }
        
        
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableHolderVIew.height / 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: CategoryTitleHeader.identifier) as! CategoryTitleHeader
        header.titleLbl.setFont(font: .bold(size: .HEADER))
        if pageType == .PropertyType {
            header.titleLbl.text = lang.prop_Tit
        } else if pageType == .amentitiyType {
            header.titleLbl.text = lang.amenit_Tit
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if pageType == .roomType {
            return CGFloat()
        } else {
            return  tableView.frame.size.height / 12
        }
    }
    
}


extension RoomTypesView: FilterRoomOptionsTVCDelegate {
    func selectedType(_ index: Int) {
        print("Selected")
        if pageType == .roomType {
            roomOptions[index].isselected = roomOptions[index].isselected ? false : true
            
            var isAnySelected = Bool()
            for i in 0...roomOptions.count - 1 {
                if self.roomOptions[i].isselected && !isAnySelected {
                    isAnySelected = true
                }
            }
            
            if !roomOptions[index].isselected && !isAnySelected{
                self.checkBtnStatus(false)
            } else {
                self.checkBtnStatus(true)
            }
            self.roomsTable.reloadData()
          
        } else {
            self.roomTypesVC.data[index].isselected = self.roomTypesVC.data[index].isselected ? false : true
            var isAnySelected = Bool()
            for i in 0...roomTypesVC.data.count - 1 {
                if self.roomTypesVC.data[i].isselected  {
                    isAnySelected = true
                }
            }
            if !self.roomTypesVC.data[index].isselected && !isAnySelected {
                self.checkBtnStatus(false)
            } else {
                self.checkBtnStatus(true)
            }
            self.roomsTable.reloadData()
        }
        
    }
    

    
    
}
