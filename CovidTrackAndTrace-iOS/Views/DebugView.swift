//
//  DebugView.swift
//  CovidTrackAndTrace-iOS
//
//  Created by Lewis Luther-Braun on 07/11/2020.
//

import SwiftUI

struct DebugView: View {
    @EnvironmentObject var state: AppStore
    
    @State var showPersonalTokens: Bool = false
    @State var showProximityTokens: Bool = false
    @State var textFieldText: String = ""
    @State private var addTokensToSegment = 0
    @State var frictionfulTextField: String = ""
    var frictionfulNumber = Int.random(in: (101...123456))
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8){
                
                //Personal Tokens
                VStack {
                    HStack {
                        Image(systemName: "chevron.right")
                            .rotationEffect(showPersonalTokens ? .degrees(90) : .zero)
                        Text("Personal Tokens")
                        Spacer()
                    }.onTapGesture {
                        withAnimation {
                            showPersonalTokens.toggle()
                        }
                    }
                    if(showPersonalTokens) {
                        List(state.personalTokens, id: \.self) { string in
                            Text(string)
                        }.frame(height: 300)
                    }
                }
                
                //Proximity Tokens
                VStack {
                    HStack {
                        Image(systemName: "chevron.right")
                            .rotationEffect(showProximityTokens ? .degrees(90) : .zero)
                        Text("Proximity Tokens")
                        Spacer()
                    }.onTapGesture {
                        withAnimation {
                            showProximityTokens.toggle()
                        }
                    }
                    if(showProximityTokens) {
                        List(state.collectedProximityTokens, id: \.self) { string in
                            Text(string)
                        }.frame(height: 300)
                        
                    }
                }
                
                Button("Clear Infected Proximity Tokens") {
                    let defaults = UserDefaults.standard
                    defaults.set("", forKey: "InfectedTokens")
                }
                
                VStack {
                    TextField("Add to app state", text: $textFieldText)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.label, lineWidth: 1)
                                .foregroundColor(.white))
                    
                    Picker(selection: $addTokensToSegment, label: Text("Add To:")) {
                        Text("Personal Tokens").tag(0)
                        Text("Proximity Tokens").tag(1)
                    }.pickerStyle(SegmentedPickerStyle())
                    Button("Add Token") {
                        if addTokensToSegment == 0 {
                            state.personalTokens.append(textFieldText)
                        } else {
                            state.collectedProximityTokens.append(textFieldText)
                        }
                    }
                    .accentColor(.white)
                }
                .padding()
                .background(Color.interactionColor)
                .cornerRadius(15)
                
                VStack(alignment: .leading) {
                    Text("\(frictionfulNumber)")
                    TextField("To clear, enter in the number above", text: $frictionfulTextField)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.label, lineWidth: 1)
                                .foregroundColor(.white))
                    
                    Button("Clear All Token") {
                        if(frictionfulTextField == frictionfulNumber.description) {
                            state.personalTokens = []
                            state.collectedProximityTokens = []
                        }
                    }
                    .padding()
                    .background(Color.rejectedColor)
                    .cornerRadius(25)
                    .accentColor(.white)
                }.padding()
                .background(Color.interactionColor)
                .cornerRadius(15)
                
                VStack {
                    Text("Views").font(.title)
                    NavigationLink(
                        destination: InfectionView(isShowingView: .constant(true)),
                        label: {
                            Text("Infection View")
                        })
                    
                }
                
                Spacer()
            }.padding()
        }.navigationTitle("Debug Menu")
    }
}

struct DebugView_Previews: PreviewProvider {
    static var previews: some View {
        DebugView()
    }
}
