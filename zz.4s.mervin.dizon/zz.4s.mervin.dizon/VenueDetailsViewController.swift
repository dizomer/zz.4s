//
//  VenueDetailsViewController.swift
//  zz.4s.mervin.dizon
//
//  Created by mnl-anzmaca on 8/14/18.
//  Copyright © 2018 Mervin Dizon. All rights reserved.
//

import UIKit

class VenueDetailsViewController: UIViewController {
  
  @IBOutlet weak var labelVenueName: UILabel!
  
  @IBOutlet weak var textViewVenueAddress: UITextView!
  
  var mSelectedVenue : FourSquareVenue!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    labelVenueName.text = mSelectedVenue.name
    textViewVenueAddress.text = mSelectedVenue.address
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}

