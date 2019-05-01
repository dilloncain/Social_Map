//
//  SocialMapViewController.swift
//  Social_Map
//
//  Created by Dillon Cain on 4/27/19.
//  Copyright © 2019 Cain Computers. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Firebase


class SocialMapViewController: UIViewController, GMSMapViewDelegate {
    @IBAction func socialMapBackButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToSignInTwo", sender: nil)
    }
    
    @IBOutlet weak var mapView: GMSMapView!
    private let locationManager = CLLocationManager()
    // Had this in the wrong scope which resulted in (Ambiguous reference to member 'locationManager(_:didChangeAuthorization:)')
    
    // You don't need to modify the default init(nibName:bundle:) method.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mapView.delegate = self
    
    }
}


extension SocialMapViewController: CLLocationManagerDelegate {
    // Extension of SocialMapViewController that conforms to CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // Called when user grants or revokes user location permissions
        guard status == .authorizedWhenInUse else {
            return
            // Verify user has granted permission to obtain current location
        }
        locationManager.startUpdatingLocation()
        // Once permission is granted, start asking location manager for user's location
        mapView.isMyLocationEnabled = true
        // Adds blue dot to show current location of user
        mapView.settings.myLocationButton = true
        // Button added to allow user to center self on location
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
            // When locationManager receives new location data update current location
        }
        
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        // Updates camera postion to center on users current location

        locationManager.stopUpdatingLocation()
        // Initial location is enough and stops location updates
    }
}
