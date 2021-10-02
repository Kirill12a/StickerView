//
//  ViewCell.swift
//  StickerView
//
//  Created by Kirill Drozdov on 24.09.2021.
//

import UIKit

class ViewCell: UITableViewCell {

    @IBOutlet weak var numberTasks: UILabel!
    @IBOutlet weak var task: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
