//
//  SymptomView.swift
//  CovidTrackAndTrace-iOS
//
//  Created by Lewis Luther-Braun on 08/11/2020.
//

import SwiftUI


struct SymptomsScrollsView: View {
    @Binding var showSymptomsView: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Symptoms")
                    .bold()
                Spacer()
                Text("View All")
                    .foregroundColor(.secondaryLabel)
                    .font(.caption)
                    .onTapGesture { showSymptomsView.toggle() }
                
            }
            .offset(y: 20)
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    Spacer().frame(width:8)
                    
                    SymptomView(viewModel: SymptomViewModel(title: "Coughing Fits", subtitle: "Increased prolonged coughing ", icon: .cough))
                        .shadow(color: Color.shadowColor.opacity(0.4),
                                radius: 12)
                    
                    SymptomView(viewModel: SymptomViewModel(title: "Fever", subtitle: "High temperature that spans several days", icon: .fever))
                        .shadow(color: Color.shadowColor.opacity(0.4),
                                radius: 12)
                    
                    SymptomView(viewModel: SymptomViewModel(title: "Shortness Of Breath", subtitle: "Trouble breathing", icon: .shortnessOfBreath))
                        .shadow(color: Color.shadowColor.opacity(0.4),
                                radius: 12)
                    
                    Spacer().frame(width:8)
                }.frame(height:135)
            }
        }
    }
}

struct SymptomView: View {
    
    @Environment(\.colorScheme) var colorScheme
    let viewModel: SymptomViewModel
    
    var body: some View {
        HStack{
            Spacer()
            HStack {
                VStack(alignment: .leading) {
                    
                    Text(viewModel.title)
                        .font(.title2)
                        .bold()
                        .foregroundColor(.label)
                    
                    Text(viewModel.subtitle)
                        .font(.caption2)
                        .foregroundColor(.label)
                    
                    
                }
                Spacer()
                Image(viewModel.icon.rawValue)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(colorScheme == .dark ? .blue : .interactionColor)
                    .scaleEffect(0.5)
                    .aspectRatio(contentMode: .fit)
            }.padding()
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width * 0.9, height: 90)
        .background(Color.secondaryAppBackground)
        .cornerRadius(24)
    }
}

struct SymptomViewModel {
    let title: String
    let subtitle: String
    let icon: SymptomIcons
    
    public enum SymptomIcons: String {
        case fever
        case cough
        case shortnessOfBreath = "breath"
        case smellOrTaste = "tissues"
    }
}

struct SymptomView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            GeometryReader { reader in
                Color.appBackground
                SymptomView(viewModel: SymptomViewModel(title: "Shortness Of Breath",
                                                        subtitle: "Increased or prolonged coughing fit",
                                                        icon: .cough))
                    .padding(.horizontal)
            }
        }
    }
}
