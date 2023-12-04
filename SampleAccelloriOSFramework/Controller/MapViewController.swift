//
//  MapViewController.swift
//  SampleProject
//
//  Created by Admin on 18/11/23.
//

import UIKit
import MapKit

@objc public class MapViewController: UIViewController {
    
    var locationsDataArray = [RaceTracLocationInfo]()

    @IBOutlet weak var mapView: MKMapView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let locationsDataString = UserDefaults.standard.string(forKey: "LOCATIONS_DATA")

        if let reversedData = locationsDataString!.data(using: .utf8),
            let reversedArray = try? JSONDecoder().decode([RaceTracLocationInfo].self, from: reversedData) {
            self.locationsDataArray = reversedArray
        }
        
//        locationsDataArray  = [
//            RaceTracLocationInfo(
//                locationId: 1,
//                city: "Hiram",
//                address: "4597 Jimmy Lee Smith Pkwy Hiram, Georgia 30141",
//                storeId: "610",
//                lat: 33.8909475,
//                log: -84.7514216,
//                distance: "2.1 MI",
//                regularPrice: "$2.999",
//                dieselPrice: "$3.899",
//                amenities: ["Swirl World", "Pizza", "Seating Area", "Free WiFi"],
//                fuelOptions: ["Regular 87", "Diesel", "Mid-grade 89", "Premium 93"],
//                hours: "24 Hours / 7 Days"
//            ),
//            RaceTracLocationInfo(
//                locationId: 2,
//                city: "Dallas Hwy",
//                address: "5410 Dallas Hwy SW Powder Springs, Georgia 30127",
//                storeId: "2498",
//                lat: 33.9357199,
//                log: -84.7230259,
//                distance: "2.2 MI",
//                regularPrice: "$2.999",
//                dieselPrice: "$3.999",
//                amenities: ["Swirl World", "Self Checkout", "Pizza", "Seating Area", "Free WiFi"],
//                fuelOptions: ["Regular 87", "E85 Gas", "Diesel", "Mid-grade 89", "Premium 93"],
//                hours: "24 Hours / 7 Days"
//            ),
//            RaceTracLocationInfo(
//                locationId: 3,
//                city: "Bill Carruth",
//                address: "2850 Jimmy Lee smith Pkwy Hiram, Georgia 30141",
//                storeId: "2485",
//                lat: 33.9019148,
//                log: -84.7781853,
//                distance: "3.3 MI",
//                regularPrice: "$2.999",
//                dieselPrice: "$3.899",
//                amenities: ["Swirl World", "Self Checkout", "Pizza", "Seating Area", "Free WiFi"],
//                fuelOptions: ["Regular 87", "E85 Gas", "Diesel", "Mid-grade 89", "Premium 93"],
//                hours: "24 Hours / 7 Days"
//            ),
//            RaceTracLocationInfo(
//                locationId: 4,
//                city: "Bagwell Pkwy",
//                address: "5882 Wendy Bagwell Pkwy Hiram, Georgia 30141",
//                storeId: "76",
//                lat: 33.8835022,
//                log: -84.7315154,
//                distance: "3.7 MI",
//                regularPrice: "$2.999",
//                dieselPrice: "$3.899",
//                amenities: ["Swirl World", "Pizza", "Free WiFi"],
//                fuelOptions: ["Regular 87", "Diesel", "Mid-grade 89", "Premium 93"],
//                hours: "24 Hours / 7 Days"
//            ),
//            RaceTracLocationInfo(
//                locationId: 5,
//                city: "Bob Cox",
//                address: "3550 Dallas Hwy Marietta, Georgia 30064",
//                storeId: "247",
//                lat: 33.9542953,
//                log: -84.6529075,
//                distance: "6.7 MI",
//                regularPrice: "$2.999",
//                dieselPrice: "$3.999",
//                amenities: ["Free WiFi"],
//                fuelOptions: ["Regular 87", "Diesel", "Mid-grade 89", "Premium 93"],
//                hours: "24 Hours / 7 Days"
//            ),
//            RaceTracLocationInfo(
//                locationId: 6,
//                city: "Macland",
//                address: "2491 Macland Rd. Marietta, Georgia 30064",
//                storeId: "78",
//                lat: 33.900085,
//                log: -84.6254294,
//                distance: "8.0 MI",
//                regularPrice: "$3.059",
//                dieselPrice: "$4.059",
//                amenities: ["Swirl World", "Pizza", "Seating Area", "Free WiFi"],
//                fuelOptions: ["Regular 87", "Diesel", "Mid-grade 89", "Premium 93"],
//                hours: "24 Hours / 7 Days"
//            ),
//            RaceTracLocationInfo(
//                locationId: 7,
//                city: "Powder Springs",
//                address: "2732 Powder Springs Rd Marietta, Georgia 30064",
//                storeId: "122",
//                lat: 33.8668404,
//                log: -84.6333194,
//                distance: "10.4 MI",
//                regularPrice: "$2.999",
//                dieselPrice: "$4.059",
//                amenities: ["Swirl World", "Pizza", "Seating Area", "Free WiFi"],
//                fuelOptions: ["Regular 87", "Diesel", "Mid-grade 89", "Premium 93"],
//                hours: "24 Hours / 7 Days"
//            ),
//            RaceTracLocationInfo(
//                locationId: 8,
//                city: "Austell Rd",
//                address: "4414 Austell Rd Austell, Georgia 30106",
//                storeId: "660",
//                lat: 33.8463306,
//                log: -84.6096031,
//                distance: "13.0 MI",
//                regularPrice: "$2.999",
//                dieselPrice: "$4.059",
//                amenities: ["Swirl World", "Pizza", "Seating Area", "Free WiFi"],
//                fuelOptions: ["Regular 87", "Diesel", "Mid-grade 89", "Premium 93"],
//                hours: "24 Hours / 7 Days"
//            )
//         ]
        
        var annotations = [MKAnnotation]()
        
        for location in locationsDataArray {
            let annotation = MKPointAnnotation()
            annotation.title = location.city
            annotation.subtitle = location.address
            annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(location.lat), longitude: CLLocationDegrees(location.log))
            annotations.append(annotation)
        }

        mapView.addAnnotations(annotations)
        
        if let lastAnnotation = annotations.first {
            print(lastAnnotation)
            let region = MKCoordinateRegion(center: lastAnnotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
            mapView.setRegion(region, animated: true)
        }
    }
}
