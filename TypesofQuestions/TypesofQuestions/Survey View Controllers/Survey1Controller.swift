//
//  ViewController.swift
//  TypesofQuestions
//
//  Created by Fernando Gaitan on 7/3/20.
//  Copyright © 2020 Fernando Gaitan & Rachel Morrow. All rights reserved.
//

import UIKit

class Survey1Controller: UIViewController {

    @IBOutlet var Numbers1: [UIButton]!
    @IBOutlet var Numbers2: [UIButton]!
    @IBOutlet var Choices1: [UIButton]!
    @IBOutlet var ActivityCollection: [UIButton]!
    @IBOutlet var MedicalCollection: [UIButton]!
    @IBOutlet var typeOfM: [UIButton]!
    
    @IBOutlet weak var NerveNum: UITextField!
    @IBOutlet weak var Date: UIDatePicker!
    @IBOutlet weak var PainFaces: UIImageView!
    @IBOutlet weak var blankSpace: UILabel!
    @IBOutlet weak var reasonForVisit: UILabel!
    @IBOutlet weak var VisitDetails: UITextField!
    
    var Catheterize = String()
    var HighBlood = String()
    var GenAppetite = String()
    var Activity = String()
    var Medical = String()
    var PainNumber = String()
    var extrahours = TimeInterval(signOf: 0,magnitudeOf: 14400.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addDoneButtonOnKeyboard()
        self.PainFaces.image = UIImage.init(named: "PainScaleTitle")
        
        let tap = UITapGestureRecognizer(target: self.view, action:
            #selector(UIView.endEditing)); view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.createAlert()
    }
        
    
    func createAlert() {
        let alert = UIAlertController(title: "Legal Disclaimer" , message: "This application does not replace medical consultation. If you are experiencing any severe pain please contact your medical provider. If there is an emergency please contact 911.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: { (action) in
        alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func Num1Tapped(_ sender: UIButton) {
       Utilities.showonebutton(list: Numbers1, selected: sender, controller: self)
        Catheterize = sender.currentTitle ?? String()
    }
             
    @IBAction func Num2Tapped(_ sender: UIButton) {
        Utilities.showonebutton(list: Numbers2, selected: sender, controller: self)
        HighBlood = sender.currentTitle ?? String()
    }
    
    
    enum Appetite: String {
        case a = "None"
        case b = "Little"
        case c = "Some"
        case d = "Strong"
    }
    

    func fillOne(_ sender: UIButton) {
        Choices1.forEach {x in
            if x.backgroundImage(for: UIControl.State.normal) == UIImage(systemName: "circle.fill") {
                x.setBackgroundImage(UIImage(systemName: "circle"), for: UIControl.State.normal)
            }
            sender.setBackgroundImage(UIImage(systemName: "circle.fill"), for: UIControl.State.normal)
        }
    }
    
    @IBAction func MultipleChoice(_ sender: UIButton) {
         guard let title = sender.currentTitle, let _pick = Appetite(rawValue: title) else { return }
                switch _pick {
                case .a:
                    GenAppetite = "None"
                case .b:
                    GenAppetite = "Little"
                case .c:
                    GenAppetite = "Some"
                case .d:
                    GenAppetite = "Strong"
                }
        self.fillOne(sender)
    }
    
    @IBAction func ActivityLevel(_ sender: UIButton) {
        Utilities.showonebutton(list: ActivityCollection, selected: sender, controller: self)
         Activity = sender.currentTitle ?? String()
    }
    
    
    @IBAction func MedicalProvider(_ sender: UIButton) {
        MedicalCollection.forEach { (x) in
            x.isHidden = !x.isHidden
            sender.isHidden = false
            }
        self.Medical = sender.currentTitle ?? String()
        if sender.currentTitle == "Yes" {
            self.reasonForVisit.isHidden = !reasonForVisit.isHidden
            self.blankSpace.isHidden = !blankSpace.isHidden
            typeOfM.forEach { (x) in
                       x.isHidden = !x.isHidden
                       }
        } else if sender.currentTitle == "No" {
            self.reasonForVisit.isHidden = true
            self.blankSpace.isHidden = true
            typeOfM.forEach { (x) in
                       x.isHidden = true
                        }
        }
    }
    
    
    @IBAction func details(_ sender: UIButton) {
        Utilities.showonebutton(list: typeOfM, selected: sender, controller: self)
        if sender.currentTitle == "Specialist" {
            self.VisitDetails.placeholder = "Type of Specialist"
            self.VisitDetails.isHidden = !VisitDetails.isHidden
        } else if sender.currentTitle == "Emergency Care" {
            self.VisitDetails.placeholder = "Please describe"
            self.VisitDetails.isHidden = !VisitDetails.isHidden
        }
        self.Medical = self.Medical + (sender.currentTitle ?? String())
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.black
        doneToolbar.isTranslucent = true

        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneButtonAction))

        let stuff = NSMutableArray()
        stuff.add(flexSpace)
        stuff.add(done)

        doneToolbar.items = stuff as? [UIBarButtonItem]
        doneToolbar.sizeToFit()

        self.NerveNum.inputAccessoryView = doneToolbar
    }
    @objc func doneButtonAction() {self.NerveNum.endEditing(true)}
    
    @IBAction func ChangePainFaces(_ sender: UIStepper) {
        if (sender.value == 0.0) {
        PainFaces.image = UIImage.init(named: "PainScale0")
        } else if (sender.value == 1.0) {
        PainFaces.image = UIImage.init(named: "PainScale1")
        } else if (sender.value == 2.0) {
        PainFaces.image = UIImage.init(named: "PainScale2")
        } else if (sender.value == 3.0) {
        PainFaces.image = UIImage.init(named: "PainScale3")
        } else if (sender.value == 4.0) {
        PainFaces.image = UIImage.init(named: "PainScale4")
        } else if (sender.value == 5.0) {
        PainFaces.image = UIImage.init(named: "PainScale5")
        }
        PainNumber = String(sender.value * 2)
    }
    
    @IBAction func S1toMM(_ sender: Any) {
        self.performSegue(withIdentifier: "S1toMM", sender: self)
    }
    
    @IBAction func ToSurvey2(_ sender: Any) {
         if (self.Catheterize == "" || self.HighBlood == "" || self.GenAppetite == "" || self.Activity == "" || self.Medical == "" || self.PainNumber == "") {
                   let alert = UIAlertController(title: "Incomplete fields" , message: "Are you sure you want to continue?", preferredStyle: UIAlertController.Style.alert)
                   alert.addAction(UIAlertAction(title: "Go Back", style: UIAlertAction.Style.default, handler: { (action) in
                       alert.dismiss(animated: true, completion: nil)
                   }))
                   alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: { (action) in
                       alert.dismiss(animated: true, completion: nil)
                       self.performSegue(withIdentifier: "ToSurvey2", sender: self)
                   }))
                   self.present(alert, animated: true, completion: nil)
               } else {
                   self.performSegue(withIdentifier: "ToSurvey2", sender: self)
               }
    }
    
    
    struct FullSurvey: Codable {

        let Catheterize: String
        let Blood: String?
        let Appetite: String?
        let Activity: String?
        let NerveInc: String?
        let PainScale: String?
        let VisitInfo: String?
        

        enum CodingKeys: String, CodingKey {
            case Catheterize
            case Blood
            case Appetite
            case Activity
            case NerveInc
            case PainScale
            case VisitInfo
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToSurvey2" {
        let present = segue.destination as! Survey2Controller
        present.Catheterize = self.Catheterize
        present.Blood = self.HighBlood
        present.Appetite = self.GenAppetite
        present.Activity = self.Activity
        present.NerveInc = self.NerveNum.text ?? String()
        present.PainScale = self.PainNumber
        present.VisitInfo = self.Medical + (self.VisitDetails.text ?? String()) + ": " 
        present.DTDate = (self.Date.date - extrahours)
        }
    }
}

