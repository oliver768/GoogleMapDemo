//
//  ViewController.swift
//  GoogleMapDemo
//
//  Created by Ravindra Sonkar on 17/12/18.
//  Copyright © 2018 Ravindra Sonkar. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class ViewController: UIViewController {
    @IBOutlet weak var mapView: UIView!

    var locationManager = CLLocationManager()
    var mapView1 = GMSMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Creates a marker in the center of the map.

//        mapView.isMyLocationEnabled = true
        
        //Location Manager code to fetch current location
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()

        // Do any additional setup after loading the view, typically from a nib.
    }

    func startLocating() {
        let camera = GMSCameraPosition.camera(withLatitude: (self.locationManager.location?.coordinate.latitude)!, longitude: (self.locationManager.location?.coordinate.longitude)!, zoom: 6.0)
        mapView1 = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: self.mapView.frame.size.width, height: mapView.frame.size.height) , camera: camera)
        mapView1.settings.myLocationButton = true
        mapView1.isMyLocationEnabled = true
        let marker = GMSMarker()
        marker.position = camera.target
        marker.title = "Noida"
        marker.snippet = "India"
        marker.map = mapView1
        self.mapView.addSubview(mapView1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.startLocating()
        //Finally stop updating location otherwise it will come again and again in this delegate
        self.locationManager.stopUpdatingLocation()
    }
}
