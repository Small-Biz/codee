//
//  GameResultView.swift
//  Codee
//
//  Created by Ray Cheng on 10/9/2022.
//

import UIKit

class GameResultView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var badgeImageView: UIImageView!
        
    override init(frame: CGRect){
        super.init(frame: frame)
        commonInit()
        updateUI()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        commonInit()
        updateUI()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("GameResultView", owner: self, options: nil)
        addSubview(contentView)
        contentView.autoresizingMask=[.flexibleHeight, .flexibleWidth]
    }
    
    private func updateUI(){
//        resultLabel.text =  "/"
        self.badgeImageView.isHidden=true
    }
    
    public func updateData(correctQuestion:Int, totalQuestion:Int){
        resultLabel.text = String(format: "%d/%d", correctQuestion, totalQuestion)
    }
}
