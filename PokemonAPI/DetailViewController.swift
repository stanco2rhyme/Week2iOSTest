//
//  DetailViewController.swift
//  PokemonAPI
//
//  Created by Stanley Ejechi on 4/18/19.
//  Copyright © 2019 MobileConsultingSolutions. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var episodeTitle: String?
    var premierDate: String?
    var airtime: String?
    var season: String?
    var episodeNumber: String?
    var summary: String?

    @IBOutlet weak var episodeTitleLabel: UILabel!
    
    @IBOutlet weak var premierDatetLabel: UILabel!
    @IBOutlet weak var airtimeLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    
    @IBOutlet weak var episodeNumberLabel: UILabel!
    @IBOutlet weak var summaryTextview: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        episodeTitleLabel.text = episodeTitle
        premierDatetLabel.text = premierDate
        airtimeLabel.text = airtime
        seasonLabel.text = season
        episodeNumberLabel.text = episodeNumber
        summaryTextview.text = summary

        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
