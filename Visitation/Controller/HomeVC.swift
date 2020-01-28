//
//  HomeVC.swift
//  Visitation
//
//  Created by Quadrant Apple on 12/27/19.
//  Copyright © 2019 Quadrant. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func login(){
    
    let url = "http://localhost:8888/connexion/login=\("_login")&pass=\("_password")"
    let urlString = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
    let request = NSURLRequest(URL: NSURL(string: urlString)!)

        let loginTask = URLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) in

        guard let data = data, let _ = response, error == nil else {
            print("error")
            return
        }

        /*do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            print(json)
        } catch let error as NSError {
            print("json error: \(error.localizedDescription)")
        }*/
        if let httpStatus = response as? NSHTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
      print("statusCode should be 200, but is \(httpStatus.statusCode)")
      print("response = \(response)")
    }

    let responseString = String(data: data!, encoding:NSUTF8StringEncoding)
    print("responseString = \(responseString)")
    })
    loginTask.resume()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
