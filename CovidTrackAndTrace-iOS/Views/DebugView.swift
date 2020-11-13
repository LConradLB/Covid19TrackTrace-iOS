//
//  DebugView.swift
//  CovidTrackAndTrace-iOS
//
//  Created by Lewis Luther-Braun on 07/11/2020.
//

import SwiftUI

struct DebugView: View {
    @EnvironmentObject var state: AppStore
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8){
                
                PersonalTokens()
                CollectedProximityTokens()
                
                Button("Clear Known Infected Proximity Tokens") {
                    let defaults = UserDefaults.standard
                    defaults.set("", forKey: "InfectedTokens")
                }
                
                AddToState()
                ClearAllState()
                IsolationDebug()
                DebugViews()
                
                Spacer()
            }.padding()
        }.navigationTitle("Debug Menu")
    }
}

struct PersonalTokens: View {
    
    @EnvironmentObject var state: AppStore
    @State var showPersonalTokens: Bool = false
    
    var body: some View {
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
            if(showPersonalTokens && state.personalTokens.count > 0) {
                List(state.personalTokens, id: \.self) { string in
                    Text(string)
                }.frame(height: 300)
            }
        }
    }
}

struct CollectedProximityTokens: View {
    
    @EnvironmentObject var state: AppStore
    @State var showProximityTokens: Bool = false
    
    var body: some View {
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
            if(showProximityTokens && state.collectedProximityTokens.count > 0) {
                List(state.collectedProximityTokens, id: \.self) { string in
                    Text(string)
                }.frame(height: 300)
                
            }
        }
    }
}

struct AddToState: View {
    
    @EnvironmentObject var state: AppStore
    @State var textFieldText: String = ""
    @State private var addTokensToSegment = 0
    
    var body: some View {
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
            .padding()
            .background(Color.interactionColor)
            .cornerRadius(25)
            .accentColor(.white)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15)
                        .stroke())
    }
}

struct ClearAllState: View {
    
    @EnvironmentObject var state: AppStore
    @State var frictionfulTextField: String = ""
    var frictionfulNumber = Int.random(in: (101...123456))
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(frictionfulNumber)")
            TextField("To clear, enter in the number above", text: $frictionfulTextField)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.label, lineWidth: 1)
                        .foregroundColor(.white)
                        .foregroundColor(Color.white.opacity(0.3)))
            
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
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15)
                        .stroke())
        
    }
}

struct DebugViews: View {
    var body: some View {
        VStack {
            Text("Views").font(.title)
            NavigationLink(
                destination: InfectionView(isShowingView: .constant(true)),
                label: {
                    Text("Infection View")
                })
            
        }
    }
}

struct IsolationDebug: View {
    @EnvironmentObject var state: AppStore
    @State var date: Date = Date()
    var body: some View {
        VStack {
            Text("Set Up Isolation View")
            DatePicker("Completion Date", selection: $date)
                .datePickerStyle(CompactDatePickerStyle())
                .frame(height: 50)
            HStack {
                Group {
                    Button("Start Countdown") {
                        if date > Date() {
                            state.dateIsolatingUntil = date
                        }
                    }
                    
                    Button("Clear Time") {
                        state.dateIsolatingUntil = nil
                    }
                }
                .padding()
                .background(Color.interactionColor)
                .cornerRadius(25)
                .accentColor(.white)
                
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15)
                        .stroke())
        
    }
}

struct DebugView_Previews: PreviewProvider {
    static var previews: some View {
        DebugView()
    }
}
