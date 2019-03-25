//
//  SignInViewController.swift
//  Social_Map
//
//  Created by Dillon Cain on 3/21/19.
//  Copyright © 2019 Cain Computers. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import MapKit
//import GeoFire
import SwiftKeychainWrapper

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var emailField: GreatField!
    @IBOutlet weak var passwordField: GreatField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailField.delegate = self
        passwordField.delegate = self
        // Do any additional setup after loading the view.
        // Can't perform segue's in viewDidLoad
    }
    

    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            print("Dillon: ID found in keychain")
            performSegue(withIdentifier: "goToFeedViewController", sender: nil)
            // checks for present key
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
        // On keyboard return, the keyboard will go away to see text fields
    }
    
    
    @IBAction func facebookButtonTapped(_ sender: UIButton) {
        
        let facebookLogin = FBSDKLoginManager()
        
        /*let loginButton = FBSDKLoginButton()
        // Optional: Place the button in the center of your view.
        loginButton.delegate = self as! FBSDKLoginButtonDelegate
        
        loginButton.center = view.center
        view.addSubview(loginButton) */
        
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("Dillon: Unable to authenticate with Facebook - \(error)")
            } else if result?.isCancelled == true {
                print("Dillon: User cancelled Facebook authentication")
            } else {
                print("Dillon: Sucessfully authenticated with Facebook")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
        
    }
    
    func firebaseAuth(_ credential: AuthCredential) {
        Auth.auth().signInAndRetrieveData(with: credential, completion: { (authDataResult, error) in
            if error != nil {
                print("Dillon: Unable to authenticate with Firebase - \(error)")
            } else {
                print("Dillon: Successfully authenticated with Firebase")
                if let authDataResult = authDataResult {
                    let userData = ["provider": credential.provider]
                    self.completeSignIn(id: authDataResult.user.uid, userData: userData)

                }
            }
            // User is signed in
        })
    }
    @IBAction func signInButtonPressed(_ sender: Any) {
        if let email = emailField.text, let pwd = passwordField.text {
            Auth.auth().signIn(withEmail: email, password: pwd, completion: { (authDataResult, error) in
                if error == nil {
                    print("Dillon: Email user authenticated with Firebase")
                    if let authDataResult = authDataResult {
                        let userData = ["provider": authDataResult.user.providerID]
                        self.completeSignIn(id: authDataResult.user.uid, userData: userData)
                    }
                } else {
                    Auth.auth().createUser(withEmail: email, password: pwd, completion: { (authDataResult, error) in
                        if error != nil {
                            print("Dillon: Unable to authenticate with Firebase using email")
                        } else {
                            print("Dillon: Successfully authenticated with Firebase")
                            if let authDataResult = authDataResult {
                                let userData = ["provider": authDataResult.user.providerID]
                                self.completeSignIn(id: authDataResult.user.uid, userData: userData)
                            }
                        }
                    })
                }
            })
        }
    }
    
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        // Creating firebase user in database
        let keyChainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("Dillon: Data saved to keychain \(keyChainResult)")
        performSegue(withIdentifier: "goToFeedViewController", sender: nil)
    }
    
}
