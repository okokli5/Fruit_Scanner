//
//  FirstPageViewController.swift
//  Fruit_Scanner
//
//  Created by kin ming ching on 3/4/2022.
//

import UIKit
import Foundation
import Firebase
import FirebaseAuth
class FirstPageViewController: UIViewController {

    @IBOutlet weak var SignOutBtn: UINavigationItem!
    @IBAction func SignOutBtnOnTap(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do{
        try firebaseAuth.signOut()
              let firebaseAuth = Auth.auth()
              print("signout success")
              showAlertS()
          } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
          }
    }
    func toHomeView(){
        let namestoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = namestoryboard.instantiateViewController(withIdentifier: "LoginHomeViewController") as! LoginHomeViewController
        view.window?.rootViewController = vc
        view.window?.makeKeyAndVisible()
    }
    func showAlertS(){
        let alert = UIAlertController(title: "SignOut Success!", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok!", style: .cancel, handler: {action in self.toHomeView()}))
        present(alert, animated: true)
    }
}