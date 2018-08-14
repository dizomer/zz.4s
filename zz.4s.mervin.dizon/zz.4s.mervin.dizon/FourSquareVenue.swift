//
//  FourSquareVenue.swift
//  zz.4s.mervin.dizon
//
//  Created by mnl-anzmaca on 8/14/18.
//  Copyright © 2018 Mervin Dizon. All rights reserved.
//

import Foundation

class FourSquareVenue: NSObject {
  
  var name : String
  var distance : Int
  var address : String
  
  required init(name: String, distance: Int, address: String) {
    self.name = name
    self.distance = distance
    self.address = address
  }
  
}
