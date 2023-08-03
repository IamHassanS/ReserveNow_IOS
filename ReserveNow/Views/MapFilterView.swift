import Foundation
import UIKit
import MapKit
import CoreLocation

class MapFilterView: BaseView {
    
    var mapFilterVC: MapFilterVC!
    
    @IBOutlet weak var contentHolderVIew: UIView!
    @IBOutlet weak var gradView: UIView!
    @IBOutlet weak var googleMapView: MKMapView!
    var currentLocationStr = "Current location"
    var lat = Double()
    var long = Double()
    var isLocationFetched = Bool()
    @IBOutlet weak var backHolderView: UIView!
    var locationManager: CLLocationManager!
    override func didLoad(baseVC: BaseViewController) {
        super.didLoad(baseVC: baseVC)
        self.mapFilterVC = baseVC as? MapFilterVC
        initActions()
        setupUI()
        updateCurrentLocation()
        googleMapView.delegate = self
      //  getDirections()
     
    }
    
    func cellRegistration() {
      //  roomListCollectionView.register(UINib(nibName: "MapFilterRoomCVC", bundle: nil), forCellWithReuseIdentifier: "MapFilterRoomCVC")
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
            locationManager.delegate = self
        }

        locationManager.startUpdatingLocation()
        
    }
    
    func setupUI() {
       // if let layout = self.roomListCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
          //  layout.scrollDirection = .horizontal
     //   }
      
        self.backHolderView.elevate(4)
        self.backHolderView.layer.cornerRadius = backHolderView.height / 2
    }
    
    func initActions() {
        backHolderView.addTap {
            self.mapFilterVC.navigationController?.popViewController(animated: true)
        }
    }
    func toloadData() {
     
    }
    
    func getDirections() {
            let request = MKDirections.Request()
            // Source
            let sourcePlaceMark = getuserLocation()
            request.source = MKMapItem(placemark: sourcePlaceMark)
            // Destination
            let destPlaceMark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 10.793190, longitude: 78.686676))
        
        
                let annotation1 = MKPointAnnotation()
        annotation1.coordinate = CLLocationCoordinate2D(latitude: self.lat, longitude: self.long)
                self.googleMapView.addAnnotation(annotation1)
        
        
               let annotation2 = MKPointAnnotation()
               annotation1.coordinate = CLLocationCoordinate2D(latitude: 10.793190, longitude: 78.686676)
               self.googleMapView.addAnnotation(annotation2)
        
            request.destination = MKMapItem(placemark: destPlaceMark)
            // Transport Types
            request.transportType = [.automobile, .walking]

            let directions = MKDirections(request: request)
            directions.calculate { response, error in
                guard let response = response else {
                    print("Error: \(error?.localizedDescription ?? "No error specified").")
                    return
                }

                let route = response.routes[0]
                DispatchQueue.main.async {
                    self.googleMapView.addOverlay(route.polyline)
                }
                self.locationManager.stopUpdatingLocation()
              

                // …
            }
        }
    
    func getuserLocation() -> MKPlacemark {
       
            return MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: self.lat, longitude:  self.long ))
    
        
    }
}


