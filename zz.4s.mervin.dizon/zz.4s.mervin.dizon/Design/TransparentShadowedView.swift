//
//  TransparentShadowedView.swift
//  zz.4s.mervin.dizon
//
//  Created by mnl-anzmaca on 8/14/18.
//  Copyright © 2018 Mervin Dizon. All rights reserved.
//

import Foundation
import UIKit

class TransparentShadowedView : UIView {
  
  required init!(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.initializeLayout()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.initializeLayout()
  }
  
  func initializeLayout() {
    self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    self.layer.shadowOpacity = 0.8
    self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
  }
  
}
