//
//  RegistrationVC.swift
//  Visitation
//
//  Created by Quadrant Apple on 12/18/19.
//  Copyright © 2019 Quadrant. All rights reserved.
//

import UIKit

class RegistrationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

    @IBAction func next()
    {
        let registration = self.storyboard?.instantiateViewController(withIdentifier: "PaymentSelectVC") as! PaymentSelectVC
               self.navigationController?.pushViewController(registration, animated: false)
    }

}
