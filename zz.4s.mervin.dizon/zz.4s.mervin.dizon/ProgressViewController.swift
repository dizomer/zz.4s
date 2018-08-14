//
//  ProgressViewController.swift
//  zz.4s.mervin.dizon
//
//  Created by mnl-anzmaca on 8/14/18.
//  Copyright © 2018 Mervin Dizon. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController {
  
  @IBOutlet weak var activityProgress: UIActivityIndicatorView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func ShowProgressDialog(_ aView: UIView!) {
    ShowProgressDialog(aView, message: nil)
  }
  
  func ShowProgressDialog(_ aView: UIView!, message: String?) {
    self.view.frame = aView.frame
    self.view.center = aView.center
    aView.addSubview(self.view)
    activityProgress.startAnimating()
  }
  
  func HideProgressDialog() {
    activityProgress.stopAnimating()
    self.view.removeFromSuperview()
  }
  
}

