//
//  CommonREsponseModel.swift
//  Makent
//
//  Created by trioangle on 27/04/23.
//

import Foundation

class CommonResponseModel: Codable {
    var statusCode: String
    var successMessage: String
    
    enum CodingKeys: String, CodingKey {
        case successMessage = "success_message"
        case statusCode = "status_code"
    }
    
    init(statusCode: String, successMessage: String) {
        self.statusCode = statusCode
        self.successMessage = successMessage
    }
    
    required init(from decoder : Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.statusCode = container.safeDecodeValue(forKey: .statusCode)
        self.successMessage = container.safeDecodeValue(forKey: .successMessage)
    }
    
    init() {
        self.statusCode = ""
        self.successMessage = ""
    }
}