extension MapFilterView: CLLocationManagerDelegate {

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let mUserLocation:CLLocation = locations[0] as CLLocation
        let center = CLLocationCoordinate2D(latitude: mUserLocation.coordinate.latitude, longitude: mUserLocation.coordinate.longitude)
        self.lat = mUserLocation.coordinate.latitude
        self.long = mUserLocation.coordinate.longitude
        let mRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        googleMapView.setRegion(mRegion, animated: true)
      //  centerLocationOnce = true
        // Get user's Current Location and Drop a pin
        
        
        // Simple Annotations
//        let annotation1 = MKPointAnnotation()
//        annotation1.coordinate = CLLocationCoordinate2D(latitude: 33.95, longitude: -117.34)
//        annotation1.title = "Example 0" // Optional
//        annotation1.subtitle = "Example 0 subtitle" // Optional
//        self.mapView.addAnnotation(annotation1)
//
//        let annotation2 = MKPointAnnotation()
//        annotation2.coordinate = CLLocationCoordinate2D(latitude: 32.78, longitude: -112.43)
//        annotation2.title = "Example 1" // Optional
//        annotation2.subtitle = "Example 1 subtitle" // Optional
//        self.mapView.addAnnotation(annotation2)
//
//        let annotation3 = MKPointAnnotation()
//        annotation3.coordinate = CLLocationCoordinate2D(latitude: 35.58, longitude: -107.00)
//        annotation3.title = "Example 2" // Optional
//        annotation3.subtitle = "Example 2 subtitle" // Optional
//        self.mapView.addAnnotation(annotation3)
        
//    let mkAnnotation: MKPointAnnotation = MKPointAnnotation()
//        mkAnnotation.coordinate = CLLocationCoordinate2DMake(mUserLocation.coordinate.latitude, mUserLocation.coordinate.longitude)
//        mkAnnotation.title = self.setUsersClosestLocation(mLattitude: mUserLocation.coordinate.latitude, mLongitude: mUserLocation.coordinate.longitude)
//        googleMapView.addAnnotation(mkAnnotation)
        self.isLocationFetched = true
        getDirections()
    }
    
    func setUsersClosestLocation(mLattitude: CLLocationDegrees, mLongitude: CLLocationDegrees) -> String {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: mLattitude, longitude: mLongitude)

        geoCoder.reverseGeocodeLocation(location) {
            (placemarks, error) -> Void in

            if let mPlacemark = placemarks{
                if let dict = mPlacemark[0].addressDictionary as? [String: Any]{
                    if let Name = dict["Name"] as? String{
                        if let City = dict["City"] as? String{
                            self.currentLocationStr = Name + ", " + City
                        }
                    }
                }
            }
        }
        return currentLocationStr
    }

    
    //MARK: - To Annotation for lower xcode versions 10 and below
    
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        // If you're showing the user's location on the map, don't set any view
//        if annotation is MKUserLocation { return nil }
//
//        let id = MKMapViewDefaultAnnotationViewReuseIdentifier
//
//        // Balloon Shape Pin (iOS 11 and above)
//        if let view = mapView.dequeueReusableAnnotationView(withIdentifier: id) as? MKMarkerAnnotationView {
//            // Customize only the 'Example 0' Pin
//            if annotation.title == "Example 0" {
//                view.titleVisibility = .visible // Set Title to be always visible
//                view.subtitleVisibility = .visible // Set Subtitle to be always visible
//                view.markerTintColor = .yellow // Background color of the balloon shape pin
//                view.glyphImage = UIImage(systemName: "plus.viewfinder") // Change the image displayed on the pin (40x40 that will be sized down to 20x20 when is not tapped)
//                // view.glyphText = "!" // Text instead of image
//                view.glyphTintColor = .black // The color of the image if this is a icon
//                return view
//            }
//        }
//
//        // Classic old Pin (iOS 10 and below)
//        if let view = mapView.dequeueReusableAnnotationView(withIdentifier: id) as? MKPinAnnotationView {
//            // Customize only the 'Example 0' Pin
//            if annotation.title == "Example 0" {
//                view.animatesDrop = true // Animates the pin when shows up
//                view.pinTintColor = .yellow // The color of the head of the pin
//                view.canShowCallout = true // When you tap, it shows a bubble with the title and the subtitle
//                return view
//            }
//        }
//
//        return nil
//    }
    
    
}

extension MapFilterView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        // Set the color for the line
        renderer.strokeColor = .label
        return renderer
    }
}


//MARK: - to add custom pins


//class DogAnnotationView: MKAnnotationView {
//    override var annotation: MKAnnotation? {
//        willSet {
//            // Resize image
//            let pinImage = UIImage(named: "dog")
//            let size = CGSize(width: 50, height: 50)
//            UIGraphicsBeginImageContext(size)
//            pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
//            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
//
//            // Add Image
//            self.image = resizedImage
//        }
//    }
//
//    override func didMoveToSuperview() {
//        super.didMoveToSuperview()
//
//        // Enable callout
//        canShowCallout = true
//
//        // Move the image a little bit above the point.
//        centerOffset = CGPoint(x: 0, y: -20)
//    }
//}

// regiser to class file

//self.mapView.register(DogAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)



