//
//  PokemonViewController.swift
//  PokemonAPI
//
//  Created by Stanley Ejechi on 4/18/19.
//  Copyright © 2019 MobileConsultingSolutions. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    
    var pokemonBaseURL: String = "https://pokeapi.co/api/v2/pokemon/"
    var pokemonBaseURLSpecific: String = "https://pokeapi.co/api/v2/pokemon/34/"
    var pokemonBaseURLComplete: String = ""


    let randomInt = Int.random(in: 1..<960)
    var pokemonArray: [Pokemon] = [Pokemon]()
//    var pokemonBaseURLComplete: String?
    @IBOutlet weak var myTableview: UITableView!
    
    // Keychain Configuration
    struct KeychainConfiguration {
        static let serviceName = "PokemonAPI"
        static let accessGroup: String? = nil
        static let account: String? = nil
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //Generate random number
      self.pokemonBaseURLComplete = pokemonBaseURL + String(randomInt) + "/"

        self.navigationItem.setHidesBackButton(true, animated:true)
        
        myTableview.dataSource = (self as UITableViewDataSource)
        myTableview.delegate = (self as UITableViewDelegate)
        myTableview.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        // call the Pokemon api
        getRequest()
    }
    
    
    @IBAction func logoutPressed(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "hasLoginKey")
        guard let storedUsername = UserDefaults.standard.value(forKey: "username") as? String else {
            return
        }
        // 2
        let useD = UserDefaults.standard
        useD.removeObject(forKey: "username")
        useD.removeObject(forKey: "hasLoginKey")
        useD.synchronize()
        
        try? KeychainPasswordItem(service: KeychainConfiguration.serviceName, account:storedUsername).deleteItem()
        self.navigationController?.popViewController(animated: true)
    }
    
    func getRequest() {
        
        guard let url = URL(string: self.pokemonBaseURLComplete) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            print(try? JSONSerialization.jsonObject(with: data!, options: []))
            //Do parsing
            DispatchQueue.global().sync {
                do {
                    guard let myData = data else {return}
                    let poke = try JSONDecoder().decode(Pokemon.self, from: myData)
                    self.pokemonArray.append(poke)
//                    print(self.pokemonArray)
                    print(self.pokemonArray[0].abilities[0].ability.name)
                    print(self.pokemonArray[0].abilities[0].ability.url)


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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = pokemonArray[indexPath.row].name
        return cell
    }
}

extension PokemonViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
//                detailViewController.myna = myTableArray[indexPath.row]
        detailViewController.pokeName = pokemonArray[indexPath.row].name
        detailViewController.pokeId = String(pokemonArray[indexPath.row].id)
        detailViewController.pokeHeight = String(pokemonArray[indexPath.row].height)

//                detailViewController.delegate = self
                navigationController?.pushViewController(detailViewController, animated: true)
        //        present(secondViewController, animated: true, completion: nil)
        
    }
}
