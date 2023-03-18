//
//  UserViewController.swift
//  Codee
//
//  Created by Ray Cheng on 14/9/2022.
//

import UIKit

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: Int = 8) {
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: corners,
                                     cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
}
class UserListViewController: UIViewController,
      UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    struct staticVariable { static let UserCollectionCellIdentifier = "UserCollectionCellIdentifier" }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mainContainer: UIView!
    @IBOutlet weak var titleView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initData()
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initUI()
    }
    
    func initData(){
        
    }
    
    func initUI(){
        let nibCell = UINib(nibName: "UserCollectionCell", bundle: nil)
        self.collectionView.register(nibCell, forCellWithReuseIdentifier: staticVariable.UserCollectionCellIdentifier)
        self.collectionView.delegate=self;
        self.collectionView.dataSource=self;
        
        let colorContainer = UIColor(red: 254/255.0, green: 246/255.0, blue: 226/255.0, alpha: 1)
        let colorPurple = UIColor(red: 151/255.0, green: 155/255.0, blue: 218/255.0, alpha: 1)
        self.mainContainer.backgroundColor=colorContainer
        self.mainContainer.layer.cornerRadius=10
        
        self.titleView.backgroundColor=colorPurple
        self.titleView.layer.cornerRadius=10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Manager.userList.count+1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: staticVariable.UserCollectionCellIdentifier, for: indexPath) as! UserCollectionCell
        
        if ( indexPath.row < Manager.userList.count ){
                let user=Manager.userList[indexPath.row]
            cell.nameLabel.text=user.name
        
            if ( indexPath.row == Manager.currUserIndex ){
                cell.backgroundColor = .green
            }
        }else if ( indexPath.row == Manager.userList.count ){
            cell.nameLabel.text="+"
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
        if ( indexPath.row == Manager.currUserIndex ){
            self.navigationController?.popViewController(animated: false)
        }else if ( indexPath.row == Manager.userList.count ){
            //Add new user
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "CreateUserViewController") as! CreateUserViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            
            Manager.currUserIndex = indexPath.row
            Manager.currUser = Manager.userList[indexPath.row]
            Manager.reloadCurrUserBadgetList()

            self.navigationController?.popViewController(animated: false)
        }

    }
    
}
