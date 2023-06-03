//
//  CountryCell.swift
//  FaceIdProject
//
//  Created by Gizem on 17.04.2023.
//

import UIKit

class CountryCell: UITableViewCell {

    static let identifier = "CountryCell"
    
    @IBOutlet weak var countryNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(countryName: String) {
        countryNameLabel.text = countryName
    }
    
}
