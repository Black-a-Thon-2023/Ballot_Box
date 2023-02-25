//
//  QuestionTableViewCell.swift
//  BallotBox
//
//  Created by Sharonda Daniels on 2/25/23.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {

    @IBOutlet weak var topicLabel: UILabel!
    
    @IBOutlet weak var topicSlider: UISlider!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
