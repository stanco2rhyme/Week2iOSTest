//
//  PokemonTableViewCell.swift
//  PokemonAPI
//
//  Created by Stanley Ejechi on 4/19/19.
//  Copyright © 2019 MobileConsultingSolutions. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var episodeTitle: UILabel!
    @IBOutlet weak var episodeNumber: UILabel!
    @IBOutlet weak var season: UILabel!
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }


}
