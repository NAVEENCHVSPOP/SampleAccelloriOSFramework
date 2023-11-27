//
//  LocationTableViewCell.swift
//  SampleProject
//
//  Created by Admin on 17/11/23.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func updateCell(city: String, address: String)
    {
        self.cityLbl.text = city
        self.addressLbl.text = address
    }

}
