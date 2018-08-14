//
//  VenueTableViewCell.swift
//  zz.4s.mervin.dizon
//
//  Created by mnl-anzmaca on 8/14/18.
//  Copyright © 2018 Mervin Dizon. All rights reserved.
//

import UIKit

class VenueTableViewCell: UITableViewCell {
  
  @IBOutlet weak var labelVenueName: UILabel!
  
  @IBOutlet weak var labelVenueDistance: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  func setCell(_ name: String, distance: Int) {
    labelVenueName.text = name
    labelVenueDistance.text = "\(distance)m"
  }
  
}

