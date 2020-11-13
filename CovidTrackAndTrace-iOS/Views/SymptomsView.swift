//
//  SymptomsView.swift
//  CovidTrackAndTrace-iOS
//
//  Created by Lewis Luther-Braun on 08/11/2020.
//

import SwiftUI

struct SymptomsView: View {
    
    var body: some View {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 16) {
                    SymptomCards(viewModel: SymptomViewModel(title: "Coughing Fits", subtitle: "A new, continuous cough – this means coughing a lot for more than an hour, or 3 or more coughing episodes in 24 hours (if you usually have a cough, it may be worse than usual).", icon: .cough))
                        .shadow(color: Color.shadowColor.opacity(0.4),
                                radius: 12)
                    
                    SymptomCards(viewModel: SymptomViewModel(title: "Fever", subtitle: "A high temperature – this means you feel hot to touch on your chest or back (you do not need to measure your temperature).", icon: .fever))
                        .shadow(color: Color.shadowColor.opacity(0.4),
                                radius: 12)
                    
                    SymptomCards(viewModel: SymptomViewModel(title: "Shortness Of Breath", subtitle: "Your chest may feel too tight to inhale or exhale fully. Each shallow breath takes greater effort and leaves you feeling winded. It can feel like you’re breathing through a straw. It may happen when you’re active or resting. It can come on gradually or suddenly.", icon: .shortnessOfBreath))
                        .shadow(color: Color.shadowColor.opacity(0.4),
                                radius: 12)
                    
                    SymptomCards(viewModel: SymptomViewModel(title: "Change to smell or taste", subtitle: "This means you've noticed you cannot smell or taste anything, or things smell or taste different to normal.", icon: .smellOrTaste))
                        .shadow(color: Color.shadowColor.opacity(0.4),
                                radius: 12)
                }
                .padding(.all)
                
            }
            .navigationTitle("Symptoms")
            .background(Color.appBackground.ignoresSafeArea())
    }
            
}

struct SymptomCards: View {
    let viewModel: SymptomViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                HStack {
                    Text(viewModel.title)
                        .font(.title2)
                        .bold()
                        .foregroundColor(.black)
                    Spacer()
                    VStack(alignment: .center){
                        Image(viewModel.icon.rawValue)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.blue)
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 30)
                    }
                }
                
                Spacer()
            }
            
            
            Text(viewModel.subtitle)
                .font(.caption2)
                .foregroundColor(.black)
                .padding(.vertical)
            
            
        }.padding()
        .frame(width: UIScreen.main.bounds.width * 0.9)
        .background(Color.white)
        .cornerRadius(24)
        
    }
}

struct SymptomsView_Previews: PreviewProvider {
    static var previews: some View {
        SymptomsView()
    }
}
