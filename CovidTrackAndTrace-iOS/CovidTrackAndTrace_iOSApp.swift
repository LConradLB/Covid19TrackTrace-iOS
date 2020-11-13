//
//  CovidTrackAndTrace_iOSApp.swift
//  CovidTrackAndTrace-iOS
//
//  Created by Lewis Luther-Braun on 06/11/2020.
//

import SwiftUI
import Foundation

@main
struct CovidTrackAndTrace_iOSApp: App {
    let state = AppStore(storage: UserDefaults())
    let contactManager = ContactManager()
    @State var shouldShowProximityInfectionView: Bool = false
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeScreen()
            }.onAppear {
                setUpTimer()
            }
            .environmentObject(state)
            .sheet(isPresented: $shouldShowProximityInfectionView, content: {
                InfectionView(isShowingView: $shouldShowProximityInfectionView)
                    .onDisappear {
                        shouldShowProximityInfectionView = false
                    }
            })
        }
    }
    
    func setUpTimer() {
        _ = Timer.scheduledTimer(withTimeInterval: 600, repeats: true) { _ in checkProximityInfection() }
    }
    
    func checkProximityInfection() {
        contactManager.checkForPossibleExposure(proximityTokens: state.collectedProximityTokens,
                                                isProximityTrackingEnabled: state.isTrackingProximityEnabled) { isNewInfectedToken in
            if isNewInfectedToken {
                shouldShowProximityInfectionView = true
                state.dateIsolatingUntil = Calendar.current.date(byAdding: .day, value: 14, to: Date())!
            }
        }
    }
    
}
