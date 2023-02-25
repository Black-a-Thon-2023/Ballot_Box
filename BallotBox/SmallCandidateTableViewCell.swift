//
//  SmallCandidateTableViewCell.swift
//  BallotBox
//
//  Created by Sharonda Daniels on 2/25/23.
//

import UIKit

class SmallCandidateTableViewCell: UITableViewCell {
    @IBOutlet weak var candidateImage: UIImageView!
    
    @IBOutlet weak var candidateParty: UILabel!
    @IBOutlet weak var candidateName: UILabel!
    
    @IBOutlet weak var candidateXButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
