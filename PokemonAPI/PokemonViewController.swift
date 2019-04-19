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
    
    var pokemonArray: [Pokemon] = [Pokemon]()
    //    var pokemonBaseURLComplete: String?
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
                    self.pokemonArray.append(poke)
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
        return pokemonArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        
        let cellIdentifier = "CustomCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PokemonTableViewCell  else {
            fatalError("The dequeued cell is not an instance of PokemonTableViewCell.")
        }
        
        
        cell.episodeTitle.text = pokemonArray[indexPath.row].embedded.episodes[0].episodeTitle
        cell.episodeNumber.text = String(pokemonArray[indexPath.row].embedded.episodes[0].episodeNumber)
        cell.season.text = String(pokemonArray[indexPath.row].embedded.episodes[0].season)
        
        return cell
    }
}

extension PokemonViewController: UITableViewDelegate {
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailViewController.episodeTitle = pokemonArray[indexPath.row].embedded.episodes[0].episodeTitle
        detailViewController.premierDate = pokemonArray[indexPath.row].embedded.episodes[0].premierDate
        detailViewController.airtime = pokemonArray[indexPath.row].embedded.episodes[0].airtime
        detailViewController.season = String(pokemonArray[indexPath.row].embedded.episodes[0].season)
        detailViewController.episodeNumber = String(pokemonArray[indexPath.row].embedded.episodes[0].episodeNumber)
        detailViewController.summary = pokemonArray[indexPath.row].embedded.episodes[0].summary
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
