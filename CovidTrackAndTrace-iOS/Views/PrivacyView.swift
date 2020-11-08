//
//  PrivacyView.swift
//  CovidTrackAndTrace-iOS
//
//  Created by Lewis Luther-Braun on 08/11/2020.
//

import SwiftUI

struct PrivacyView: View {
    @EnvironmentObject var appState: AppStore
    
    var body: some View {
        ZStack {
            Color.appBackground
                .ignoresSafeArea()
            VStack {
                ToggleCard(label: "Toggle Proximity Tracking", isOn: .init(get: { return appState.isTrackingProximityEnabled}, set: { bool in appState.isTrackingProximityEnabled = bool}))
                Spacer()
            }.padding()
        }
        .navigationTitle("Privacy")
    }
    
}

struct ToggleCard: View {
    let label: String
    @Binding var isOn: Bool
    var body: some View {
        HStack {
            Toggle(label, isOn: $isOn)
                .padding()
                .foregroundColor(.black)
        }
        .background(Color.white)
        .cornerRadius(25)
        .shadow(color: Color.shadowColor.opacity(0.4),
                radius: 12)
    }
}

//struct PrivacyView_Previews: PreviewProvider {
//    static var previews: some View {
////        PrivacyView(isProximityTrackingEnabled: true)
//    }
//}
