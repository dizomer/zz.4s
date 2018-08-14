//
//  FourSquareLibrary.swift
//  zz.4s.mervin.dizon
//
//  Created by mnl-anzmaca on 8/14/18.
//  Copyright © 2018 Mervin Dizon. All rights reserved.
//

import Foundation



func fourSquareRequest(_ clientID: String, clientSecret: String, url: String, httpMethod: String) -> NSMutableURLRequest? {
  let scriptUrl = "https://api.foursquare.com/v2/venues/search?" //url
  
  
  
  let myUrl = URL(string: scriptUrl)
  let request = NSMutableURLRequest(url:myUrl!)
  
  request.httpMethod = httpMethod
  return request
  

}
