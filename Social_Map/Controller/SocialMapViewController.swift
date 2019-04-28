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
//class SocialMapViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}

class SocialMapViewController: UIViewController, GMSMapViewDelegate {
    @IBAction func socialMapBackButtonPressed(_ sender: Any) {
    }
    
    
    // You don't need to modify the default init(nibName:bundle:) method.
    
    override func loadView() {
        
    
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        
        
    }
}
