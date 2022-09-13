//
//  ResultTableViewCell.swift
//  TaxiMockExam
//
//  Created by Ray on 15/1/2020.
//  Copyright © 2020 HeeSolutionsLimited. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    var question = ""
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var askLabel: UILabel!
    @IBOutlet weak var passLabel: UILabel!
    @IBOutlet weak var failLabel: UILabel!
    
    
    override func prepareForReuse() {
      super.prepareForReuse()
    }
    
    func setName(question: String) {
        if !self.question.elementsEqual(question) {
            self.question = question
            self.questionLabel.text = self.question
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
