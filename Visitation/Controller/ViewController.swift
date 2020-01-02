//
//  ViewController.swift
//  Visitation
//
//  Created by Quadrant Apple on 12/18/19.
//  Copyright © 2019 Quadrant. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import EventKit

@available(iOS 10.0, *)
class ViewController: UIViewController {

    fileprivate var alertStyle: UIAlertController.Style = .actionSheet
    let store = EKEventStore()
    var event: EKEvent?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        let button = FBLoginButton(permissions: [.publicProfile])
//           button.delegate = self
//           button.center = view.center
//           view.addSubview(button)
        
        self.eventSyncWithCalender()
    }
    
    func eventSyncWithCalender(){
        
             let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
        
                // Create start and end date NSDate instances to build a predicate for which events to select
        let startDate = dateFormatter.date(from: "2019-12-27")
        let endDate = dateFormatter.date(from: "2019-12-28")
        
        
       self.createEventinTheCalendar(with: "Christmas celebrations", forDate:startDate!, toDate:endDate!)
    }
    
    func createEventinTheCalendar(with title:String, forDate eventStartDate:Date, toDate eventEndDate:Date) {
        
        store.requestAccess(to: .event) { (success, error) in
            // if i did not find it, then i create a new one
            if self.event == nil {
//                self.event = EKEvent(eventStore: self.store)
                
                if  error == nil {
                    
                    let event = EKEvent.init(eventStore: self.store)
                    event.isAllDay = true
                    event.title = title
                    
                    event.notes = "all families full enjoy with christmas tree-description"
                    event.calendar = self.store.defaultCalendarForNewEvents // this will return deafult calendar from device calendars
                    event.startDate = eventStartDate
                    event.endDate = eventEndDate
                    
                    let alarm = EKAlarm.init(absoluteDate: Date.init(timeInterval: -3600, since: event.startDate))
                    event.addAlarm(alarm)
                    
                    do {
                        try self.store.save(event, span: .thisEvent)
                        //event created successfullt to default calendar
                    } catch let error as NSError {
                        print("failed to save event with error : \(error)")
                    }

                } else {
                    //we have error in getting access to device calnedar
                    print("error = \(String(describing: error?.localizedDescription))")
                }
            }
            
        }
    }
    // MARK: LoginButtonDelegate

//    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
//      print("Did complete login via LoginButton with result \(String(describing: result)) " +
//        "error\(String(describing: error))")
//    }
//
//    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
//      print("Did logout via LoginButton")
//    }
    
    
    @IBAction func loginWithEmailAction(_ sender: Any) {
       // self.openDatePicket()
        self.loginForm()
    }
    
    func openDatePicket() {
        let alert = UIAlertController(style: self.alertStyle, title: "Date Picker", message: "Select Date")
        alert.addDatePicker(mode: .date, date: Date(), minimumDate: nil, maximumDate: nil) { date in
            print("done",date)
        }
        alert.addAction(title: "Done", style: .cancel)
        alert.show()
        

    }
    
    func loginForm(){
        let alert = UIAlertController(style: .alert)
                   let textFieldOne: TextField.Config = { textField in
                       textField.left(image: #imageLiteral(resourceName: "user"), color: UIColor(hex: 0x007AFF))
                       textField.leftViewPadding = 16
                       textField.leftTextPadding = 12
                       textField.becomeFirstResponder()
                       textField.backgroundColor = nil
                       textField.textColor = .black
                       textField.placeholder = "Name"
                       textField.clearButtonMode = .whileEditing
                       textField.autocapitalizationType = .none
                       textField.keyboardAppearance = .default
                       textField.keyboardType = .default
                       textField.returnKeyType = .continue
                       textField.action { textField in
                           Log("textField = \(String(describing: textField.text))")
                       }
                   }
                   
                   let textFieldTwo: TextField.Config = { textField in
                       textField.left(image: #imageLiteral(resourceName: "padlock"), color: UIColor(hex: 0x007AFF))
                       textField.leftViewPadding = 16
                       textField.leftTextPadding = 12
                       textField.borderWidth = 1
                       textField.borderColor = UIColor.lightGray.withAlphaComponent(0.5)
                       textField.backgroundColor = nil
                       textField.textColor = .black
                       textField.placeholder = "Password"
                       textField.clearsOnBeginEditing = true
                       textField.autocapitalizationType = .none
                       textField.keyboardAppearance = .default
                       textField.keyboardType = .default
                       textField.isSecureTextEntry = true
                       textField.returnKeyType = .done
                       textField.action { textField in
                           Log("textField = \(String(describing: textField.text))")
                       }
                   }
                   
                   alert.addTwoTextFields(
                       height: self.alertStyle == .alert ? 44 : 58,
                       hInset: self.alertStyle == .alert ? 12 : 0,
                       vInset: self.alertStyle == .alert ? 12 : 0,
                       textFieldOne: textFieldOne,
                       textFieldTwo: textFieldTwo)
                   
                   alert.addAction(title: "Sign in", style: .cancel, handler: loginHandler)
                   alert.show()
    }
    
    func loginHandler(alert: UIAlertAction){
        print("User tapped: \(alert.title)")
    }
    
    @IBAction func loginWithFacebook(_ sender: Any) {
        self.loginWithFacebook()
    }
    
    @IBAction func registrationAction(_ sender: Any) {
        let registration = self.storyboard?.instantiateViewController(withIdentifier: "registration_vc") as! RegistrationVC
        self.navigationController?.pushViewController(registration, animated: false)
        

        
//        let Overview = self.storyboard?.instantiateViewController(withIdentifier: "OverviewVC") as! OverviewVC
//        self.navigationController?.pushViewController(Overview, animated: false)
    }
    
    @IBAction func logOutAction(_ sender: Any) {
//        let loginManager = LoginManager()
//        loginManager.logOut()
//        print("logout successfully")
        let schoolCal = self.storyboard?.instantiateViewController(withIdentifier: "school_calender")
        self.navigationController?.pushViewController(schoolCal!, animated: false)
    }
    
    func loginWithFacebook(){
        let loginManager = LoginManager()
        loginManager.logIn(permissions: [.email, .publicProfile, .userFriends], viewController: self) { result in
          self.loginManagerDidComplete(result)
        }
    }
    
    func loginManagerDidComplete(_ result: LoginResult) {
       print("login result:",result)
        switch result {
            case .failed(let error):
                   print(error)
            case .cancelled:
                   print("Cancelled")
            case .success(_,_,_):
                   let params = ["fields" : "id, name, email, first_name, last_name, picture.type(large)"]
                   let graphRequest = GraphRequest(graphPath: "/me", parameters: params)
                   graphRequest.start(completionHandler: {( connection, result, error) in
                        if let error = error as Error? {
                            print(error.localizedDescription)
                        }
                    print("result is:::",result as Any)

//                        if let result = result as? [String: String],
//                            let id = result["id"],
//                            let firstName = result["first_name"],
//                            let lastName = result["last_name"],
                       //     let email = result["email"]
                    
                   // print("response details: ",firstName)
                        })
        }
     }
}
