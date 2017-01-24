//
//  SnapsViewController.swift
//  WTChat
//
//  Created by William Pronovost on 12/24/16.
//  Copyright © 2016 William Pronovost. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuth

class SnapsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var messages : [Message] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.brown
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("message").observe(FIRDataEventType.childAdded, with: { (snapshot) in
            print(snapshot)
            
            
            
            
            let message = Message()
            message.imageURL = (snapshot.value as! NSDictionary)["imageURL"] as! String
            message.from =  (snapshot.value as! NSDictionary)["from"] as! String
            message.descrip =  (snapshot.value as! NSDictionary)["description"] as! String
            message.key = snapshot.key
            message.uuid = (snapshot.value as! NSDictionary)["uuid"] as! String
            
            self.messages.append(message)
            self.tableView.reloadData()
            self.tableView.backgroundColor = UIColor.clear
            self.tableView.sectionIndexBackgroundColor = UIColor.brown
            
            
        })
        
        FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("message").observe(FIRDataEventType.childRemoved, with: { (snapshot) in
            print(snapshot)
            
           var index = 0
            for message in self.messages {
                if message.key == snapshot.key {
                    self.messages.remove(at: index)
                }
                index += 1
            }
            self.tableView.reloadData()
        })
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let message = messages[indexPath.row]
        
        cell.textLabel?.text = message.from
        
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let message = messages[indexPath.row]
        performSegue(withIdentifier: "viewMessageSegue", sender: message)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "viewMessageSegue" {
        let nextVC = segue.destination as! ViewMessageViewController
        nextVC.message = sender as! Message
    }
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
    dismiss(animated: true, completion:  nil)
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
