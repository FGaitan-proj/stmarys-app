//
//  Survey2Controller.swift
//  TypesofQuestions
//
//  Created by Fernando Gaitan on 7/14/20.
//  Copyright © 2020 Fernando Gaitan & Rachel Morrow. All rights reserved.
//

import UIKit

class Survey2Controller: UIViewController {

    var Catheterize = String()
    var Blood = String()
    var Appetite = String()
    var Activity = String()
    var NerveInc = String()
    var PainScale = String()
    var VisitInfo = String()
    var PrintInfo = String()
    var DTDate = Date()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.PrintInfo = DTDate.description + "\n" +
        "Number of times needed to catheterize: " + Catheterize +
        "\nIncidences of high blood pressure: " + Blood +
        "\nGenerally, my appetite is: " + Appetite +
        "\nMy activity level is: " + Activity +
        "\nIncidences of Nerve Pain: " + NerveInc +
        "\nMy pain is: " + PainScale +
        "\n" + VisitInfo
        
        }

    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    }

    @IBAction func S2toS1(_ sender: Any) {
        self.performSegue(withIdentifier: "S2toS1", sender: self)
    }
    
    @IBAction func ToFinalSurvey(_ sender: Any) {
        
        self.performSegue(withIdentifier: "ToFinalSurvey", sender: self)
    }
   

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToFinalSurvey" {
        let present = segue.destination as! FinalSurveyController
            present.Catheterize = self.Catheterize
            present.Blood = self.Blood
            present.Appetite = self.Appetite
            present.NerveInc = self.NerveInc
            present.PainScale = self.PainScale
            present.Activity = self.Activity
            present.VisitInfo = self.VisitInfo
            present.DTDate = self.DTDate
            present.PrintInfo = self.PrintInfo}
    }
    

}

