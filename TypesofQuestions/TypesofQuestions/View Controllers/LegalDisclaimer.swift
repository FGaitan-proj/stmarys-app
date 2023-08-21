//
//  LegalDisclaimer.swift
//  
//
//  Created by Fernando Gaitan on 7/29/20.
//

import UIKit

class LegalDisclaimer: UIViewController {

    @IBOutlet weak var titleDisclaimer: UITextView!
    

    @IBOutlet weak var disclaimer: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


    @IBAction func backTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "backDisclaimer", sender: self)
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "nextDisclaimer", sender: self)
    }
}
