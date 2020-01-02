//
//  PaymentSelectVC.swift
//  Visitation
//
//  Created by Quadrant Apple on 12/19/19.
//  Copyright © 2019 Quadrant. All rights reserved.
//

import UIKit

class PaymentSelectVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func useFreeAction(_ sender: Any) {
       let CardDetails = self.storyboard?.instantiateViewController(withIdentifier: "CardDetailsVC") as! CardDetailsVC
        self.navigationController?.pushViewController(CardDetails, animated: false)
    }
    
   
}
