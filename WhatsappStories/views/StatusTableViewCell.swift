//
//  StatusTableViewCell.swift
//  WhatsappStories
//
//  Created by ozan honamlioglu on 23.09.2021.
//

import UIKit

class StatusTableViewCell: UITableViewCell {
    
    // MARK: - LAYOUTS
    @IBOutlet weak var profilePicture1: UIView!
    @IBOutlet weak var profilePicture2: UIView!
    
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
    }

    
}
