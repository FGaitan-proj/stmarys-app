//
//  SecondViewcontroller.swift
//  TypesofQuestions
//
//  Created by Fernando Gaitan on 7/6/20.
//  Copyright © 2020 Fernando Gaitan & Rachel Morrow. All rights reserved.
//

import UIKit
import MessageUI
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

class FinalSurveyController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var Information: UITextView!
    
    var Catheterize = String()
    var Blood = String()
    var Appetite = String()
    var Activity = String()
    var NerveInc = String()
    var PainScale = String()
    var VisitInfo = String()
    var DTDate = Date()
    var PrintInfo = String()
    var db : Firestore!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpElements()
        self.Information.text = PrintInfo

        db = Firestore.firestore()
    }
    
    func setUpElements() {
        //Utilities.styleFilledButton2(emailButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func FStoS2(_ sender: Any) {
        self.performSegue(withIdentifier: "FStoS2", sender: self)
    }
    
    
    @IBAction func ToMainMenu(_ sender: Any) {
        self.performSegue(withIdentifier: "FinishSurvey", sender: self)
        guard let uid = Auth.auth().currentUser?.uid else { return }
        //let survey = FullSurvey(Catheterize: self.Catheterize, Blood: self.Blood, Appetite: self.Appetite, Activity: self.Activity, NerveInc: self.NerveInc, PainScale: self.PainScale, VisitInfo: self.VisitInfo)
        db.collection("users").document(uid).collection("Logs").document("Full Daily Logs").setData([
            DTDate.description : PrintInfo] , merge: true)
        db.collection("users").document(uid).collection("Logs").document("Daily Logs").updateData([
            "NumofCath" : FieldValue.arrayUnion([Catheterize]), "BloodPressure" : FieldValue.arrayUnion([Blood]) ])
       // db.collection("users").document(uid).collection("Logs").document("Daily Logs").setData([ DTDate.description : survey], merge: true)
        
    }
    
    @IBAction func emailButtonTapped(_ sender: Any) {
        // Needs to be run on a device
        showMailComposer()
    }
    
    func showMailComposer() {
        
        guard MFMailComposeViewController.canSendMail() else {
            return
        }
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self
        mail.setToRecipients(UserDefaults.standard.object(forKey: "providerEmail") as? [String])
        mail.setSubject("")
        mail.setMessageBody("", isHTML: false)
        
        present(mail, animated: true)
        
        
    }

    
}

