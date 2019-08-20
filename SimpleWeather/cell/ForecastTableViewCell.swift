//
//  ForecastTableViewCell.swift
//  SimpleWeather
//
//  Created by dope on 20/08/2019.
//  Copyright © 2019 dope. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!

    @IBOutlet weak var timeLabel: UILabel!

    @IBOutlet weak var weatherImageView: UIImageView!

    @IBOutlet weak var statusLabel: UILabel!

    @IBOutlet weak var temperatureLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
