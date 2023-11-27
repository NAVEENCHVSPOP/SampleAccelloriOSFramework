//
//  ViewController.swift
//  SampleProject
//
//  Created by Admin on 16/11/23.
//

import UIKit

@objc public class MainViewController: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var searchTxtFld: UITextField!
  
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var listContainerView: UIView!
    @IBOutlet weak var mapContainerView: UIView!
    
    public var titleColor = UIColor(red: 14, green: 45, blue: 114, alpha: 1)
    
    @objc public init(locationsDataString: String) {
        super.init(nibName: nil, bundle: Bundle(for: MainViewController.self))
        UserDefaults.standard.set(locationsDataString, forKey: "LOCATIONS_DATA")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Updated title color",self.titleColor)
        
        titleLbl.textColor = self.titleColor
       
        self.listContainerView.isHidden = false
        self.mapContainerView.isHidden = true
        
        self.searchTxtFld.layer.borderWidth = 1.0
        self.searchTxtFld.layer.borderColor = UIColor.gray.cgColor
        self.searchTxtFld.attributedPlaceholder = NSAttributedString(
            string: "California, GA, USA",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
        self.searchTxtFld.leftView = paddingView
        self.searchTxtFld.leftViewMode = .always
        
    }
    
    @IBAction func segmentControlAction(_ sender: Any) {
        switch segmentControl.selectedSegmentIndex {
            case 0:
                self.listContainerView.isHidden = false
                self.mapContainerView.isHidden = true
            case 1 :
                self.listContainerView.isHidden = true
                self.mapContainerView.isHidden = false
            default:
                break
        }
    }

}



