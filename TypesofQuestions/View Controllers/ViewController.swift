//
//  ViewController.swift
//  TypesofQuestions
//
//  Created by Fernando Gaitan on 7/16/20.
//  Copyright © 2020 Fernando Gaitan & Rachel Morrow. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setUpElements()
        if UserDefaults.standard.bool(forKey: "LoggedIn") {
            Auth.auth().signIn(withEmail: UserDefaults.standard.object(forKey: "email") as! String, password: UserDefaults.standard.object(forKey: "password") as! String) { (result, error) in
                let MainMenuController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.MainMenuController) as? MainMenuController
                  
                self.view.window?.rootViewController = MainMenuController
                self.view.window?.makeKeyAndVisible()
            }
        }

    }
    
    func setUpElements() {
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
        
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
