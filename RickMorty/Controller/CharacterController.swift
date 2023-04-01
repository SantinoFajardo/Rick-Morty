//
//  CharacterController.swift
//  RickMorty
//
//  Created by Santino Fajardo on 28/03/2023.
//

import Foundation

// The controller is in charge of manage the data that show in the screens and make the request to the API

class CharacterController: ObservableObject {
    @Published var characters = [Character]()
    @Published var character: CharacterDetail?
    
    init() {
        self.character = CharacterDetail(id: 0, name: "", status: "", species: "", type: "", gender: "", origin: Origin(name: ""), location: Location(name: ""), image: "", episode: [Episodes]())
    }
    
    func getCharacters() {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(Result.self, from: data)
                DispatchQueue.main.async {
                    self.characters = result.results
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func getCharacterDetail (id: Int) {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/\(id)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            
            do {
                let result = try JSONDecoder().decode(CharacterDetail.self, from: data)
                DispatchQueue.main.async {
                    self.character = result
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func getEpisodes(for episodes: [String])   {
        print("La funcion")
        let episodeURLs = episodes
        
        var episodes: [Episodes] = []
        let dispatchGroup = DispatchGroup()
        
        for episodeURL in episodeURLs {
            dispatchGroup.enter()
            guard let url = URL(string: episodeURL) else {
                dispatchGroup.leave()
                continue
            }
            URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data else {
                    dispatchGroup.leave()
                    return
                }
                do {
                    let episode = try JSONDecoder().decode(Episodes.self, from: data)
                    episodes.append(episode)
                    dispatchGroup.leave()
                } catch {
                    print("Hubo un error")
                    print(error.localizedDescription)
                    dispatchGroup.leave()
                }
            }.resume()
        }
        dispatchGroup.notify(queue: .main) {
            print(episodes)
            self.character?.episode = episodes
        }
    }

}

struct Result: Codable {
    let info: Info
    let results: [Character]
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}



