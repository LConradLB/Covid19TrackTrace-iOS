//
//  ContentView.swift
//  CovidTrackAndTrace-iOS
//
//  Created by Lewis Luther-Braun on 06/11/2020.
//

import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject var appState: AppStore
    @State var showResultView: Bool = false
    @State var showDebugView: Bool = false
    @State var showPrivacyView: Bool = false
    @State var showSymptomsView: Bool = false
    
    var body: some View {
        ZStack{
            
            NavigationLink(
                destination: SymptomsView(),
                isActive: $showSymptomsView,
                label: {
                    EmptyView()
                }).hidden()
            
            Color.appBackground
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                
                VStack(alignment: .leading) {
                    
                    Text("Track & Trace")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    VStack(spacing: 16) {
                        
                        if let isolationDate = appState.dateIsolatingUntil {
                            IsolationTimerCard(dateIsolatingUntil: isolationDate)
                                .padding(.horizontal)
                        }
                        
                        NavigationLink(
                            destination: SubmitResultView(),
                            isActive: $showResultView) {
                            UploadResultCard()
                                .shadow(color: Color.shadowColor.opacity(0.4),
                                        radius: 12)
                        }.padding(.horizontal)
                        
                        SymptomsScrollsView(showSymptomsView: $showSymptomsView)
                        
                        NavigationLink(
                            destination: PrivacyView(),
                            isActive: $showPrivacyView,
                            label: {
                                LabelButton(label: "Privacy", icon: .privacy, onTap: { showPrivacyView.toggle()})
                            })
                            .padding(.horizontal)
                            .buttonStyle(PlainButtonStyle())
                            .shadow(color: Color.shadowColor.opacity(0.4),
                                    radius: 12)
                        
                        NavigationLink(
                            destination: DebugView(),
                            isActive: $showDebugView,
                            label: {
                                LabelButton(label: "Debug Menu", icon: .debug, onTap: { showDebugView.toggle()})
                            })
                            .padding(.horizontal)
                            .buttonStyle(PlainButtonStyle())
                            .shadow(color: Color.shadowColor.opacity(0.4),
                                    radius: 12)
                    }
                    
                    
                }
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
