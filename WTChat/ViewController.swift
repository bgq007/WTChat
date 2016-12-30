//
//  ViewController.swift
//  WTChat
//
//  Created by William Pronovost on 12/24/16.
//  Copyright © 2016 William Pronovost. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase



class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passTextField: UITextField!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = UIColor.brown
        
   
        
    }
    
    
    @IBAction func signinButton(_ sender: Any) {
     FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passTextField.text!, completion: { (user, error) in
        print("We tried to sign in")
        if error != nil {
            print("Error: \(error)")
            
            FIRAuth.auth()?.createUser(withEmail: self.emailTextField.text!, password: self.passTextField.text!, completion: { (user, error) in
                print("We tried to create a user")
                
                if error != nil {
                    print("Error: \(error)")
                } else {
                    print("Created User!")
                    FIRDatabase.database().reference().child("users").child(user!.uid).child("email").setValue(user!.email!)
                    self.performSegue(withIdentifier: "signinSegue", sender: nil)
                }
                
                
            })
        } else {
            print("Signed in")
            self.performSegue(withIdentifier: "signinSegue", sender: nil)
        }
     })
    
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

