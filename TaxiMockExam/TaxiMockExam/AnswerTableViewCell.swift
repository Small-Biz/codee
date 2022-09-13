//
//  AnswerTableViewCell.swift
//  TaxiMockExam
//
//  Created by Ray on 18/1/2020.
//  Copyright © 2020 HeeSolutionsLimited. All rights reserved.
//

import UIKit

class AnswerTableViewCell: UITableViewCell {

    @IBOutlet weak var answerLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
