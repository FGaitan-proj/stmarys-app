//
//  MyInfoController.swift
//  TypesofQuestions
//
//  Created by Fernando Gaitan on 7/24/20.
//  Copyright © 2020 Fernando Gaitan & Rachel Morrow. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseFirestore

class MyInfoController: UIViewController {
    
    @IBOutlet weak var MItoMM: UIButton!
    @IBOutlet weak var firstName: UITextView!
    @IBOutlet weak var email: UITextView!
    @IBOutlet weak var Relationship: UITextView!
    @IBOutlet weak var PatientFullName: UITextView!
    @IBOutlet weak var ProviderLabel: UILabel!
    @IBOutlet weak var ProviderFullName: UITextView!
    @IBOutlet weak var ProviderEmailLabel: UILabel!
    @IBOutlet weak var ProviderEmail: UITextView!
    
    var FullName = String()
    var EmailString = String()
    var Relations = String()
    var PatientFull = String()
    var Providerfullname = String()
    var providerEmail = String()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firstName.text = FullName
        self.email.text = EmailString
        self.Relationship.text = Relations
        self.PatientFullName.text = PatientFull
        self.ProviderFullName.text = Providerfullname
        self.ProviderEmail.text = providerEmail
        if UserDefaults.standard.bool(forKey: "SelfOrParent") {
            self.ProviderLabel.isHidden = false
            self.ProviderFullName.isHidden = false
            self.ProviderEmailLabel.isHidden = false
            self.ProviderEmail.isHidden = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func Logout(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "LoggedIn")
        self.performSegue(withIdentifier: "logoutTapped", sender: self)
        do { try Auth.auth().signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }

    @IBAction func MItoMM(_ sender: Any) {
        self.performSegue(withIdentifier: "MyInfotoMM", sender: self)
    }
    
    
}
