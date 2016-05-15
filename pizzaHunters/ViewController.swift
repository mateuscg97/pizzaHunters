//
//  ViewController.swift
//  pizzaHunters
//
//  Created by Mateus Da Costa Goncalves on 14/05/16.
//  Copyright © 2016 Mateus Da Costa Goncalves. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager: CLLocationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup(){
        locationManager.delegate = self
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        locationManager.requestAlwaysAuthorization()
        
    }

    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        currentLocation = userLocation.location
        let region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 250, 250)
        mapView.setRegion(region, animated: true)
    }
    
    func addAnnotationToMap(){
        
        let pizzaAnnotation = PizzaAnnotation(coordinate: self.currentLocation!.coordinate, title: "Pizza", subtitle: "Yummy")
        mapView.addAnnotation(pizzaAnnotation)
        
    }
    
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake{
            addAnnotationToMap()
            
        }
    }
}

