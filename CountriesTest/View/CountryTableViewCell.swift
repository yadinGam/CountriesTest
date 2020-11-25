//
//  CountryTableViewCell.swift
//  CountriesTest
//
//  Created by yadin g on 24/11/2020.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nativeNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(country: CountryViewModel) {
        self.nameLabel.text = country.getName()
        self.nativeNameLabel.text = country.getNativeName()
    }
    
}
