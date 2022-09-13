//
//  ViewController.swift
//  TaxiMockExam
//
//  Created by Ray on 12/1/2020.
//  Copyright © 2020 HeeSolutionsLimited. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var menuView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initUI()
    }
    
    func initUI(){
        
        self.menuView.backgroundColor = UIColor.clear;
        
    };


}

