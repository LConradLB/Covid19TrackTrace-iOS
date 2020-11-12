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
            
            ScrollView {
                
                VStack(alignment: .leading) {
                    
                    Text("Track & Trace")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    VStack(spacing: 16) {
                        
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



struct LabelButton: View {
    let label: String
    let icon: LabelButtonIcon
    let onTap: (()->())?
    let height: CGFloat = 60
    var body: some View {
        HStack(spacing:16) {
            Image(systemName: icon.rawValue)
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: height, height: height)
                .scaleEffect(0.5)
                .background(Color.interactionColor)
                .foregroundColor(.white)
            
            Text(label)
                .font(.title3)
            
            Spacer()
        }
        .frame(height: height)
        .background(Color.white)
        .cornerRadius(15)
        .onTapGesture {
            if let tap = onTap {
                tap()
            }
        }
    }
    
    public enum LabelButtonIcon: String {
        case debug = "ant.circle.fill"
        case privacy = "lock.rectangle.fill"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
