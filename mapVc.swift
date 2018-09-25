//
//  mapVc.swift
//  InstagramClone
//
//  Created by Ahmed Burham on 7/31/18.
//  Copyright © 2018 Ahmed Burham. All rights reserved.
//

import UIKit
import MapKit
class mapVc: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {

    @IBOutlet weak var mymap: MKMapView!
    
    
        let locationManger = CLLocationManager()
        var userLocation:CLLocationCoordinate2D?
        var riderLocation:CLLocationCoordinate2D!
    
        @IBOutlet weak var mapviews: MKMapView!
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
            locationManger.delegate = self
            locationManger.startUpdatingLocation()
            locationManger.requestWhenInUseAuthorization()
            locationManger.desiredAccuracy = kCLLocationAccuracyBest
            //if CLLocationManager.locationServicesEnabled() {
            // locationManger.startUpdatingLocation() // start location manager
            
            //}
        }
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            // if let location = locationManger.location?.coordinate{
            let  location = locations[0]
            let  userLocation  = CLLocationCoordinate2D( latitude:location.coordinate.latitude, longitude:location.coordinate.longitude)
            let span = MKCoordinateSpanMake(0.01,0.01 )
            let  region = MKCoordinateRegion(center:userLocation,span: span)
            mapviews.setRegion(region, animated: true)
            // mapviews.removeAnnotation(mapviews.annotations as! MKAnnotation)
            var annotation = MKPointAnnotation()
            
            annotation.coordinate = userLocation
            annotation.title = "me"
            mapviews.addAnnotation(annotation)
            mapviews.showsUserLocation = true
            
            
            //}
        }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
