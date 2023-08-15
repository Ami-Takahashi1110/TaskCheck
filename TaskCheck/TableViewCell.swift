//
//  TableViewCell.swift
//  TaskCheck
//
//  Created by USER on 2023/06/11.
//

import UIKit

class TableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var taskName: UILabel!
    
    @IBOutlet weak var contents: UILabel!
    
    @IBOutlet weak var progress: UIProgressView!
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
