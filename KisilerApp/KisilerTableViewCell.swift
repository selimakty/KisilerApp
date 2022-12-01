//
//  KisilerTableViewCell.swift
//  KisilerApp
//
//  Created by Selim on 19.11.2022.
//

import UIKit

class KisilerTableViewCell: UITableViewCell {

    @IBOutlet weak var KisilerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
