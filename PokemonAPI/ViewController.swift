//
//  ViewController.swift
//  PokemonAPI
//
//  Created by Stanley Ejechi on 4/16/19.
//  Copyright © 2019 MobileConsultingSolutions. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//    var pokemonBaseURL: String = "https://pokeapi.co/api/v2/pokemon/"
//    var pokemonStruct: [Pokemon]?
//    var tableArray: [Any]?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Call Get Request
//        getRequest()
        
//        getRequestWithURLRequest()
    }
//
//    // Get Request
//    func getRequest() {
//        //
//        guard let url = URL(string: pokemonBaseURL) else {return}
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//
//            print("This is the data:\(String(describing: data))\n This is the response:\(String(describing: response))\n  This is the error:\(String(describing: error))")
//            //Do parsing
//            let decoder = JSONDecoder()
//            do {
//                let poke = try? decoder.decode(Pokemon.self, from: data!)
//                self.tableArray?.append(poke!)
//
//            } catch {
//                print(error.localizedDescription)
//            }
//            }.resume()
//    }
//
//    // Get Request
//    func getRequestWithURLRequest() {
//        //
//        guard let url = URL(string: "") else {return}
//        var request = URLRequest(url: url)
//        request.httpMethod = "PATCH"
//        request.allHTTPHeaderFields = [:]
//        request.httpBody = Data()
//        request.cachePolicy = .returnCacheDataElseLoad
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//
//            //do network stuff
//            //parse JSON
//            //show error if there is an error
//
//            print("This is the data:\(String(describing: data))\n This is the response:\(String(describing: response))\n  This is the error:\(String(describing: error))")
//            }.resume()
//    }
//
//    // Get Request
//    func postRequestWithURLRequest() {
//        //
//        guard let url = URL(string: "https://www.google.com") else {return}
//        var request = URLRequest(url: url)
//        request.httpMethod = "PATCH"
//        request.allHTTPHeaderFields = [:]
//        var dictToPass = ["someKey":"someValue"]
//
//
//        //if you want to convert an objectModel to a data
//        /*
//         let pokemon = Pokemon()
//         try? JSONEncoder().encode(pokemon)
//         request.httpBody = try? JSONSerialization.data(withJSONObject: dictToPass, options: [])
//         */
//        request.httpBody = Data()
//        request.cachePolicy = .returnCacheDataElseLoad
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//
//            //do network stuff
//            //parse JSON
//            //show error if there is an error
//
//            print("This is the data:\(String(describing: data))\n This is the response:\(String(describing: response))\n  This is the error:\(String(describing: error))")
//            }.resume()
//    }


}

