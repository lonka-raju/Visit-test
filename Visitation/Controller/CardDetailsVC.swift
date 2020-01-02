//
//  CardDetailsVC.swift
//  Visitation
//
//  Created by Quadrant Apple on 12/20/19.
//  Copyright © 2019 Quadrant. All rights reserved.
//

import UIKit

class CardDetailsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func choosePlanAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
 
    @IBAction func NextBtn(_ sender: Any) {
        let Custodial = self.storyboard?.instantiateViewController(withIdentifier: "CustodialVC") as! CustodialVC
        self.navigationController?.pushViewController(Custodial, animated: false)
    }
}
