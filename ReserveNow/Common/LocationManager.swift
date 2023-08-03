//
//  LocationManager.swift
//  ReserveNow
//
//  Created by trioangle on 12/05/23.
//

//let indexSet: IndexSet = IndexSet(integer: 1)
//self.exploreView.experienceTable.reloadSections(indexSet, with: .none)


/// pop back n viewcontroller
//func popBack(_ nb: Int) {
//    if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
//        guard viewControllers.count < nb else {
//            self.navigationController?.popToViewController(viewControllers[viewControllers.count - nb], animated: true)
//            return
//        }
//    }
//}


//func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
//    UIView.animate(withDuration: 0.5) {
//        if let cell = collectionView.cellForItem(at: indexPath) as? VariantListCVC {
//            cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
//        }
//    }
//}
//
//func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
//    UIView.animate(withDuration: 0.5) {
//        if let cell = collectionView.cellForItem(at: indexPath) as? VariantListCVC {
//            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
//        }
//    }
//}


//override var isHighlighted: Bool {
//    didSet {
//        if isHighlighted {
//            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
//                self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
//            }, completion: nil)
//        } else {
//            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
//                self.transform = CGAffineTransform(scaleX: 1, y: 1)
//            }, completion: nil)
//        }
//    }
//}


/// MARK :- Map

//self.listCreateParams.amenities = self.AmenitiesDatas.filter({$0.isSelected}).compactMap({$0.id}).map{"\($0)"}.joined(separator: ",")

import Foundation
import MapKit
class LocationManager {
    var userCurrentCity = ""
    lazy var geocoder = CLGeocoder()
    var locationManager: CLLocationManager!
    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        // Update View

        if let error = error {
            print("Unable to Reverse Geocode Location (\(error))")
           // locationLabel.text = "Unable to Find Address for Location"

        } else {
            if let placemarks = placemarks, let placemark = placemarks.first {
                userCurrentCity = placemark.compactAddress ?? ""
          
               
            } else {
              //  locationLabel.text = "No Matching Addresses Found"
            
            }
        }
    }
    

    
    
    func updateCurrentLocation()
    {
        if locationManager == nil {
            locationManager = CLLocationManager()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            if CLLocationManager.locationServicesEnabled() {
                switch(CLLocationManager.authorizationStatus()) {
                case .notDetermined, .restricted, .denied:
                   // self.showAlert()
                   locationManager.requestWhenInUseAuthorization()
                    break
                case .authorizedAlways, .authorizedWhenInUse:
                   // self.showAlert()
                    locationManager.requestAlwaysAuthorization()
                @unknown default:
                    print("Error")
                  
                }
            } else {
                //self.showAlert()
                locationManager.requestAlwaysAuthorization()
            }
            //locationManager.delegate = self
        }

        locationManager.startUpdatingLocation()
        
    }
}



//extension LocationManager: CLLocationManagerDelegate {
//    func isEqual(_ object: Any?) -> Bool {
//        <#code#>
//    }
//
//    var hash: Int {
//        <#code#>
//    }
//
//    var superclass: AnyClass? {
//        <#code#>
//    }
//
//    func `self`() -> Self {
//        <#code#>
//    }
//
//    func perform(_ aSelector: Selector!) -> Unmanaged<AnyObject>! {
//        <#code#>
//    }
//
//    func perform(_ aSelector: Selector!, with object: Any!) -> Unmanaged<AnyObject>! {
//        <#code#>
//    }
//
//    func perform(_ aSelector: Selector!, with object1: Any!, with object2: Any!) -> Unmanaged<AnyObject>! {
//        <#code#>
//    }
//
//    func isProxy() -> Bool {
//        return false
//    }
//
//    func isKind(of aClass: AnyClass) -> Bool {
//        return false
//    }
//
//    func isMember(of aClass: AnyClass) -> Bool {
//        return false
//    }
//
//    func conforms(to aProtocol: Protocol) -> Bool {
//        return false
//    }
//
//    func responds(to aSelector: Selector!) -> Bool {
//        return false
//    }
//
//    var description: String {
//        <#code#>
//    }
//
//    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let locationArray = locations as NSArray
//
//        let locationObj = locationArray.lastObject as! CLLocation
//        let coord = locationObj.coordinate
//       // locationManager.stopUpdatingLocation()
//        LocalStorage.shared.setSting(.user_latitude, text: coord.latitude.description)
//        LocalStorage.shared.setSting(.user_longitude, text: coord.longitude.description)
//
//        let longitude: Double = LocalStorage.shared.getDouble(key: .user_longitude)
//        let latitude : Double = LocalStorage.shared.getDouble(key: .user_latitude)
//
//        let location = CLLocation(latitude: latitude, longitude: longitude)
//        // Geocode Location
//        self.geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
//            // Process Response
//            self.processResponse(withPlacemarks: placemarks, error: error)
//        }
//
//    }
//}


extension CLPlacemark {

    var compactAddress: String? {
            var result = ""

//            if let street = thoroughfare {
//                result += ", \(street)"
//            }

            if let city = locality {
                result += "\(city)"
            }

//            if let country = country {
//                result += ", \(country)"
//            }

            return result
    }

}
