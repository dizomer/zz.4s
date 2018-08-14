//
//  VenueViewController.swift
//  zz.4s.mervin.dizon
//
//  Created by mnl-anzmaca on 8/14/18.
//  Copyright © 2018 Mervin Dizon. All rights reserved.
//

import UIKit
import CoreLocation

let kFourSquareClientID = "UAMIXTMJQ1OC3SDVK4X5QJV4TW4H1DNKZHB0JFFYHBFSHNPM"

let kFourSquareClientSecret = "QX4JAZ4I4OBOJ5CBLE4DB1ACQJMQEWRY4RG0USOHZXA3DWFJ"

class VenueViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, UITextFieldDelegate {
  
  let locationManager = CLLocationManager()
  
  let mProgressDialog = ProgressViewController(nibName: "ProgressViewController", bundle: nil)

  var currentLocation:CLLocationCoordinate2D!
  
  var mVenueList = [FourSquareVenue]()
  
  var mOriginalVenueList = [FourSquareVenue]()
  
  var mSelectedVenue : FourSquareVenue!
  
  var flag = true

  @IBOutlet weak var tableViewVenue: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableViewVenue.tableHeaderView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: tableViewVenue.bounds.size.width, height: 0.01))

    // Set up location manager
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    
    // request location access
    locationManager.requestWhenInUseAuthorization()
    
    getCurrentLocation()
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
    
    super.touchesBegan(touches, with: event)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func tapButtonRefresh(_ sender: UIBarButtonItem) {
    flag = true
    getCurrentLocation()
  }
  
  func getCurrentLocation() {
    // check if access is granted
    if CLLocationManager.locationServicesEnabled() {
      switch(CLLocationManager.authorizationStatus()) {
      case .authorizedWhenInUse:
        locationManager.startUpdatingLocation()
      default:
        showLocationAlert()
      }
    } else {
      showLocationAlert()
    }
  }
  
  func snapToPlace() {
    self.mProgressDialog.ShowProgressDialog(self.navigationController?.view)
    
    mVenueList.removeAll()
    mOriginalVenueList.removeAll()
    
    // Limiting the venue in 15 and maximum of 4km on the current location
    
    let url = "https://api.foursquare.com/v2/venues/search?ll=\(currentLocation.latitude),\(currentLocation.longitude)&radius=4000&limit=15&client_id=\(kFourSquareClientID)&v=20180814&client_secret=\(kFourSquareClientSecret)"
    
    let myUrl = URL(string: url)
    let request = NSMutableURLRequest(url: myUrl!)
    let session = URLSession.shared
    
    request.httpMethod = "GET"
    
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, err -> Void in
      
      if err != nil {
        DispatchQueue.main.async {
          self.mProgressDialog.HideProgressDialog()
          self.showAlert("Error", message: err!.localizedDescription)
        }
        return
      }
      
      let json = JSON(data: data!)
      let listVenue = json["response"]["venues"].arrayValue
      
      for venue in listVenue {
        let name = venue["name"].string!
        let distance = venue["location"]["distance"].int!
        let address = venue["location"]["address"].string ?? "NA"
        
        self.mOriginalVenueList.append(FourSquareVenue(name: name, distance: distance, address: address))
      }
      
      DispatchQueue.main.async {
        self.mOriginalVenueList = self.mOriginalVenueList.sorted(by: { (place0: FourSquareVenue, place1: FourSquareVenue) -> Bool in
          return place0.distance < place1.distance
        })
        
        self.mVenueList.append(contentsOf: self.mOriginalVenueList)
        self.tableViewVenue.reloadData()
        self.mProgressDialog.HideProgressDialog()
      }
    })
    task.resume()
  }
  
  // MARK: - Location manager delegate
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let newLocation = locations.last!
    
    if newLocation.horizontalAccuracy < 0 {
      return
    }
    let interval = newLocation.timestamp.timeIntervalSinceNow
    
    if abs(interval) < 30 {
      // set a flag so segue is only called once
      if flag {
        currentLocation = locations.last?.coordinate
        locationManager.stopUpdatingLocation()
        flag = false
        
        // Fetch Venue
        snapToPlace()
      }
    }
  }
  
  //MARK: - UITextField Delegate
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let strAfter = (textField.text! as NSString).replacingCharacters(in: range, with: string)
    mVenueList.removeAll()
    mVenueList.append(contentsOf: mOriginalVenueList)
    if strAfter.count > 0 {
      mVenueList = mVenueList.filter { $0.name.range(of: strAfter, options: .caseInsensitive) != nil }
    }
    tableViewVenue.reloadData()
    return true
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  // MARK: - TableView methods
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 70
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return mVenueList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! VenueTableViewCell
    let venue = mVenueList[indexPath.row]
    
    cell.setCell(venue.name, distance: venue.distance)
    return cell
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    if mVenueList.count > 0 {
      mSelectedVenue = mVenueList[indexPath.row]
      self.performSegue(withIdentifier: "venueDetails", sender: self)
    }
  }
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Pass the latitude and longitude to the new view controller
    if segue.identifier == "venueDetails" {
      let vc = segue.destination as! VenueDetailsViewController
      vc.mSelectedVenue = mSelectedVenue
    }
  }
  
  // MARK: - Helpers
  func showLocationAlert() {
    showAlert("Location Disabled", message: "Please enable location.")
  }
  
  func showAlert(_ title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
    present(alert, animated: true, completion: nil)
  }
}

