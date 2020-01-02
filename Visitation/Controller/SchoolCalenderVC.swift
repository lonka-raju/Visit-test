//
//  SchoolCalenderVC.swift
//  Visitation
//
//  Created by Quadrant Apple on 12/24/19.
//  Copyright © 2019 Quadrant. All rights reserved.
//

import UIKit

@available(iOS 10.0, *)
class SchoolCalenderVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
     var alertStyle: UIAlertController.Style = .actionSheet
  var dateString:String!
    var numberOfChildsArray = [String]()
    @IBOutlet weak var collectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.numberOfChildsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell:ChildCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath as IndexPath) as! ChildCell
          cell.lbl.text = "\(indexPath.row + 1)"
          return cell
      }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//           selectChildBoolVal = true
//           tableObj.isHidden = false
//           tableCellHeightContraint.constant = CGFloat(150 * (indexPath.item + 1))
//           cellCount = indexPath.item + 1
//           childDAtesArray.removeAll()
//           childNamesArray.removeAll()
//           for _ in 0..<cellCount {
//               childDAtesArray.append("Please select date")
//               childNamesArray.append("")
//           }
//           tableObj.reloadData()
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.collectionView.delegate = self
               self.collectionView.dataSource = self
               collectionView.register(UINib (nibName: "ChildCell", bundle: nil), forCellWithReuseIdentifier: "cellId")
        
        
         numberOfChildsArray =  UserDefaults.standard.object(forKey: "numberOfChildsKey") as! Array
      print(numberOfChildsArray)

        for _ in 0..<childCount {
            print("child count is = ",childCount)
            fallBreakStart.append("Please select date")
            fallBreakEnd.append("Please select date")
           
            winterBreakStart.append("Please select date")
            winterBreakEnd.append("Please select date")
           
            springBreakStart.append("Please select date")
            springBreakEnd.append("Please select date")
            
            summerBreakStart.append("Please select date")
            summerBreakEnd.append("Please select date")
            
        }
        self.dateAssigning(indexVal: self.selectedChildNumber)
    }
    
    var fallBreakStart = [String]()
    var fallBreakEnd = [String]()

    var winterBreakStart = [String]()
    var winterBreakEnd = [String]()
    
    var springBreakStart = [String]()
    var springBreakEnd = [String]()

    var summerBreakStart = [String]()
    var summerBreakEnd = [String]()
    
    var childCount = 4
    var selectedChildNumber = 0
    var datePickerBtnTag = 0
    
    @IBOutlet weak var childOneBtn: UIButton!
    @IBOutlet weak var childTwoBtn: UIButton!
    @IBOutlet weak var childThreeBtn: UIButton!
    @IBOutlet weak var childFourBtn: UIButton!
    
    @IBAction func childSectionAction(_ sender: UIButton) {
        print("button selected tag is =",sender.tag)
        switch sender.tag{
            case 11:
            self.selectedChildNumber = 0
                break
            case 22:
            self.selectedChildNumber = 1
                break
            case 33:
            self.selectedChildNumber = 2
                break
            case 44:
            self.selectedChildNumber = 3
                break
            default: print("Other...")
        }
        self.dateAssigning(indexVal: self.selectedChildNumber)
    }
    
    
    @IBAction func dateSelectionAction(_ sender: UIButton) {
        print("date selected tag is =",sender.tag)
        switch sender.tag{
            case 111:
            self.datePickerBtnTag = 0
                break
            case 222:
            self.datePickerBtnTag = 1
                break
            case 333:
            self.datePickerBtnTag = 2
                break
            case 444:
            self.datePickerBtnTag = 3
                break
            case 555:
            self.datePickerBtnTag = 4
                break
            case 666:
            self.datePickerBtnTag = 5
                break
            case 777:
            self.datePickerBtnTag = 6
                break
            case 888:
            self.datePickerBtnTag = 7
                break
            default: print("Other...")
        }
        self.openDatePicker()
    }
    
    func openDatePicker() {
           let alert = UIAlertController(style: self.alertStyle, title: "Date Picker", message: "Select Date")
           alert.addDatePicker(mode: .date, date: Date(), minimumDate: nil, maximumDate: nil) { date in
               let dateFormatter = DateFormatter()
               dateFormatter.dateFormat = "dd-MM-yyyy"
               dateFormatter.timeZone = TimeZone.current
               dateFormatter.locale = Locale(identifier: NSLocalizedString("it_IT", comment: ""))
               self.dateString = dateFormatter.string(from: date).capitalized
            print("selected date is ",self.dateString ?? "00")
            print("seleted child number",self.selectedChildNumber)
            print("seleted datePicker Btn Tag ",self.datePickerBtnTag)

            if self.datePickerBtnTag  == 0
            {
                self.fallBreakStart[self.selectedChildNumber] = self.dateString!
            }
            else if self.datePickerBtnTag  == 1{
                self.fallBreakEnd[self.selectedChildNumber] = self.dateString!

            }
            else if self.datePickerBtnTag  == 2{
                self.winterBreakStart[self.selectedChildNumber] = self.dateString!
            }
            else if self.datePickerBtnTag  == 3{
                self.winterBreakEnd[self.selectedChildNumber] = self.dateString!
            }
            else if self.datePickerBtnTag  == 4{
                self.springBreakStart[self.selectedChildNumber] = self.dateString!
            }
            else if self.datePickerBtnTag  == 5{
                self.springBreakEnd[self.selectedChildNumber] = self.dateString!
            }
            else if self.datePickerBtnTag  == 6{
                self.summerBreakStart[self.selectedChildNumber] = self.dateString!
            }
            else if self.datePickerBtnTag  == 7{
                self.summerBreakEnd[self.selectedChildNumber] = self.dateString!
            }
            self.dateAssigning(indexVal: self.selectedChildNumber)
           }
           alert.addAction(title: "Done", style: .cancel)
           alert.show()
       }
    
    func dateAssigning(indexVal: Int){
        fallStartTF.text = self.fallBreakStart[indexVal]
        fallEndTF.text = self.fallBreakEnd[indexVal]
       
        winterStartTF.text = self.winterBreakStart[indexVal]
        winterEndTF.text = self.winterBreakEnd[indexVal]

        springStartTF.text = self.springBreakStart[indexVal]
        springEndTF.text = self.springBreakEnd[indexVal]

        summerStartTF.text = self.summerBreakStart[indexVal]
        summerEndTF.text = self.summerBreakEnd[indexVal]
    }
    
    @IBOutlet weak var fallStartTF: UITextField!
    @IBOutlet weak var fallEndTF: UITextField!
    @IBOutlet weak var winterStartTF: UITextField!
    @IBOutlet weak var winterEndTF: UITextField!
    @IBOutlet weak var springStartTF: UITextField!
    @IBOutlet weak var springEndTF: UITextField!
    @IBOutlet weak var summerStartTF: UITextField!
    @IBOutlet weak var summerEndTF: UITextField!
    
    @IBAction func nextBtnAction(_ sender: Any) {
        let Overview = self.storyboard?.instantiateViewController(withIdentifier: "OverviewVC") as! OverviewVC
        self.navigationController?.pushViewController(Overview, animated: false)
        
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
}
