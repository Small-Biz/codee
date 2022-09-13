//
//  ResultViewController.swift
//  TaxiMockExam
//
//  Created by Ray on 13/1/2020.
//  Copyright © 2020 HeeSolutionsLimited. All rights reserved.
//

import UIKit

struct staticVariable { static let ResultTableCellIdentifier = "ResultTableCellIdentifier" }

class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var modeSwitch: UISegmentedControl!
    @IBOutlet weak var resultTableView: UITableView!
    
    struct Record {
        let index: Int
        let question: String
        let answer: String
        let ask: Int
        let pass: Int
        let fail: Int
    }
    
    let cellReuseIdentifier = "cell"
    var questionList = [[String]]()
    var recordList = [Record]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NSLog("ResultViewController")
        
        self.resultTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
//        self.resultTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        resultTableView.delegate = self
        resultTableView.dataSource = self
        
        let nib = UINib(nibName: "ResultTableViewCell", bundle: nil)
        resultTableView.register(nib, forCellReuseIdentifier: staticVariable.ResultTableCellIdentifier)
        
        resultTableView.backgroundColor = UIColor.clear

        questionList = Manager.shared.questionFullList()
        
//        questionList.reverse()

        let defaults = UserDefaults.standard
        
        for n in 1...(questionList.count-1) {
//            print(n)
            let questionString = questionList[n][0]
            let answerString = questionList[n][1]
            
            let ask:Int = defaults.integer(forKey: questionString + "_ask")
            let pass:Int = defaults.integer(forKey: questionString + "_pass")
            let fail:Int = defaults.integer(forKey: questionString + "_fail")
            
            var record:Record = Record(index: n, question:questionString, answer: answerString, ask:ask, pass:pass, fail:fail)
            recordList.append(record)
            
        }
        
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 15.0
    }

    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

//        let cell = self.resultTableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)

        
        // create a new cell if needed or reuse an old one

        var cell:ResultTableViewCell? = (tableView.dequeueReusableCell(
            withIdentifier: staticVariable.ResultTableCellIdentifier) as? ResultTableViewCell)
        
        if cell == nil {
            cell = (UITableViewCell(style: .subtitle, reuseIdentifier: staticVariable.ResultTableCellIdentifier) as? ResultTableViewCell)
        }
        

        // set the text from the data model
  
        let questionString = recordList[indexPath.row].question
        cell?.questionLabel.text = questionString
        cell?.answerLabel.text =  recordList[indexPath.row].answer
        
        let defaults = UserDefaults.standard
//        let ask:Int = defaults.integer(forKey: questionString + "_ask")
//        let pass:Int = defaults.integer(forKey: questionString + "_pass")
//        let fail:Int = defaults.integer(forKey: questionString + "_fail")
        
        let bookmark:Bool = defaults.bool(forKey: questionString + "_bookmark")
        
        cell?.askLabel.text = String(recordList[indexPath.row].ask)
        cell?.passLabel.text = String(recordList[indexPath.row].pass)
        cell?.failLabel.text = String(recordList[indexPath.row].fail)

        cell?.questionLabel.textColor = UIColor.white
        cell?.answerLabel.textColor = UIColor.white
        cell?.askLabel.textColor = UIColor.white
        cell?.passLabel.textColor = UIColor.white
        cell?.failLabel.textColor = UIColor.white
        
        if ( bookmark ){
            cell!.backgroundColor = UIColor.lightGray
        }else{
            cell!.backgroundColor = UIColor.clear
        }
        return cell!
        
    }

    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    @IBAction func modeValueChange(_ sender: Any) {
        
        if ( modeSwitch.selectedSegmentIndex == 0 ){
            recordList = recordList.sorted(by: { $0.index < $1.index })
        }else if ( modeSwitch.selectedSegmentIndex == 1 ){
            recordList = recordList.sorted(by: { $0.ask > $1.ask })
        }else if ( modeSwitch.selectedSegmentIndex == 2 ){
            recordList = recordList.sorted(by: { $0.pass > $1.pass })
        }else if ( modeSwitch.selectedSegmentIndex == 3 ){
            recordList = recordList.sorted(by: { $0.fail > $1.fail })
        }
        
        resultTableView.reloadData()
        
    }
}
