//
//  FlightTableCell.swift
//  TechmasterFinal
//
//  Created by Toàn Nguyễn on 12/5/18.
//  Copyright © 2018 mobile. All rights reserved.
//

import UIKit

class FlightTableCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblFlight: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
