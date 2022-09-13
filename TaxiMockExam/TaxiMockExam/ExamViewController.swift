//
//  ExamViewController.swift
//  TaxiMockExam
//
//  Created by Ray on 13/1/2020.
//  Copyright © 2020 HeeSolutionsLimited. All rights reserved.
//

import UIKit

struct staticVariable2 { static let AnswerTableCellIdentifier = "AnswerTableCellIdentifier" }

class ExamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var selectedRowIndex: Int = -1
    var selectedFlag:Bool = false
    
    @IBOutlet weak var autoLabel: UILabel!
    @IBOutlet weak var autoDurationSwitch: UISegmentedControl!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerTableView: UITableView!
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    let cellReuseIdentifier = "cell"
    
    var answerList:[String] = []
    var questionString:String = ""
    var answerDisplayIndex:Int = 0
    var answerString:String = ""
    var questionRandomIndex:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NSLog("ExamViewController")
        
    self.answerTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        
        answerTableView.delegate = self
        answerTableView.dataSource = self
        let nib = UINib(nibName: "AnswerTableViewCell", bundle: nil)
        answerTableView.register(nib, forCellReuseIdentifier: staticVariable2.AnswerTableCellIdentifier)
        
        answerTableView.backgroundColor = UIColor.clear
        
        reloadQuestion()
        
    }
    
    func reloadQuestion(){
        
        selectedFlag = false
        selectedRowIndex = -1
        
        let questionRandomIndex1 = Int.random(in: 0 ..< Manager.shared.questionFullList().count )
        let questionRandomIndex2 = Int.random(in: 0 ..< Manager.shared.questionFullList().count )
        let questionRandomIndex3 = Int.random(in: 0 ..< Manager.shared.questionFullList().count )

        let questionString1 = Manager.shared.questionFullList()[questionRandomIndex1][0]
        let questionString2 = Manager.shared.questionFullList()[questionRandomIndex2][0]
        let questionString3 = Manager.shared.questionFullList()[questionRandomIndex3][0]
        
        let defaults = UserDefaults.standard
        let ask1:Int = defaults.integer(forKey: questionString1 + "_ask")
        let ask2:Int = defaults.integer(forKey: questionString2 + "_ask")
        let ask3:Int = defaults.integer(forKey: questionString3 + "_ask")

        if ( ask1 <= ask2 && ask1 <= ask3 ){
            questionRandomIndex = questionRandomIndex1
        }else if ( ask2 <= ask1 && ask2 <= ask3 ){
            questionRandomIndex = questionRandomIndex2
        }else if ( ask3 <= ask1 && ask3 <= ask2 ){
            questionRandomIndex = questionRandomIndex3
        }else {
            questionRandomIndex = questionRandomIndex1
        }
                
//        questionRandomIndex = Int.random(in: 0 ..< Manager.shared.questionFullList().count )
        answerDisplayIndex = Int.random(in: 0 ..< 4 )
        
        NSLog( "questionRandomIndex: %i", questionRandomIndex );
        NSLog( "answerDisplayIndex: %i", answerDisplayIndex );
        
        questionString = Manager.shared.questionFullList()[questionRandomIndex][0]
        answerString = Manager.shared.questionFullList()[questionRandomIndex][1]
        
        NSLog( "questionString: %@", questionString );
        NSLog( "answerString: %@", answerString );
        
        let isRoad:String = Manager.shared.questionFullList()[questionRandomIndex][2]
        
        if ( isRoad.contains("S") ) {
            answerList = reloadAnswerListWith(choiceList:  Manager.shared.roadFullList(), finalAnswer:answerString )
        }else{
            answerList = reloadAnswerListWith( choiceList:Manager.shared.districtFullList(), finalAnswer: answerString )
        }
        
        answerList[answerDisplayIndex] = answerString;
    
        questionLabel.text = questionString
        
        NSLog( "questionRandomIndex: %i", questionRandomIndex )
        
        let bookmark:Bool = defaults.bool(forKey: questionString + "_bookmark")
        
        if ( bookmark ){
            self.bookmarkButton.isHidden = true
        }else{
            self.bookmarkButton.isHidden = false
        }
        
        answerTableView.reloadData()
        
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answerList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }

    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell:AnswerTableViewCell? = (tableView.dequeueReusableCell(
            withIdentifier: staticVariable2.AnswerTableCellIdentifier) as? AnswerTableViewCell)
        
        if cell == nil {
            cell = (UITableViewCell(style: .subtitle, reuseIdentifier: staticVariable2.AnswerTableCellIdentifier) as? AnswerTableViewCell)
        }

        cell?.answerLabel.text = answerList[indexPath.row]
        
        if ( selectedFlag ){
        
            if ( answerDisplayIndex == indexPath.row ){
                cell!.backgroundColor = UIColor.green
            }else if ( selectedRowIndex == indexPath.row ){
                cell!.backgroundColor = UIColor.red
            }else{
                cell!.backgroundColor = UIColor.clear
            }
            
        }else{
            cell!.backgroundColor = UIColor.clear
        }
        
        return cell!
        
    }

    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if ( selectedFlag ){
            return;
        }
        
        selectedFlag = true
        selectedRowIndex = indexPath.row
        
        if ( answerDisplayIndex == indexPath.row ){
            incAsk(key: questionString)
            incPass(key: questionString)
        }else{
            incAsk(key: questionString)
            incFail(key: questionString)
        }
        
        self.answerTableView.reloadData()

        var duration = 0.0
        switch self.autoDurationSwitch.selectedSegmentIndex {
            case 0:
                duration = 0.0
                break;
            case 1:
                duration = 0.5
                break;
            case 2:
                duration = 1.0
                break;
            case 3:
                duration = 1.5
                break;
            case 4:
                duration = 2.0
           default:
               break;
           }  //Switch
        
        if ( duration > 0 ){
            Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { (nil) in
                self.reloadQuestion()
            }
        }
    }
    
    func reloadAnswerListWith( choiceList:[String], finalAnswer:String) -> [String]{

        var isDuplicateAns:Bool = true
        var ans1 = 0
        var ans2 = 0
        var ans3 = 0
        var ans4 = 0
        
        while ( isDuplicateAns ){
        
            isDuplicateAns = false
            
            ans1 = Int.random(in: 0 ..< choiceList.count )
            ans2 = Int.random(in: 0 ..< choiceList.count )
            ans3 = Int.random(in: 0 ..< choiceList.count )
            ans4 = Int.random(in: 0 ..< choiceList.count )
            
            if ( ans1 == ans2 || ans1 == ans3 || ans1 == ans4 ){
                isDuplicateAns = true
            }else if ( ans2 == ans3 || ans2 == ans4 ){
                isDuplicateAns = true
            }else if ( ans3 == ans4 ){
                isDuplicateAns = true
            }
            
            if ( finalAnswer.isEqual( choiceList[ans1] ) ){
                isDuplicateAns = true
            }else if ( finalAnswer.isEqual( choiceList[ans2] ) ){
                isDuplicateAns = true
            }else if ( finalAnswer.isEqual( choiceList[ans3] ) ){
                isDuplicateAns = true
            }else if ( finalAnswer.isEqual( choiceList[ans4] ) ){
                isDuplicateAns = true
            }
        
        }
        
        var resultList = [String]()

        resultList.append( choiceList[ans1] )
        resultList.append( choiceList[ans2] )
        resultList.append( choiceList[ans3] )
        resultList.append( choiceList[ans4] )
        
        return resultList
        
    }
    
    func incAsk( key:String ){
        self.incStorageWithKey(finalKey: key + "_ask" )
    }
    
    func incPass( key:String ){
        self.incStorageWithKey(finalKey: key + "_pass" )
    }
    
    func incFail( key:String ){
        self.incStorageWithKey(finalKey: key + "_fail" )
    }
    
    func incStorageWithKey( finalKey:String ){

        let defaults = UserDefaults.standard
        
        var index:Int = defaults.integer(forKey: finalKey)
        
        index += 1
        
        defaults.set(index, forKey: finalKey)

    }
    
    @IBAction func onClickBookmark(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        var bookmark:Bool = defaults.bool(forKey: questionString + "_bookmark")
        
        bookmark = !bookmark
        defaults.set(bookmark, forKey: questionString + "_bookmark" )
        
        self.bookmarkButton.isHidden = true;
    }
    
    @IBAction func onClickNext(_ sender: Any) {
        self.reloadQuestion()
    }
    
}
