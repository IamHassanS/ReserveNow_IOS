//
//  LoginVC.swift
//  ReserveNow
//
//  Created by trioangle on 03/08/23.
//

import UIKit
import MobileCoreServices

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func chooseDocs() {
        let types = ["com.microsoft.word.doc","org.openxmlformats.wordprocessingml.document", kUTTypePDF as String]
//        ["com.adobe.pdf",
//                   "com.microsoft.word.doc",
//                    "com.microsoft.word.docx"
//                   ]
        //["com.microsoft.word.doc","org.openxmlformats.wordprocessingml.document", kUTTypePDF as String]
        let documentPicker = UIDocumentPickerViewController(documentTypes: types as [String], in: .import)
            documentPicker.delegate = self
            documentPicker.allowsMultipleSelection = true
        self.presentInFullScreen(documentPicker, animated: true, completion: nil)
    }

}


    
    extension LoginVC: UIDocumentMenuDelegate,UIDocumentPickerDelegate {
        public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let myURL = urls.first else {
                return
            }
           // self.documentURL = myURL
            print("import result : \(myURL)")

            
    //        let extens = NSURL(fileURLWithPath: "\(myURL)").pathExtension
    //        let uti = UTTypeCreatePreferredIdentifierForTag(
    //            kUTTagClassFilenameExtension,
    //            extens! as CFString,
    //            nil)
    //
    //        if UTTypeConformsTo((uti?.takeRetainedValue())!, kUTTypePDF) {
    //            print("This is an PDF")
    //        //    uploadRoomDocs(docurl: myURL, ispdf: true)
    //            uploadRoomImage(displayPic: UIImage(), docurl: myURL)
    //        } else {
    //
    //
    //        }
          //  uploadRoomImage(displayPic: UIImage(), docurl: myURL)
            
            
        
        
         //   uploadRoomImage(displayPic: UIImage(), docurl: myURL)
        }
              

        public func documentMenu(_ documentMenu:UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
            documentPicker.delegate = self
            present(documentPicker, animated: true, completion: nil)
        }


        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            print("view was cancelled")
            dismiss(animated: true, completion: nil)
        }
        
        
    }

