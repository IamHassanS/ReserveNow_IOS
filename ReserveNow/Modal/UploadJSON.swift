//
//  UploadJSON.swift
//  ReserveNow
//
//  Created by trioangle on 25/07/23.
//
import FirebaseDatabase
import Foundation
import Firebase


class Address: Codable {
    let formatted1: String?
    let formatted2 : String?
    let latitude: String?
    let longitude : String?
    
    enum CodingKeys: String, CodingKey {
        case formatted1 = "formatted1"
        case formatted2 = "formatted2"
        case latitude = "latitude"
        case longitude = "longitude"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.formatted1 = try container.decodeIfPresent(String.self, forKey: .formatted1)
        self.formatted2 = try container.decodeIfPresent(String.self, forKey: .formatted2)
        self.latitude = try container.decodeIfPresent(String.self, forKey: .latitude)
        self.longitude = try container.decodeIfPresent(String.self, forKey: .longitude)
    }
    
}

class Hotels: Codable {
    let region: String?
    let address: Address?
    let category: String?
    let city: String?
    let collectionName: String?
    let country: String?
    let description: String?
    let distance: Int?
    let name: String?
    let shortDescription: String?
    let suggested: String?
    
    
    enum CodingKeys: String, CodingKey {

        case region = "Region"
        case address = "address"
        case category = "category"
        case city = "city"
        case collectionName = "collectionName"
        case country = "country"
        case description = "description"
        case distance = "distance"
        case name = "name"
        case shortDescription = "shortDescription"
        case suggested = "suggested"

    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.region = try container.decodeIfPresent(String.self, forKey: .region)
        self.address = try container.decodeIfPresent(Address.self, forKey: .address)
        self.category = try container.decodeIfPresent(String.self, forKey: .category)
        self.city = try container.decodeIfPresent(String.self, forKey: .city)
        self.collectionName = try container.decodeIfPresent(String.self, forKey: .collectionName)
        self.country = try container.decodeIfPresent(String.self, forKey: .country)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.distance = try container.decodeIfPresent(Int.self, forKey: .distance)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.shortDescription = try container.decodeIfPresent(String.self, forKey: .shortDescription)
        self.suggested = try container.decodeIfPresent(String.self, forKey: .suggested)
    }
}

class DataBaseConfigure {
    
    private let dataBase = Database.database().reference()
    
    var addressDict = [String: Any]()

    var tagsDict = [String: Any]()

    var restaurantDict = [String: Any]()
    
    init(addressDict: [String: Any], tagsDict: [String: Any], restaurantDict: [String: Any]) {
        self.restaurantDict = restaurantDict
        self.addressDict = addressDict
        self.tagsDict = tagsDict
    }
    
    func toUploadData() {
        let restaurantsRef = self.dataBase.child("restaurants")
        restaurantsRef.setValue(restaurantDict)
    }
    
     func remove() {

        let ref = self.dataBase.child("restaurants")

        ref.removeValue { error, _ in

            print(error)
        }
    }
    
    func toCheckExistanceAndUpload() {
        dataBase.child("restaurants").observeSingleEvent(of: .value, with: { (snapshot) in

                if snapshot.exists(){

                   

                }else{

                    self.toUploadData()
                }

            })
    }
    
    func toRetriveData() {
        dataBase.child("restaurants").observeSingleEvent(of: .value, with: { (snapshot) in
                if snapshot.exists(){
                  //  print(snapshot.value)
                    guard let value = snapshot.value as? JSON else { return }
                    print(value)
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: value)
                        let instance = try JSONDecoder().decode(Hotels.self, from: jsonData)
                        print(instance)
                    } catch {
                        print(error)
                    }
                }else{
                    return
                   // self.toUploadData()
                }

            })
    }
    
    
    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonPetitions = try? decoder.decode(Hotels.self, from: json) {
            //   let hotels = jsonPetitions.results
            print(jsonPetitions)
            // tableView.reloadData()
        }
        }
    
}

