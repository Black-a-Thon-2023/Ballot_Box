//
//  LargeCandidateTableViewCell.swift
//  BallotBox
//
//  Created by Sharonda Daniels on 2/25/23.
//

import UIKit

class LargeCandidateTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var party: UILabel!
    @IBOutlet weak var candidateImage: UIImageView!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var deleteBTN: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
