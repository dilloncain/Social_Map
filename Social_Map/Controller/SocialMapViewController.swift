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
    
    
    // You don't need to modify the default init(nibName:bundle:) method.
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let navigationController = segue.destination as? UINavigationController,
//            let controller = navigationController.topViewController as? TypesTableViewController else {
//                return
//        }
//        controller.selectedTypes = searchedTypes
//        controller.delegate = self
//    }
}
