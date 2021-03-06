//
//  SignUpViewController.swift
//  SeniorVolunteer
//

//

import UIKit
import Firebase
import FirebaseAuth
class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var User_NameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var errorLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    func setUpElements() {
    
        // Hide the error label
        errorLabel.alpha = 0
    
        // Style the elements
        Utilities.styleTextField(firstNameText)
        Utilities.styleTextField(lastNameText)
        Utilities.styleTextField(User_NameText)
        Utilities.styleTextField(emailText)
        Utilities.styleTextField(passwordText)
        Utilities.styleFilledButton(signUp)
    }
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if firstNameText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            User_NameText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            
            return "Please fill in all fields."
        }
        
        // Check if the password is secure
        let cleanedPassword = passwordText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            // Password isn't secure enough
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        return nil
    }

    @IBAction func signUpTapped(_ sender: Any) {
        let error = validateFields()
        
        if error != nil {
            
            // There's something wrong with the fields, show error message
            showError(error!)
        }
        else {
        showAlert()
        }
    }
    
        
    //if error
    func showError(_ message:String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    //go to home view
    func transitionToHome() {
        let firstPageNavigationViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.firstPageNavigationViewController) as? FirstPageNavigationViewController
        
        view.window?.rootViewController = firstPageNavigationViewController
        view.window?.makeKeyAndVisible()
    }
    
    //insert user data to database
    func FirebaseinsertData_Senior(){
        // Create cleaned versions of the data
        let firstName = firstNameText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let lastName = lastNameText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = emailText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let User_Name = User_NameText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        //let type: String = "Senior"
        
        // Create the user
        Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            
            // Check for errors
            if err != nil {
                
                // There was an error creating the user
                self.showError("Error creating user")
            }
            else {
                // User was created successfully, now store the first name and last name
                let db = Firestore.firestore()
                if Auth.auth().currentUser != nil {
                    let user = Auth.auth().currentUser
                    if let user = user {
                db.collection("users").document(user.uid).setData(["User_Name":User_Name,"firstname":firstName, "lastname":lastName,"uid": result!.user.uid ]) { (error) in
                    
                    if error != nil {
                        // Show error message
                        self.showError("Error saving user data")
                            }
                        }
                    }
                }
                // Transition to the home screen
                self.transitionToHome()
            }
            
        }
    }
    
    //insert user data to database
//    func FirebaseinsertData_Volunteer(){
        // Create cleaned versions of the data
  //      let firstName = firstNameText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
  //      let lastName = lastNameText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
   //     let email = emailText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
  //      let password = passwordText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        //let type: String = "Volunteer"
        
        // Create the user
  //      Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            
            // Check for errors
   //         if err != nil {
                
                // There was an error creating the user
   //             self.showError("Error creating user")
   //         }
   //         else {
                
                // User was created successfully, now store the first name and last name
   //             let db = Firestore.firestore()
                
   //             db.collection("users").document("Volunteer").setData(["firstname":firstName, "lastname":lastName,"uid": result!.user.uid ]) { (error) in
                    
   //                 if error != nil {
                        // Show error message
     //                   self.showError("Error saving user data")
     //               }
     //           }
                
                // Transition to the home screen
      //          self.transitionToHome()
     //       }
            
     //   }
  //  }
    //show senior confirm alert
    func showAlert() {
        let alert = UIAlertController(title: "Your Account detail", message: "did you confirm data is true?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Sure!", style: .default, handler: {action in self.FirebaseinsertData_Senior()}))
        alert.addAction(UIAlertAction(title: "no!", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    //show volunteer confirm alert
//    func showVAlert() {
  //      let alert = UIAlertController(title: "Your Account Type is Volunteer?", message: "Are you sure?", preferredStyle: .alert)
  //      alert.addAction(UIAlertAction(title: "Sure!", style: .default, handler: {action in self.FirebaseinsertData_Volunteer()}))
 //       alert.addAction(UIAlertAction(title: "no!", style: .cancel, handler: nil))
  //      present(alert, animated: true)
 //  }
}
