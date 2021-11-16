//
//  MainMenuController.swift
//  TypesofQuestions
//
//  Created by Fernando Gaitan on 7/14/20.
//  Copyright © 2020 Fernando Gaitan & Rachel Morrow. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseFirestore

class MainMenuController: UIViewController {
    
    @IBOutlet weak var addSurvey: UIButton!
    @IBOutlet weak var MyInformation: UIButton!
    @IBOutlet weak var Day20Survey: UIButton!
    
    var db: Firestore!
    var FullName = String()
    var Emailstring = String()
    var Relations = String()
    var PatientFull = String()
    var Providerfullname = String()
    var providerEmail = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        self.setUpElements()
        self.getDocument()
    }

    func setUpElements() {
        Utilities.styleFilledButton2(addSurvey)
        Utilities.styleFilledButton2(MyInformation)
        Utilities.styleFilledButton2(Day20Survey)
    }
    
    func getDocument() {
        let uid = Auth.auth().currentUser?.uid
        let docRef = db.collection("users").document(uid!)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()
                self.FullName = ((dataDescription?["firstname"] as? String)!) + " " + ((dataDescription?["lastname"] as? String)!)
                self.Emailstring = (dataDescription?["email"] as? String)!
                self.Relations = (dataDescription?["relation"] as? String)!
                if self.Relations == "Self"{
                    self.PatientFull = ((dataDescription?["firstname"] as? String)!) + " " + ((dataDescription?["lastname"] as? String)!)
                }
                   else {
                    self.PatientFull = ((dataDescription?["PatientFirstname"] as? String)!) + " " + ((dataDescription?["Patientlastname"] as? String)!)
                }
                self.Providerfullname = (dataDescription?["providername"] as? String)!
                self.providerEmail = (dataDescription?["provideremail"] as? String)!
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func toMyInformation(_ sender: Any) {
        self.performSegue(withIdentifier: "MyInfoSegue", sender: self)
    }
    
    @IBAction func ToSurvey(_ sender: Any) {
        self.performSegue(withIdentifier: "toSurvey", sender: self)
    }
    
    @IBAction func Day(_ sender: Any) {
        self.performSegue(withIdentifier: "Day20SurveyTapped", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MyInfoSegue" {
        let present = segue.destination as! MyInfoController
            present.FullName = self.FullName
            present.EmailString = self.Emailstring
            present.Relations = self.Relations
            present.PatientFull = self.PatientFull
            present.Providerfullname = self.Providerfullname
            present.providerEmail = self.providerEmail
        }
    }
}
