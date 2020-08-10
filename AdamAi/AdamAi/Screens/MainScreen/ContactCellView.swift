//
//  ContactCellView.swift
//  AdamAi
//
//  Created by Amr Hesham on 8/9/20.
//  Copyright © 2020 Amr Hesham. All rights reserved.
//

import UIKit

class ContactCellView: UITableViewCell {

    @IBOutlet weak var contactNumberLabel: UILabel!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contactImageView.circleImage()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
