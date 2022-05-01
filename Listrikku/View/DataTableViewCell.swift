//
//  DataTableViewCell.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 30/04/22.
//

import UIKit

class DataTableViewCell: UITableViewCell {
    
    @IBOutlet weak var powerLabel: UILabel!
    @IBOutlet weak var objectLabel: UILabel!
    @IBOutlet weak var cellBackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}