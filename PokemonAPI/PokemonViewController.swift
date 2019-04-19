//
//  PokemonViewController.swift
//  PokemonAPI
//
//  Created by Stanley Ejechi on 4/18/19.
//  Copyright © 2019 MobileConsultingSolutions. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    
    var pokemonBaseURLSpecific: String = "https://api.tvmaze.com/shows/82?embed=seasons&embed=episodes"
    var episodesArray: [episodes] = [episodes]()
    
    @IBOutlet weak var myTableview: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        // set the table delegate and datasource
        myTableview.dataSource = (self as UITableViewDataSource)
        myTableview.delegate = (self as UITableViewDelegate)
        
        //Set the tableview row height
        myTableview.rowHeight = 200
        
        // call the Pokemon api
        getRequest()
    }
    
    
    func getRequest() {
        
        guard let url = URL(string: self.pokemonBaseURLSpecific) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            //Do parsing
            DispatchQueue.global().sync {
                do {
                    guard let myData = data else {return}
                    let poke = try JSONDecoder().decode(Pokemon.self, from: myData)
                    self.episodesArray = poke.embedded.episodes
                } catch {
                    print(error.localizedDescription)
                }
            }
            DispatchQueue.main.async {
                self.myTableview.reloadData()
            }
            }.resume()
    }
}

extension PokemonViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "CustomCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PokemonTableViewCell  else {
            fatalError("The dequeued cell is not an instance of PokemonTableViewCell.")
        }
        cell.episodeTitle.text = episodesArray[indexPath.row].episodeTitle
        cell.episodeNumber.text = String(episodesArray[indexPath.row].episodeNumber)
        cell.season.text = String(episodesArray[indexPath.row].season)
        
        return cell
    }
}

extension PokemonViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailViewController.episodeTitle = self.episodesArray[indexPath.row].episodeTitle
        detailViewController.premierDate = self.episodesArray[indexPath.row].premierDate
        detailViewController.airtime = self.episodesArray[indexPath.row].airtime
        detailViewController.season = String(self.episodesArray[indexPath.row].season)
        detailViewController.episodeNumber = String(self.episodesArray[indexPath.row].episodeNumber)
        detailViewController.summary = self.episodesArray[indexPath.row].summary
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
