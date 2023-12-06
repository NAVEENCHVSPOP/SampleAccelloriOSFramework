import CarPlay
import UIKit
import MapKit

public class CarPlaySceneDelegate: UIResponder, CPTemplateApplicationSceneDelegate, CPPointOfInterestTemplateDelegate  {
   
    // MARK: - Properties
    var interfaceController: CPInterfaceController?
    var raceTracksInfo = [RaceTracLocationInfo]()

    let listViewTemplate: CPListTemplate = CPListTemplate(title: "Locations", sections: [])
    
    public func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene,
        didConnect interfaceController: CPInterfaceController) {
    
        self.interfaceController = interfaceController
        self.interfaceController?.delegate = self

//         Notifications
        NotificationCenter.default.addObserver(self, selector: #selector(handleSelectedObject(_:)),
                name: Notification.Name("SampleAccelloriOSFrameworkDidSelectRow"), object: nil)
        
        self.getNewData()
        listViewTemplate.updateSections([updateRaceTracksList()])
        listViewTemplate.tabTitle = "Locations"
        let tabBar = CPTabBarTemplate.init(templates: [listViewTemplate ])
        tabBar.delegate = self
        self.interfaceController?.setRootTemplate(tabBar, animated: true, completion: {_, _ in })
    }
    
    public func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene, didDisconnectInterfaceController interfaceController: CPInterfaceController) {
    
        self.interfaceController = nil
    }
    
    func getNewData(){
        let locationsDataString = UserDefaults.standard.string(forKey: "LOCATIONS_DATA")

        if let reversedData = locationsDataString!.data(using: .utf8),
            let reversedArray = try? JSONDecoder().decode([RaceTracLocationInfo].self, from: reversedData) {
            self.raceTracksInfo = reversedArray
        }

    }
    
    // MARK: - Custom Methods
    func updateRaceTracksList() -> CPListSection {
        var raceTrackItems = [CPListItem]()
        for raceTrack in raceTracksInfo {
            let item = CPListItem(text: raceTrack.city, detailText: raceTrack.address)
            item.accessoryType = .none
            item.handler = {  item, completion in
//                guard let strongSelf = self else { return }
                SampleAccelloriOSFramework.shared.sendObjectToMainProject(selectedObject: raceTrack)
//                strongSelf.setupMap(raceTrack: raceTrack, completion: completion)
                completion()
            }
            raceTrackItems.append(item)
        }
        return CPListSection(items: raceTrackItems)
    }
    
    @objc func handleSelectedObject(_ notification: Notification) {
        if let myObject = notification.object {
            let raceTrack = (myObject as! RaceTracLocationInfo)
            self.interfaceController?.popToRootTemplate(animated: true, completion: { _, _ in
                
            })
                selectedPop(raceTrack: raceTrack) {
            }
        }
    }
    
    func selectedPop(raceTrack: RaceTracLocationInfo, completion: @escaping () -> Void) {
        setupMap(raceTrack: raceTrack, completion: completion)
    }
    
    func setupMap(raceTrack: RaceTracLocationInfo,  completion: @escaping () -> Void) {
        print("setupMap method called");
        let coordinates = CLLocationCoordinate2DMake(CLLocationDegrees(raceTrack.lat), CLLocationDegrees(raceTrack.log))
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        
        let poi = CPPointOfInterest(
            location: mapItem,
            title: raceTrack.city,
            subtitle: raceTrack.address,
            summary: "",
            detailTitle: raceTrack.city,
            detailSubtitle: raceTrack.address,
            detailSummary:"",
            pinImage: UIImage(named: "location_pointer")
        )
        
        poi.primaryButton = CPTextButton(
            title: "GO",
            textStyle: .normal,
            handler: { _ in }
        )
        
        poi.secondaryButton = CPTextButton(
            title: "More info",
            textStyle: .normal,
            handler: { _ in }
        )
        
        let pointOfInterestTemplate = CPPointOfInterestTemplate(
            title: "Location",
            pointsOfInterest: [poi],
            selectedIndex: NSNotFound)
        pointOfInterestTemplate.pointOfInterestDelegate = self
        pointOfInterestTemplate.tabTitle = "Map"
        pointOfInterestTemplate.tabImage = UIImage(systemName: "car")!
    
//        let tabTemplate = CPTabBarTemplate(templates: [pointOfInterestTemplate])
//        self.interfaceController?.setRootTemplate(tabTemplate, animated: true, completion: { (done, error) in
//        })
        
        self.interfaceController?.pushTemplate(pointOfInterestTemplate, animated: true, completion: { _, _ in
            completion()
            print("pushTemplate method called");
        })
    }
    
    public func pointOfInterestTemplate(_ pointOfInterestTemplate: CPPointOfInterestTemplate, didChangeMapRegion region: MKCoordinateRegion) {
    
    }
}

