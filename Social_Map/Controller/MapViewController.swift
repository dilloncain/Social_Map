//
//  MapViewController.swift
//  Social_Map
//
//  Created by Dillon Cain on 3/24/19.
//  Copyright © 2019 Cain Computers. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import FirebaseDatabase
import Alamofire
import AlamofireImage
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!


    var locationManager = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus()
    let regionRadius: Double = 1000
    //var mapHasCenteredOnce = false
    
    //var geoFire: GeoFire!
    //var geoFireRef: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        locationManager.delegate = self
        configureLocationServices()
        mapView.userTrackingMode = MKUserTrackingMode.follow
        // Do any additional setup after loading the view.

        //geoFireRef = Database.database().reference()
        //geoFire = GeoFire(firebaseRef: geoFireRef)

    }
    override func viewDidAppear(_ animated: Bool) {
        
    }

    
    @IBAction func centerMapButtonPressed(_ sender: Any) {
        if authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse {
            centerMapOnUserLocation()
        }
    }
    
    
    
    
 @IBAction func mapBackButtonTapped(_ sender: Any) {
 performSegue(withIdentifier: "goBackToFeedViewController", sender: nil)
 }
    
}

extension MapViewController: MKMapViewDelegate {
    func centerMapOnUserLocation() {
        guard let coordinate = locationManager.location?.coordinate else { return }
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func configureLocationServices() {
        if authorizationStatus == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else {
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        centerMapOnUserLocation()
    }
}





//
//    func locationAuthStatus() {
//        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
//            // Important so you dont drain the users battery when not in use
//            mapView.showsUserLocation = true
//        } else {
//            locationManager.requestWhenInUseAuthorization()
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//
//        if status == CLAuthorizationStatus.authorizedWhenInUse {
//            mapView.showsUserLocation = true
//        }
//    }
//
//    func centerMapOnLocation(location: CLLocation) {
//        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
//
//        mapView.setRegion(coordinateRegion, animated: true)
//    }
//
//    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
//
//        if let loc = userLocation.location {
//
//            if !mapHasCenteredOnce {
//                centerMapOnLocation(location: loc)
//                mapHasCenteredOnce = true
//            }
//        }
//    }
//
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//
//        let annoIdentifier = "Event"
//        var annotationView: MKAnnotationView?
//
//        if annotation.isKind(of: MKUserLocation.self) {
//            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "User")
//            annotationView?.image = UIImage(named: "bitMojiTemplate")
//        } else if var deqAnno = mapView.dequeueReusableAnnotationView(withIdentifier: annoIdentifier) {
//            annotationView = deqAnno
//            annotationView?.annotation = annotation
//        } else {
//            var av = MKAnnotationView(annotation: annotation, reuseIdentifier: annoIdentifier)
//            av.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//            annotation = av
//        }
//
//        if let annotationView = annotationView, let anno = annotation
//            as? EventAnnotation {
//
//            annotationView.canShowCallout = true
//            annotationView.image = UIImage(named: "\(anno.eventNumber)")
//            let button = UIButton()
//            button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//            button.setImage(UIImage(named: "map"), for: .normal)
//            annotationView.rightCalloutAccessoryView = button
//        }
//
//        return annotationView
//    }
//
//    func createSighting(forLocation location: CLLocation, withEvents eventId: Int) {
//
//        geoFire.setLocation(location, forKey: "\(eventId)")
//        // Creates event
//    }
//
//    func showEventsOnMap(location: CLLocation) {
//        let circleQuery = geoFire!.query(at: location, withRadius: 2.5)
//
//        _ = circleQuery.observe(GFEventType.keyEntered, with: {
//            (key, location) in
//
//            //if let key = key, let location = location {
//                let anno = EventAnnotation(coordinate: location, eventNumber: Int(key)!)
//                self.mapView.addAnnotation(anno)
//            //}
//        })
//    }
//
//    @IBAction func spotRandomEvents(_ sender: Any) {
//
//        let loc = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
//
//        let rand = Int.random(in: 0...151) + 1
//        createSighting(forLocation: loc, withEvents: Int(rand))
//
//    }








