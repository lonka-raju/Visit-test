//
//  OverviewVC.swift
//  Visitation
//
//  Created by Quadrant Apple on 12/27/19.
//  Copyright © 2019 Quadrant. All rights reserved.
//

import UIKit

@available(iOS 10.0, *)
class OverviewVC: UIViewController {
    
    @IBOutlet var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.backgroundColor = UIColor(displayP3Red: 25/255, green: 33/255, blue: 59/255, alpha: 1.0).withAlphaComponent(0.8)
        
        containerView.isOpaque = false
        containerView.isHidden = true
    }

    @IBAction func yesBtn(_ sender: Any) {
        let Home = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
               self.navigationController?.pushViewController(Home, animated: false)
    }
    
    @IBAction func NoBtn(_ sender: Any) {
         let Home = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                      self.navigationController?.pushViewController(Home, animated: false)
    }
    
    @IBAction func prevBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveBtn(_ sender: Any) {
         containerView.isHidden = false

    }
}