// MARK: - CPTabBarTemplateDelegate
extension CarPlaySceneDelegate: CPTabBarTemplateDelegate {
    public func tabBarTemplate(_ tabBarTemplate: CPTabBarTemplate, didSelect selectedTemplate: CPTemplate) {

    }
}

// MARK: - CPInterfaceControllerDelegate
extension CarPlaySceneDelegate: CPInterfaceControllerDelegate {

    public func templateWillAppear(_ aTemplate: CPTemplate, animated: Bool) {
        print("templateWillAppear", aTemplate)
    }

    public func templateDidAppear(_ aTemplate: CPTemplate, animated: Bool) {
        print("templateDidAppear", aTemplate)
    }

    public func templateWillDisappear(_ aTemplate: CPTemplate, animated: Bool) {
        print("templateWillDisappear", aTemplate)
    }

    public func templateDidDisappear(_ aTemplate: CPTemplate, animated: Bool) {
        print("templateDidDisappear", aTemplate)
    }
}

//import CarPlay
//import MapKit
//
//public class CarPlaySceneDelegate: UIResponder, CPTemplateApplicationSceneDelegate, CPPointOfInterestTemplateDelegate  {
//
//    // MARK: - Properties
//    var interfaceController: CPInterfaceController?
//    var raceTracksInfo = [RaceTracLocationInfo]()
//
//    let listViewTemplate: CPListTemplate = CPListTemplate(title: "Locations", sections: [])
//
//    func setupMap() {
//        let pointOfInterestTemplate = CPPointOfInterestTemplate(
//            title: "Hoagie Options",
//            pointsOfInterest: [],
//            selectedIndex: NSNotFound)
//        pointOfInterestTemplate.pointOfInterestDelegate = self
//        pointOfInterestTemplate.tabTitle = "Map"
//        pointOfInterestTemplate.tabImage = UIImage(systemName: "car")!
//
//        let tabTemplate = CPTabBarTemplate(templates: [pointOfInterestTemplate])
//
//        self.interfaceController?.setRootTemplate(tabTemplate, animated: true, completion: { (done, error) in
//        })
//    }
//
//    public func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene,
//        didConnect interfaceController: CPInterfaceController) {
//
//        self.interfaceController = interfaceController
//        setupMap()
//
//    }
//
//    public func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene, didDisconnectInterfaceController interfaceController: CPInterfaceController) {
//
//        self.interfaceController = nil
//
//    }
//
//    public func pointOfInterestTemplate(_ pointOfInterestTemplate: CPPointOfInterestTemplate, didChangeMapRegion region: MKCoordinateRegion) {
//
//    }
//
//}
//
//// MARK: - CPTabBarTemplateDelegate
//extension CarPlaySceneDelegate: CPTabBarTemplateDelegate {
//    public func tabBarTemplate(_ tabBarTemplate: CPTabBarTemplate, didSelect selectedTemplate: CPTemplate) {
//
//    }
//}
//
//// MARK: - CPInterfaceControllerDelegate
//extension CarPlaySceneDelegate: CPInterfaceControllerDelegate {
//
//    public func templateWillAppear(_ aTemplate: CPTemplate, animated: Bool) {
//        print("templateWillAppear", aTemplate)
//    }
//
//    public func templateDidAppear(_ aTemplate: CPTemplate, animated: Bool) {
//        print("templateDidAppear", aTemplate)
//    }
//
//    public func templateWillDisappear(_ aTemplate: CPTemplate, animated: Bool) {
//        print("templateWillDisappear", aTemplate)
//    }
//
//    public func templateDidDisappear(_ aTemplate: CPTemplate, animated: Bool) {
//        print("templateDidDisappear", aTemplate)
//    }
//}

//func selectedPop(raceTrack: RaceTracLocationInfo, completion: @escaping () -> Void) {
//    let okAlertAction: CPAlertAction = CPAlertAction(title: "Navigate", style: .default) { _ in
//        self.interfaceController?.dismissTemplate(animated: true, completion: { _, _ in })
//    }
//    let titleAlert = raceTrack.city + "," + raceTrack.address + "," + "Store " + raceTrack.storeId
//    let alertTemplate: CPAlertTemplate = CPAlertTemplate(titleVariants: [titleAlert], actions: [okAlertAction])
//    self.interfaceController?.presentTemplate(alertTemplate, animated: true, completion: { _, _ in
//        completion()
//    })
//}
