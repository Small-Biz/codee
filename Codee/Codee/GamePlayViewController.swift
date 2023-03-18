//
//  GamePlayViewController.swift
//  Codee
//
//  Created by Ray Cheng on 26/8/2022.
//

import UIKit

class GamePlayViewController: UIViewController, FullScreenViewDelegate {

    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var questionBoard: UIView!
    @IBOutlet weak var answerBoard: UIView!
    @IBOutlet weak var resultBoard: UIView!
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var firstValue: UILabel!
    @IBOutlet weak var secondValue: UILabel!
    @IBOutlet weak var operatorLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    @IBOutlet weak var answerView: UIView!
    @IBOutlet weak var answer1Button: UIButton!
    @IBOutlet weak var answer2Button: UIButton!
    @IBOutlet weak var answer3Button: UIButton!
    
    @IBOutlet weak var result1ImageView: UIImageView!
    @IBOutlet weak var result2ImageView: UIImageView!
    @IBOutlet weak var result3ImageView: UIImageView!
    
    @IBOutlet weak var totalCorrectImage: UIImageView!
    @IBOutlet weak var totalCorrectLabel: UILabel!
    @IBOutlet weak var totalWrongImage: UIImageView!
    @IBOutlet weak var totalWrongLabel: UILabel!

    var fullScreenView: FullScreenView!
    var gameResultView: GameResultView!
    
