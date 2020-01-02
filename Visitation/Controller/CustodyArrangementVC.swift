
//
//  CustodyArrangementVC.swift
//  Visitation
//
//  Created by Quadrant Apple on 12/24/19.
//  Copyright © 2019 Quadrant. All rights reserved.
//

import UIKit

class CustodyArrangementVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UIPickerViewDataSource, UIPickerViewDelegate {
   
    @IBOutlet weak var numberOfDays: UIButton!
    var daysAray = ["Monday","Tuesday","Wednessday","Thursday","Friday","Saturday","Sunday"]
    fileprivate var alertStyle: UIAlertController.Style = .actionSheet
    var childCountArray = ["First", "Second", "Third", "Fouth", "Fifth", "Sixth","Seventh","Eighth","Ninth","Tenth"]
    @IBOutlet weak var collectionView: UICollectionView!
    private var dismissViewTap: UITapGestureRecognizer?
    @IBOutlet weak var daysPicker: UIPickerView!
    @IBOutlet weak var dateBtn: UIButton!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            dismissViewTap = UITapGestureRecognizer(target: self, action: #selector(dismissView))
                   if let tap = dismissViewTap {
                       view.addGestureRecognizer(tap)
                   }
            daysPicker.isHidden = true
            daysPicker.delegate = self
            daysPicker.dataSource = self
            collectionView.register(UINib (nibName: "ChildCell", bundle: nil), forCellWithReuseIdentifier: "cellId")
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.childCountArray.count
        }
    
    @IBAction func dateBtnAction(_ sender: Any) {
        self.openDatePicker()
    }
    
    @IBAction func dayAction(_ sender: Any) {
        daysPicker.isHidden = false
    }
    
    func openDatePicker() {
        let alert = UIAlertController(style: self.alertStyle, title: "Date Picker", message: "Select Date")
        alert.addDatePicker(mode: .date, date: Date(), minimumDate: nil, maximumDate: nil) { date in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.locale = Locale(identifier: NSLocalizedString("it_IT", comment: ""))
            let dateString = dateFormatter.string(from: date).capitalized
            print(dateString)
            self.dateBtn.setTitle(dateString, for: .normal)
        }
        alert.addAction(title: "Done", style: .cancel)
        alert.show()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ChildCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath as IndexPath) as! ChildCell
        cell.lbl.text = "\(indexPath.row + 1)"
        return cell
    }
    
    @IBAction func previousAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func nextAction(_ sender: Any) {
        let schoolCal = self.storyboard?.instantiateViewController(withIdentifier: "school_calender")
        self.navigationController?.pushViewController(schoolCal!, animated: false)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return daysAray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         return daysAray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        let selectedday = daysAray[row]
        self.numberOfDays.setTitle(selectedday, for: .normal)
    }
    
    @objc private func dismissView() {
        guard daysPicker.isHidden == false else {
            return
        }
        daysPicker.isHidden = true
    }
}
