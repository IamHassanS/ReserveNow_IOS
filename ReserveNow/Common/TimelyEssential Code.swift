//
//  TimelyEssential Code.swift
//  ReserveNow
//
//  Created by trioangle on 03/08/23.
//

import Foundation
// MARK: TextField Delegate Method
//@IBAction private func textFieldDidChange(textField: UITextField)
//{
//    if textField.tag == 1 {
//        self.passwordFieldErrLblHolderView.isHidden = (txtFldPassword.text?.count)!>8 && txtFldPassword.text?.containsSpecialCharacter ?? false || textField.text?.count == 0
//        //?? false && txtFldPassword.text?.isAlphanumeric ?? false && txtFldPassword.text?.isUpperCased ?? false
//    } else if textField.tag == 2 {
//        self.confirmPasswordFieldErrLblHolderView.isHidden = txtFldConfirmPassword.text == txtFldPassword.text
//        //(txtFldConfirmPassword.text?.count)!>5 || textField.text?.count == 0
//    } else {
//
//    }
//    self.checkNextButtonStatus()
//}
//
//
//func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
//{
//    if range.location == 0 && (string == " ") {
//        return false
//    }
//    if (string == "") {
//        return true
//    }
//    else if (string == " ") {
//        return false
//    }
//    else if (string == "\n") {
//        textField.resignFirstResponder()
//        return false
//    }
//
//    return true
//}


import CoreGraphics
import UIKit

enum ProgressState{
    case normal
    case loading
}

protocol ProgressButtonDelegates {
    func didActivateProgress()
}
class ProgressButton : UIButton{
    
}
