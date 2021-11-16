//
//  SignUpViewController.swift
//  TypesofQuestions
//
//  Created by Fernando Gaitan on 7/16/20.
//  Copyright © 2020 Fernando Gaitan & Rachel Morrow. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore


class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var PatientFNTextfield: UITextField!
    @IBOutlet weak var PatientLNTextfield: UITextField!
    @IBOutlet weak var ProviderFN: UITextField!
    @IBOutlet weak var ProviderEmail: UITextField!
    
    @IBOutlet var SelectRtoP: [UIButton]!
    
    var RelationtoP = String()
    var Provider = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpElements()
    }
    
    func setUpElements() {
        // Hide error label
        errorLabel.alpha = 0
        
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleTextField(PatientLNTextfield)
        Utilities.styleTextField(PatientFNTextfield)
        Utilities.styleTextField(ProviderFN)
        Utilities.styleTextField(ProviderEmail)
        
        Utilities.styleFilledButton(signUpButton)
        self.SelectRtoP.forEach { (button) in
            button.layer.cornerRadius = 25.0
        }
        
    }
    
    
    @IBAction func SelectRtoPbutton(_ sender: UIButton) {
        SelectRtoP.forEach { x in
                          x.isHidden = !x.isHidden
                          sender.isHidden = false}
          self.RelationtoP = sender.currentTitle ?? String()
      }
      
      
      @IBAction func RevealPatientInfo(_ sender: UIButton) {
          self.PatientFNTextfield.isHidden = !PatientFNTextfield.isHidden
          self.PatientLNTextfield.isHidden = !PatientLNTextfield.isHidden
      }
    
    @IBAction func RevealProviderInfo(_ sender: UIButton) {
        self.ProviderFN.isHidden = !ProviderFN.isHidden
        self.ProviderEmail.isHidden = !ProviderEmail.isHidden
        
        if sender.currentTitle == "" {
            UserDefaults.standard.set(false, forKey: "SelfOrParent")}
        else {
            UserDefaults.standard.set(true, forKey: "SelfOrParent")}
        
        self.Provider = sender.currentTitle ?? String()
    }
    
    // Check the fields and validate that the data is correct. If everything is correct this method returns nil. Otherwise it returns the error message.
    func clean(_ str: UITextField) -> String? {
        str.text?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    var patientisempty:Bool = false
    
    func validateFields() -> String? {
        if self.PatientFNTextfield.isHidden == false && self.PatientLNTextfield.isHidden == false {
            self.patientisempty = (clean(self.PatientFNTextfield) == "" || clean(self.PatientLNTextfield) == "")
        }
        // Check that all fields are filled in
        if clean(firstNameTextField) == "" || clean(lastNameTextField) == "" ||
            clean(emailTextField) == "" || clean(passwordTextField) == "" ||
            patientisempty {
            return "Please fill in all fields."
        }
        
        // Check if the password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            // Password isn't secure enough
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        return nil
    }
    
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }

    func transitionToHome() {
        
        let MainMenuController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.MainMenuController) as? MainMenuController
        
        view.window?.rootViewController = MainMenuController
        view.window?.makeKeyAndVisible()
    }

    @IBAction func signUpTapped(_ sender: Any) {
        
        // Validate the fields
        let error = validateFields()
        if error != nil {
            // If there's something wrong in the fields, show error message
            showError(error!)
        }
        else {
            
            // Create cleaned versions of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let relation = RelationtoP.trimmingCharacters(in: .whitespacesAndNewlines)
            let PatientFN = PatientFNTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let PatientLN = PatientLNTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let ProviderFullName = ProviderFN.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let ProviderEmailAddress = ProviderEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                // Check for errors
                if err != nil {
                    // There was an error creating the user
                    self.showError("Error creating user, email already registered")
                }
                else {
                    // User was created successfully, now store the first name and last name
                    let db = Firestore.firestore()
                    db.collection("users").document(result!.user.uid).setData(
                        ["firstname":firstName, "lastname" :lastName, "email" : email, "relation": relation, "PatientFirstname": PatientFN, "Patientlastname": PatientLN, "providername": ProviderFullName, "provideremail":ProviderEmailAddress]) { (error) in
                        if error != nil {
                            // Show error message
                            self.showError("Error saving user data, email already registered")
                        }
                    }
                    
                    // Transition to the main menu
                    UserDefaults.standard.set(email, forKey: "email")
                    UserDefaults.standard.set(password, forKey: "password")
                    UserDefaults.standard.set(self.ProviderEmail.text, forKey: "providerEmail")
                     UserDefaults.standard.set(true, forKey: "LoggedIn")
                     self.transitionToHome()
                }
            }
        }
    }
}
