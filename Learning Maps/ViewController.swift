//
//  ViewController.swift
//  Learning Maps
//
//  Created by Nathanial L. McConnell on 9/20/14.
//  Copyright (c) 2014 Nathanial L. McConnell. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

  @IBOutlet weak var mapView: MKMapView!
  
  var manager = CLLocationManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    // Core Location
    manager.delegate = self
    manager.desiredAccuracy = kCLLocationAccuracyBest
    manager.requestWhenInUseAuthorization()
    manager.startUpdatingLocation()
    
    // 36.309803, -82.355932 (Nate's Home)
    var latitude: CLLocationDegrees = 36.309803
    var longitude: CLLocationDegrees = -82.355932
    var latDelta: CLLocationDegrees = 0.01
    var longDelta: CLLocationDegrees = 0.01
    var span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
    var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
    var region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
    
    mapView.setRegion(region, animated: true)
    
    var annotation = MKPointAnnotation()
    annotation.coordinate = location
    annotation.title = "Nate's Home"
    annotation.subtitle = "a.k.a. Castle Grayskull"
    
    mapView.addAnnotation(annotation)
    
    var uilpgr = UILongPressGestureRecognizer(target: self, action: "action:")
    uilpgr.minimumPressDuration = 2.0
    println(uilpgr)
    
    mapView.addGestureRecognizer(uilpgr)
  }
  
  func action(gestureRecognizer: UIGestureRecognizer) {
    var touchPoint = gestureRecognizer.locationInView(self.mapView)
    var newCoordinate: CLLocationCoordinate2D = self.mapView.convertPoint(touchPoint, toCoordinateFromView: self.mapView)
    var newAnnotation = MKPointAnnotation()
    newAnnotation.coordinate = newCoordinate
    newAnnotation.title = "New Location"
    newAnnotation.subtitle = "A newly-added location"
  }
  
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [AnyObject]) {
    var userLocation: CLLocation = locations[0] as CLLocation
    var latitude: CLLocationDegrees = userLocation.coordinate.latitude
    var longitude: CLLocationDegrees = userLocation.coordinate.longitude
    var latDelta: CLLocationDegrees = 0.01
    var longDelta: CLLocationDegrees = 0.01
    var span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
    var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
    var region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
    
    mapView.setRegion(region, animated: true)
  }
  
  func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
    println(error)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

