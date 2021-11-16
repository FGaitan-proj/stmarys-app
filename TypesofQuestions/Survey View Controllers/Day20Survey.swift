//
//  20DaySurvey.swift
//  TypesofQuestions
//
//  Created by Rachel Morrow on 8/14/20.
//  Copyright © 2020 Fernando Gaitan & Rachel Morrow. All rights reserved.
//

import UIKit

class Day20Survey: UIViewController {
    
    @IBOutlet var Catheterization: [UIButton]!
    @IBOutlet var YesorNo: [UIButton]!
    @IBOutlet var bloodPressure: [UIButton]!
    
    var Catheterize = String()
    var Change = String()
    var Pressure = String()
    
override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
   /* let tap = UITapGestureRecognizer(target: self.view, action:
        #selector(UIView.endEditing)); view.addGestureRecognizer(tap)*/
}

    @IBAction func catherizeTapped(_ sender: UIButton) {
        Utilities.showonebutton(list: Catheterization, selected: sender, controller: self)
        Catheterize = sender.currentTitle ?? String()
    }
    
    enum yesorno: String {
        case a = "Yes"
        case b = "No"
    }
    
    func fillOne(_ sender: UIButton) {
        YesorNo.forEach {x in
            if x.backgroundImage(for: UIControl.State.normal) == UIImage(systemName: "circle.fill") {
                x.setBackgroundImage(UIImage(systemName: "circle"), for: UIControl.State.normal)
            }
            sender.setBackgroundImage(UIImage(systemName: "circle.fill"), for: UIControl.State.normal)
        }
    }
    
    @IBAction func YesorNoTapped(_ sender: UIButton) {
         guard let title = sender.currentTitle, let _pick = yesorno(rawValue: title) else { return }
                switch _pick {
                case .a:
                    Change = "Yes"
                case .b:
                    Change = "No"
                }
        self.fillOne(sender)
    }
    
    @IBAction func bloodPressureTapped(_ sender: UIButton) {
        Utilities.showonebutton(list: bloodPressure, selected: sender, controller: self)
        Pressure = sender.currentTitle ?? String()
    }
    
    
}
