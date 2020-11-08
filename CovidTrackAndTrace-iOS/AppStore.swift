//
//  AppStore.swift
//  CovidTrackAndTrace-iOS
//
//  Created by Lewis Luther-Braun on 07/11/2020.
//

import Foundation
import Combine

class AppStore: ObservableObject, Codable {
    
    var collectedProximityTokens: [String] { didSet { saveState() } }
    var personalTokens: [String] { didSet { saveState() } }
    var isTrackingProximityEnabled: Bool { didSet { saveState() } }
    let storage: UserDefaults
    
    init(collectedProximityTokens: [String] = [],
         personalTokens: [String] = [],
         isTrackingProximityEnabled: Bool = true,
         storage: UserDefaults) {
        self.collectedProximityTokens = collectedProximityTokens
        self.personalTokens = personalTokens
        self.isTrackingProximityEnabled = isTrackingProximityEnabled
        self.storage = storage
        
        //If there is saved data, load it
        loadState()
    }
    
    
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        collectedProximityTokens = try values.decode([String].self, forKey: .collectedProximityTokens)
        personalTokens = try values.decode([String].self, forKey: .personalTokens)
        isTrackingProximityEnabled = try values.decode(Bool.self, forKey: .trackingProximityEnabled)
        storage = UserDefaults()
    }
}

extension AppStore {
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(collectedProximityTokens, forKey: .collectedProximityTokens)
        try container.encode(personalTokens, forKey: .personalTokens)
        try container.encode(isTrackingProximityEnabled, forKey: .trackingProximityEnabled)
    }
    
    enum CodingKeys: String, CodingKey {
        case collectedProximityTokens
        case personalTokens
        case trackingProximityEnabled
    }
    
    func saveState() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "AppState")
        }
    }
    
    func loadState() {
        //Load any saved data
        if let decodedData = storage.object(forKey: "AppState") as? Data {
        if let appState = try? JSONDecoder().decode(AppStore.self, from: decodedData) {
            self.collectedProximityTokens = appState.collectedProximityTokens
            self.personalTokens = appState.personalTokens
            self.isTrackingProximityEnabled = appState.isTrackingProximityEnabled
          }
        }
    }
}
