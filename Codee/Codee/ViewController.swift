//
//  ViewController.swift
//  Codee
//
//  Created by Ray Cheng on 22/8/2022.
//

import UIKit


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    struct staticVariable { static let TaskMenuCollectionCellIdentifier = "TaskMenuCollectionCellIdentifier" }
    
    
    @IBOutlet weak var tab0: UIButton!
    @IBOutlet weak var tab1: UIButton!
    @IBOutlet weak var tab2: UIButton!
    @IBOutlet weak var tab3: UIButton!
    @IBOutlet weak var currentUser: UIButton!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var menuContainerView: UIView!
    
    var taskList:Array<Task>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        //register cell
        let nibCell = UINib(nibName: "TaskMenuCollectionCell", bundle: nil)
        self.collectionView.register(nibCell, forCellWithReuseIdentifier: staticVariable.TaskMenuCollectionCellIdentifier)
        self.collectionView.delegate=self;
        self.collectionView.dataSource=self;

        initData()
        
        initUI()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        reloadUI()
        reloadTaskMenu()
//        tab0.roundCorners(corners: [.topLeft, .topRight], radius: 10)
    }

    func initData(){

        taskList=TaskManager.shared.getTaskList(level: Manager.currLevel)
        
        Manager.reloadData()
//        Manager.storeData()
        Manager.reloadCurrUserBadgetList()
    }
    
    func initUI(){
        self.navigationController?.isNavigationBarHidden = true
        self.menuView.backgroundColor = UIColor.clear;

        let colorRed = UIColor(red: 251/255.0, green: 104/255.0, blue: 133/255.0, alpha: 1)
        let colorYellow = UIColor(red: 254/255.0, green: 201/255.0, blue: 81/255.0, alpha: 1)
        let colorBlue = UIColor(red: 63/255.0, green: 156/255.0, blue: 236/255.0, alpha: 1)
        let colorGreen = UIColor(red: 116/255.0, green: 175/255.0, blue: 80/255.0, alpha: 1)
        
//        254,246,226
        let colorContainer = UIColor(red: 254/255.0, green: 246/255.0, blue: 226/255.0, alpha: 1)
        let colorPurple = UIColor(red: 254/255.0, green: 246/255.0, blue: 226/255.0, alpha: 1)
        let colorOrange = UIColor(red: 248/255.0, green: 188/255.0, blue: 23/255.0, alpha: 1)
        tab0.layer.borderWidth = 5
        tab0.layer.borderColor = colorRed.cgColor
        tab0.backgroundColor=colorRed
        tab0.roundCorners(corners: [.topLeft, .topRight], radius: 15)
        
        tab1.layer.borderWidth = 5
        tab1.layer.borderColor = colorYellow.cgColor
        tab1.backgroundColor=colorYellow
        tab1.roundCorners(corners: [.topLeft, .topRight], radius: 15)
        
        tab2.layer.borderWidth = 5
        tab2.layer.borderColor = colorBlue.cgColor
        tab2.backgroundColor=colorBlue
        tab2.roundCorners(corners: [.topLeft, .topRight], radius: 15)
        
        tab3.layer.borderWidth = 5
        tab3.layer.borderColor = colorGreen.cgColor
        tab3.backgroundColor=colorGreen
        tab3.roundCorners(corners: [.topLeft, .topRight], radius: 15)
        
        menuContainerView.backgroundColor=colorContainer
        menuContainerView.layer.cornerRadius=15
    };
    
    func reloadUI(){
        self.currentUser.titleLabel?.font =  UIFont(name: "KomikaAxis", size: 20)
        self.currentUser.setTitle( Manager.currUser.name, for: .normal)
    }
    
    func reloadTaskMenu(){
        taskList=TaskManager.shared.getTaskList(level: Manager.currLevel)
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.taskList.count;
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: staticVariable.TaskMenuCollectionCellIdentifier, for: indexPath) as! TaskMenuCollectionCell
        let task=taskList[indexPath.row]
        cell.titleLabel.text=task.name
//        let correctImage = UIImage(named: "resource/image/icon_tick.png")
        if ( task.taskId
             <= ( Manager.badgeList.count-1 ) ){
            let imageName = String(format: "badge_%02d.png", Manager.badgeList[task.taskId])
            print("imageName ", imageName)
            let correctImage = UIImage(named: imageName)
            cell.badgeImage.image=correctImage
        }else{
            cell.badgeImage.image=nil
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.size.width/2-5, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let task:Task=taskList[indexPath.row]
        Manager.currTask=task
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "GamePlayViewController") as! GamePlayViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func onClickReception(_ sender: Any) {
        Manager.currLevel=0
        reloadTaskMenu()
    }
    
    @IBAction func onClickYear1(_ sender: Any) {
        Manager.currLevel=1
        reloadTaskMenu()
    }
    
    @IBAction func onClickYear2(_ sender: Any) {
        Manager.currLevel=2
        reloadTaskMenu()
    }
    @IBAction func onClickCurrentUser(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "UserListViewController") as! UserListViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
}

