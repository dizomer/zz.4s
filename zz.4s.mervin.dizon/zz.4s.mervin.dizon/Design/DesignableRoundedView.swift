//
//  DesignableRoundedView.swift
//  zz.4s.mervin.dizon
//
//  Created by mnl-anzmaca on 8/14/18.
//  Copyright © 2018 Mervin Dizon. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class DesignableRoundedView : UIView {
  
  @IBInspectable var borderColor: UIColor = UIColor.clear {
    didSet {
      self.layer.borderColor = borderColor.cgColor
    }
  }
  
  @IBInspectable var borderWidth: CGFloat = 0 {
    didSet {
      self.layer.borderWidth = borderWidth
    }
  }
  
  @IBInspectable var cornerRadius: CGFloat = 0 {
    didSet {
      self.layer.cornerRadius = cornerRadius
    }
  }
  
  @IBInspectable var masksToBounds: Bool = true {
    didSet {
      self.layer.masksToBounds = masksToBounds
    }
  }
  
}
