//
//  ViewMessageViewController.swift
//  WTChat
//
//  Created by William Pronovost on 12/31/16.
//  Copyright © 2016 William Pronovost. All rights reserved.
//

import UIKit
import SDWebImage


class ViewMessageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var descripLabel: UILabel!
    
    var message = Message()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        descripLabel.text = message.descrip
        imageView.sd_setImage(with: URL(string: message.imageURL))
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
