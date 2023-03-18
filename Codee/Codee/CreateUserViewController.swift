//
//  CreateUserViewController.swift
//  Codee
//
//  Created by Ray Cheng on 14/9/2022.
//

import UIKit

class CreateUserViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var mainContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        initUI()
    }
    
    private func initUI(){
        self.nameTextField.delegate = self
        
        let colorContainer = UIColor(red: 254/255.0, green: 246/255.0, blue: 226/255.0, alpha: 1)
        let colorPurple = UIColor(red: 151/255.0, green: 155/255.0, blue: 218/255.0, alpha: 1)
        self.mainContainer.backgroundColor=colorContainer
        self.mainContainer.layer.cornerRadius=10
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }

    @IBAction func onClickOk(_ sender: Any) {
        
        if ( nameTextField.text != nil && nameTextField.text != "" ){
            
            let newUser = User(name: nameTextField.text!, gender: 0)
            Manager.userList.append(newUser)
            Manager.storeData()
            
            Manager.currUser=newUser
            self.navigationController?.popViewController(animated: false)
            
        }

    }
    
}
