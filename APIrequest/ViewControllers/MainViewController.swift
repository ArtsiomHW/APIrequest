//
//  ViewController.swift
//  APIrequest
//
//  Created by Artem H on 11/21/24.
//

import UIKit

enum Link {
    case playerLink
    case clubLink
    
    var url: URL {
        switch self {
        case .playerLink:
            URL(string: "https://premier-league18.p.rapidapi.com/players")!
        case .clubLink:
            URL(string: "https://premier-league18.p.rapidapi.com/teams")!
        }
    }
}

enum RequestType: CaseIterable {
    case fetchPlayers
    case fetchClubs
    
    var title: String {
        switch self {
        case .fetchPlayers:
            return "Fetch current players"
        case .fetchClubs:
            return "Fetch clubs"
        }
    }
}

final class MainViewController: UICollectionViewController {
    private let requestType = RequestType.allCases

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        requestType.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fetchType", for: indexPath)
        guard let cell = cell as? FetchAPIDataCell else { return UICollectionViewCell() }
        cell.fetchActionLabel.text = requestType[indexPath.item].title
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let fetchType = requestType[indexPath.item]
        
        switch fetchType {
        case .fetchPlayers: fetchPlayers()
        case .fetchClubs: fetchClubs()
        }
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
    }
    
}

// MARK: - Networking
extension MainViewController {
    
    private func fetchPlayers() {
        var request = URLRequest(url: Link.playerLink.url)
        
        let header = [
            "x-rapidapi-key": "987cc2cee7msh443366dc8c467bbp1d18a0jsn9a28fc1723ec",
            "x-rapidapi-host": "premier-league18.p.rapidapi.com"
        ]
        
        request.allHTTPHeaderFields = header
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let players = try JSONDecoder().decode([Player].self, from: data)
                print(players)
                
            } catch {
                print(error)
                
            }
        }.resume()
    }
    
    
    private func fetchClubs() {
        var request = URLRequest(url: Link.clubLink.url)
        
        let header = [
            "x-rapidapi-key": "987cc2cee7msh443366dc8c467bbp1d18a0jsn9a28fc1723ec",
            "x-rapidapi-host": "premier-league18.p.rapidapi.com"
        ]
        
        request.allHTTPHeaderFields = header
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let clubs = try JSONDecoder().decode([Club].self, from: data)
                print(clubs)
                
            } catch {
                print(error)
                
            }
        }.resume()
    }
    
}
