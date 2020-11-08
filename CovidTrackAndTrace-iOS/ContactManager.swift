//
//  ContactManager.swift
//  CovidTrackAndTrace-iOS
//
//  Created by Lewis Luther-Braun on 07/11/2020.
//

import Foundation

class ContactManager {
    
    let networkManager = NetworkManager.shared
    let storage = UserDefaults()
    
    func checkForPossibleExposure(proximityTokens: [String], isProximityTrackingEnabled: Bool, completion: @escaping (Bool) -> ()){
        
        guard isProximityTrackingEnabled else { return }
        networkManager.getListOfInfectedTokens(completion: { serverTokens in
            var knownInfectedTokens: [String] = self.loadKnownInfectedTokens()
            var newTokens: [String] = []
            
            for token in proximityTokens {
                if(knownInfectedTokens.contains(token)) {
                    break
                }
                
                if(serverTokens.contains(token)) {
                    newTokens.append(token)
                    break
                }
            }
            
            if !newTokens.isEmpty {
                knownInfectedTokens.append(contentsOf: newTokens)
                self.saveKnownInfectedTokens(tokens: knownInfectedTokens)
            }
            
            completion(!newTokens.isEmpty)
        })
    }
    
    func saveKnownInfectedTokens(tokens: [String]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(tokens) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "InfectedTokens")
        }
    }
    
    func loadKnownInfectedTokens() -> [String] {
        //Load any saved data
        if let decodedData = storage.object(forKey: "InfectedTokens") as? Data {
        if let infectedTokens = try? JSONDecoder().decode([String].self, from: decodedData) {
            return infectedTokens
          }
        }
        
        return []
    }
}
