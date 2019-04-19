//
//  DetailViewController.swift
//  PokemonAPI
//
//  Created by Stanley Ejechi on 4/18/19.
//  Copyright © 2019 MobileConsultingSolutions. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var pokeName: String?
    var pokeId: String?
    var pokeHeight: String?

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameLabel.text = pokeName
        idLabel.text = pokeId
        heightLabel.text = pokeHeight

        
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
