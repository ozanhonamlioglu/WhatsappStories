//
//  StatusTableViewCell.swift
//  WhatsappStories
//
//  Created by ozan honamlioglu on 23.09.2021.
//

import UIKit
import Kingfisher

class StatusTableViewCell: UITableViewCell {
    
    // MARK: - LAYOUTS
    @IBOutlet weak var profilePicture1: UIView!
    @IBOutlet weak var profilePicture2: UIView!
    @IBOutlet weak var profilePicture3: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    // MARK: - VARIABLES
    var data: BaseStatus? {
        didSet {
            let url = URL(string: data!.profilePic)
            profilePicture3.kf.setImage(with: url)
            
            nameLabel.text = data?.name
            timeLabel.text = data?.date
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupUI() {
        profilePicture1.layer.cornerRadius = 40
        profilePicture2.layer.cornerRadius = 39
        profilePicture3.layer.cornerRadius = 37
    }

}
