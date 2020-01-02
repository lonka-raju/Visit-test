//
//  CustodialVC.swift
//  Visitation
//
//  Created by Quadrant Apple on 12/20/19.
//  Copyright © 2019 Quadrant. All rights reserved.
//

import UIKit

class CustodialVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate {
   
    fileprivate var alertStyle: UIAlertController.Style = .actionSheet
    var dateString:String!
    var idsString:String!
    var nameString:String!
    var index:Int!
    var nameIndex:Int!
    
    @IBOutlet weak var tableCellHeightContraint: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    var childCountArray = ["First", "Second", "Third", "Fouth", "Fifth", "Sixth","Sevnth","Eighth","Ninth","Tenth"]
    var childDAtesArray = ["Please select date"]
    var childNamesArray = [""]
    
    @IBOutlet var tableObj:UITableView!
    var cellCount:Int!
    var alertString:String!
    var alertFlag:Bool!
    var selectChildBoolVal:Bool!
    
    var custodialBoolVal:Bool!
    var fatherBoolVal:Bool!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        collectionView.register(UINib (nibName: "ChildCell", bundle: nil), forCellWithReuseIdentifier: "cellId")
        tableObj.register(UINib (nibName: "ChildTableCell", bundle: nil), forCellReuseIdentifier: "cellIdd")
        tableObj.allowsSelection = false
        tableObj.isScrollEnabled = false
        tableObj.isHidden = true
        
        custodialBoolVal = false
        fatherBoolVal = false
        
        alertFlag = false
        selectChildBoolVal = false
    }
    
    // MARK: - UICollectionViewDataSource protocol
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.childCountArray.count
    }
    
    @IBOutlet weak var custodialBtn: UIButton!
    @IBOutlet weak var nonCustodialBtn: UIButton!
    
    @IBAction func custodialAction(_ sender: Any) {
        custodialBoolVal = true
    }
    @IBAction func nonCutodialAction(_ sender: Any) {
        custodialBoolVal = true
    }
    @IBOutlet weak var motherBtn: UIButton!
    @IBOutlet weak var fatherBtn: UIButton!
    
    @IBAction func fatherAction(_ sender: Any) {
        fatherBoolVal = true
    }
    
    @IBAction func moherAction(_ sender: Any) {
        fatherBoolVal = true
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ChildCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath as IndexPath) as! ChildCell
        cell.lbl.text = "\(indexPath.row + 1)"
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectChildBoolVal = true
        tableObj.isHidden = false
        tableCellHeightContraint.constant = CGFloat(150 * (indexPath.item + 1))
        cellCount = indexPath.item + 1
        childDAtesArray.removeAll()
        childNamesArray.removeAll()
        for _ in 0..<cellCount {
            childDAtesArray.append("Please select date")
            childNamesArray.append("")
        }
        tableObj.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return childDAtesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell:ChildTableCell = tableView.dequeueReusableCell(withIdentifier: "cellIdd") as! ChildTableCell
        tableCell.childNumber.text = "Spicify the name and Date of birth of " + " \(childCountArray[indexPath.row])" + " child"
        tableCell.childDateLbl.text = "\(childDAtesArray[indexPath.row])"
        tableCell.childName.text = "\(childNamesArray[indexPath.row])"
        tableCell.dateBtn.tag = indexPath.row
        tableCell.childName.tag = indexPath.row
        tableCell.dateBtn.addTarget(self, action: #selector(dateChange), for: .touchUpInside)
        let textField: UITextField = tableCell.childName
        textField.delegate = self
        return tableCell
    }
    
    @objc func dateChange(sender: UIButton)
    {
        index = sender.tag
        guard let cell = sender.superview?.superview as? ChildTableCell else {
            return
        }
        idsString = childCountArray[index]
        let indexPath = tableObj.indexPath(for: cell)
        let celll:ChildTableCell = tableObj.cellForRow(at: indexPath!) as! ChildTableCell
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
            let indexOfOrderId:Int = self.childCountArray.firstIndex(of: self.idsString)!
            self.childDAtesArray[indexOfOrderId] = self.dateString!
            self.tableObj.reloadData()
        }
        alert.addAction(title: "Done", style: .cancel)
        alert.show()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        nameIndex = textField.tag
        nameString = childCountArray[nameIndex]
        let indexOfOrderId:Int = self.childCountArray.firstIndex(of: self.nameString)!
        self.childNamesArray[indexOfOrderId] = textField.text!
        self.tableObj.reloadData()
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 150
    }
    
    @IBAction func next(){
        if(custodialBoolVal == false)
        {
            alertString = "Please select custodail or non custodial."
            alertFlag = true
        }
        else if(fatherBoolVal == false)
        {
            alertString = "Please select father or mother."
            alertFlag = true
        }
        else if(selectChildBoolVal == false)
        {
            alertString = "Please select number of Childs."
            alertFlag = true
        }
        else{
            alertFlag = false
        }
            if alertFlag == true
            {
                let alert:UIAlertController = UIAlertController(title: "Required!", message: alertString, preferredStyle: .alert)
                let okBtn:UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okBtn)
                present(alert, animated: true, completion: nil)
            }
            else{
                if childDAtesArray.contains("Please select date") {
                    let alert:UIAlertController = UIAlertController(title: "Required!", message: "Please fill all child details.", preferredStyle: .alert)
                    let okBtn:UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(okBtn)
                    present(alert, animated: true, completion: nil)
                }else{
                    if childNamesArray.contains("")
                    {
                        let alert:UIAlertController = UIAlertController(title: "Required!", message: "Please fill all child details.", preferredStyle: .alert)
                        let okBtn:UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(okBtn)
                        present(alert, animated: true, completion: nil)
                    }
                    else{
                        UserDefaults.standard.set(childNamesArray, forKey: "numberOfChildsKey")
                         
                        
                        
                        let CustodyArrangement = self.storyboard?.instantiateViewController(withIdentifier: "CustodyArrangementVC") 
                        self.navigationController?.pushViewController(CustodyArrangement!, animated: false)
                    }
                }
            }
    }
}
