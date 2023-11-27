import CarPlay

public class CarPlaySceneDelegate: UIResponder  {

    // MARK: - Properties
    var interfaceController: CPInterfaceController?
    var raceTracksInfo = [RaceTracLocationInfo]()
    
    let listViewTemplate: CPListTemplate = CPListTemplate(title: "Locations", sections: [])
    

    // MARK: - Custom Methods
    func updateRaceTracksList() -> CPListSection {
        var raceTrackItems = [CPListItem]()
        for raceTrack in raceTracksInfo {
            let item = CPListItem(text: raceTrack.city, detailText: raceTrack.address)
            item.accessoryType = .none
//            item.setImage(UIImage(named: radio.imageSquareUrl))
            item.handler = { [weak self] item, completion in
                guard let strongSelf = self else { return }
                strongSelf.popList(raceTrack: raceTrack, completion: completion)
            }
            raceTrackItems.append(item)
        }
        return CPListSection(items: raceTrackItems)
    }
    
    func popList(raceTrack: RaceTracLocationInfo, completion: @escaping () -> Void) {
        let okAlertAction: CPAlertAction = CPAlertAction(title: "Ok", style: .default) { _ in
            SampleAccelloriOSFramework.shared.sendObjectToMainProject(selectedObject: raceTrack)
            self.interfaceController?.dismissTemplate(animated: true, completion: { _, _ in })
        }
        let titleAlert =  "Send to Device"
        let alertTemplate: CPAlertTemplate = CPAlertTemplate(titleVariants: [titleAlert], actions: [okAlertAction])
        self.interfaceController?.presentTemplate(alertTemplate, animated: true, completion: { _, _ in
            completion()
        })
    }
    
    func selectedPop(raceTrack: RaceTracLocationInfo, completion: @escaping () -> Void) {
        let okAlertAction: CPAlertAction = CPAlertAction(title: "done", style: .default) { _ in
            self.interfaceController?.dismissTemplate(animated: true, completion: { _, _ in })
        }
        let titleAlert = raceTrack.address
        let alertTemplate: CPAlertTemplate = CPAlertTemplate(titleVariants: [titleAlert], actions: [okAlertAction])
        self.interfaceController?.presentTemplate(alertTemplate, animated: true, completion: { _, _ in
            completion()
        })
    }
    
    func getNewData(){
        let locationsDataString = UserDefaults.standard.string(forKey: "LOCATIONS_DATA")
        
        if let reversedData = locationsDataString!.data(using: .utf8),
            let reversedArray = try? JSONDecoder().decode([RaceTracLocationInfo].self, from: reversedData) {
            self.raceTracksInfo = reversedArray
        }
        
    }
    
    @objc func handleSelectedObject(_ notification: Notification) {
        if let myObject = notification.object {
            let raceTrack = (myObject as! RaceTracLocationInfo)
            selectedPop(raceTrack: raceTrack) {
            }
        }
    }
}

// MARK: - CPTemplateApplicationSceneDelegate
extension CarPlaySceneDelegate: CPTemplateApplicationSceneDelegate {
    

        
    public func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene, didConnect interfaceController: CPInterfaceController) {

        self.interfaceController = interfaceController
        self.interfaceController?.delegate = self
        

        // Notifications
        NotificationCenter.default.addObserver(self, selector: #selector(handleSelectedObject(_:)),
                name: Notification.Name("SampleAccelloriOSFrameworkDidSelectRow"), object: nil)
        self.getNewData()
        listViewTemplate.updateSections([updateRaceTracksList()])
        listViewTemplate.tabTitle = "Locations"
//        listViewTemplate.tabImage = UIImage(named: "locations")
        let tabBar = CPTabBarTemplate.init(templates: [listViewTemplate ])
        tabBar.delegate = self
        self.interfaceController?.setRootTemplate(tabBar, animated: true, completion: {_, _ in })
    
    }

    // CarPlay disconnected
    private func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene, didDisconnect interfaceController: CPInterfaceController) {
        self.interfaceController = nil
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
