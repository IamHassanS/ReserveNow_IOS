

import Foundation

class BaseModel : Codable{
    var successmessage : String?
    var statuscode : String?
    let lists: [Lists]?

    
    
    enum CodingKeys: String, CodingKey {
        case successmessage = "success_message"
        case statuscode = "status_code"
        case lists = "Lists"

  
    }
    
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        successmessage = try values.decodeIfPresent(String.self, forKey: .successmessage)
        statuscode = try values.decodeIfPresent(String.self, forKey: .statuscode)
        lists = try values.decodeIfPresent(Array.self, forKey: .lists)
    }
    init() {
        successmessage = ""
        statuscode = ""
        lists = [Lists]()
    }
    

}


class Lists: Codable {
    let Title: String?
    let Key: String?
    
    
    enum CodingKeys: String, CodingKey {
        
        case Title = "Title"
        case Key = "Key"
        
        
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        Title = try values.decodeIfPresent(String.self, forKey: .Title)
        Key = try values.decodeIfPresent(String.self, forKey: .Key)
        
    }
    
    init() {
        Title = ""
        Key = ""
    }
}
    