    var task:Task!;
    var currentQuestionNum:Int!=0;
    var randomAnswerPosition:Int!=0;
    var totalCorrect:Int!=0;
    var totalWrong:Int!=0;
    var totalQuestion:Int!=0;
    var acceptAnswer:Bool=false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initData()
        initUI()
        
    }

    func initData(){
        task=Manager.currTask!
        totalCorrect=0
        totalWrong=0
        totalQuestion=task?.maxQuestionNum
    }
    
    func initUI(){
        
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        let colorOrange = UIColor(red: 248/255.0, green: 188/255.0, blue: 23/255.0, alpha: 1)
        self.mainView.backgroundColor = colorOrange;
        self.questionBoard.layer.borderWidth = 5
        self.questionBoard.layer.cornerRadius = 15
        self.questionBoard.layer.borderColor = self.questionBoard.backgroundColor?.cgColor
        
        self.answer1Button.layer.borderWidth = 3
        self.answer1Button.layer.cornerRadius = 15
        self.answer1Button.layer.borderColor = UIColor.gray.cgColor
        self.answer1Button.backgroundColor = UIColor.white
        
        self.answer2Button.layer.borderWidth = 3
        self.answer2Button.layer.cornerRadius = 15
        self.answer2Button.layer.borderColor = UIColor.gray.cgColor
        self.answer2Button.backgroundColor = UIColor.white
    
        self.answer3Button.layer.borderWidth = 3
        self.answer3Button.layer.cornerRadius = 15
        self.answer3Button.layer.borderColor = UIColor.gray.cgColor
        self.answer3Button.backgroundColor = UIColor.white
        
        if ( Manager.currLevel==0 ){
            self.levelLabel.text = "Reception";
        }else if ( Manager.currLevel==1){
            self.levelLabel.text = "Year 1";
        }else if ( Manager.currLevel==2){
            self.levelLabel.text = "Year 2";
        }
        
        let correctImage = UIImage(named: "icon_tick.png")
        let wrongImage = UIImage(named: "icon_cross.png")
        totalCorrectImage.image = correctImage
        totalWrongImage.image = wrongImage
        
        firstValue.text="1";
        secondValue.text="3";
        operatorLabel.text="x";
        answerView.backgroundColor=UIColor.clear
        
        updateTotalResult()
        setUpQuestionAnswer()

        gameResultView=GameResultView(frame: self.view.frame)
        self.view.addSubview( gameResultView );
        gameResultView.isHidden=true
        
        fullScreenView=FullScreenView(frame: self.view.frame)
        self.view.addSubview( fullScreenView );

        fullScreenView.delegate=self
        fullScreenView.disableView()

    };
    
    func updateTotalResult(){
        
        totalCorrectLabel.text=String(totalCorrect)
        totalWrongLabel.text=String(totalWrong)
    }
    
    func clearQuestionAnswer(){
        result1ImageView.image = nil
        result2ImageView.image = nil
        result3ImageView.image = nil
    }
    
    func setUpQuestionAnswer(){
        
        currentQuestionNum+=1
        questionNumberLabel.text = String(format: "Q%02d/%02d", currentQuestionNum, totalQuestion)
        
        var firstFactor=0
        var secondFactor=Int.random(in: 2..<10);
        
        if ( task.type=="plus"){
            operatorLabel.text="+"
                        
            firstFactor=Int.random(in: 1..<task.numFactor-1);
            secondFactor=Int.random(in: 1..<(task.numFactor-firstFactor));
            
        }else if ( task.type=="multipy"){
            operatorLabel.text="x"
            
            if ( !task.random ){
                firstFactor=task.numFactor
            }else{
                firstFactor=Int.random(in: (task.numFactor-2)..<task.numFactor);
            }
        }else if ( task.type=="minus"){
            operatorLabel.text="-"
            
            secondFactor=Int.random(in: 1..<task.numFactor-1);
            let thirdFactor=Int.random(in: 1..<(task.numFactor-firstFactor));
            firstFactor=secondFactor+thirdFactor
        }

        firstValue.text=String(firstFactor)
        secondValue.text=String(secondFactor)
        
        var answer1=firstFactor*secondFactor;
        if ( task.type=="plus"){
            answer1=firstFactor+secondFactor;
        }else if( task.type=="minus"){
            answer1=firstFactor-secondFactor;
        }
        var answer2=answer1;
        var answer3=answer1;
        
        while ( answer2==answer1 || answer2 <= 0 ){
            answer2 = getRamdomAnswer(numFactor: firstFactor, random: task.random, type: task.type)
        }
        while ( answer3==answer1||answer3==answer2 || answer3 < 0 ){
            answer3 = getRamdomAnswer(numFactor: firstFactor, random: task.random, type: task.type)
        }
                
        randomAnswerPosition = Int.random(in: 0..<3);

        switch randomAnswerPosition {
        case 0:
            answer1Button.setTitle(String(answer1), for: .normal)
            answer2Button.setTitle(String(answer2), for: .normal)
            answer3Button.setTitle(String(answer3), for: .normal)
        case 1:
            answer1Button.setTitle(String(answer2), for: .normal)
            answer2Button.setTitle(String(answer1), for: .normal)
            answer3Button.setTitle(String(answer3), for: .normal)
        case 2:
            answer1Button.setTitle(String(answer3), for: .normal)
            answer2Button.setTitle(String(answer2), for: .normal)
            answer3Button.setTitle(String(answer1), for: .normal)
        default:
            print("Have you done something new?")
        }
        answer1Button.setTitleColor(UIColor.black, for: .normal)
        answer2Button.setTitleColor(UIColor.black, for: .normal)
        answer3Button.setTitleColor(UIColor.black, for: .normal)
        
        acceptAnswer=true;
    }
    
    func getRamdomAnswer(numFactor:Int, random:Bool, type:String)-> Int{
        if ( task.type=="plus" ){
            if ( !random){
                return numFactor+Int.random(in: 2..<10);
            }else{
                return Int.random(in: numFactor-1..<numFactor+1)+Int.random(in: 2..<10);
            }
        } else if ( task.type=="minus" ){
            if ( !random){
                return numFactor-Int.random(in: 2..<10);
            }else{
                return Int.random(in: numFactor-1..<numFactor+1)-Int.random(in: 2..<10);
            }
        }else if ( task.type=="multipy"){
            if ( !random){
                return numFactor*Int.random(in: 2..<10);
            }else{
                return Int.random(in: numFactor-1..<numFactor+1)*Int.random(in: 2..<10);
            }
        }else {
            return numFactor*Int.random(in: 2..<10);
        }
        
    }
    
    @IBAction func onClickAnswer(_ sender: Any) {

        if ( !acceptAnswer ){
            return
        }
        
        acceptAnswer=false;
        
        if ( (sender as! UIButton).tag == randomAnswerPosition){
            totalCorrect+=1;
            let image = UIImage(named: "icon_tick.png")
            if ((sender as! UIButton).tag==0){
                result1ImageView.image = image
            }else if ((sender as! UIButton).tag==1){
                result2ImageView.image = image
            }else if ((sender as! UIButton).tag==2){
                result3ImageView.image = image
            }
            
//            (sender as! UIButton).backgroundColor=UIColor.green
        }else{
            totalWrong+=1;
            let image = UIImage(named: "icon_cross.png")
            if ((sender as! UIButton).tag==0){
                result1ImageView.image = image
            }else if ((sender as! UIButton).tag==1){
                result2ImageView.image = image
            }else if ((sender as! UIButton).tag==2){
                result3ImageView.image = image
            }
            
            if ( randomAnswerPosition == 0 ){
                answer1Button.setTitleColor(UIColor.green, for: .normal)
            }else if ( randomAnswerPosition == 1 ){
                answer2Button.setTitleColor(UIColor.green, for: .normal)
            }else if ( randomAnswerPosition == 2 ){
                answer3Button.setTitleColor(UIColor.green, for: .normal)
            }
            
//            (sender as! UIButton).backgroundColor=UIColor.red
        }
        updateTotalResult()
        
        fullScreenView.enableView()
    }
    
    func tapToContinue(_ controller: FullScreenView) {
        
        fullScreenView.disableView()
        
        if ( currentQuestionNum < totalQuestion ){
            
            clearQuestionAnswer()
            setUpQuestionAnswer()
            
        }else if ( gameResultView.isHidden ){
            
            gameResultView.updateData(correctQuestion: totalCorrect, totalQuestion: totalQuestion)
            gameResultView.isHidden=false
            
            //Check result, if good enough, show badge animation
            if ( task.taskId > Manager.badgeList.count-1 ){
                //The badgeList is not large enough, set all default 0
                while ( task.taskId > Manager.badgeList.count-1 ){
                    Manager.badgeList.append(0)
                }
            }
            
            if ( totalCorrect == totalQuestion ){
                Manager.badgeList[task.taskId]=3
            }else if ( totalCorrect >= totalQuestion*3/4 ){
                Manager.badgeList[task.taskId]=2
            }else if ( totalCorrect == totalQuestion/2 ){
                Manager.badgeList[task.taskId]=1
            }
            
            Manager.storeCurrUserBadgetList()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.fullScreenView.enableView()
            }
        }else{
            self.navigationController?.popViewController(animated: false)
        }
    }
}

