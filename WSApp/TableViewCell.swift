//
//  TableViewCell.swift
//  WSApp
//
//  Created by Pelorca on 06/12/2017.
//  Copyright © 2017 Eduardo Pelorca. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var lblTitulo: UILabel!
 
    @IBOutlet weak var imgOval: UIImageView!
    @IBOutlet weak var lblHora: UILabel!
    @IBOutlet weak var lblDetails: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
