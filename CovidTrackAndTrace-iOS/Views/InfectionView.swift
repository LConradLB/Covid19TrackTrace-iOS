//
//  InfectionView.swift
//  CovidTrackAndTrace-iOS
//
//  Created by Lewis Luther-Braun on 07/11/2020.
//

import SwiftUI

struct InfectionView: View {
    @Binding var isShowingView: Bool
    
    var body: some View {
        ZStack {
            Color.interactionColor
            
            VStack(spacing: 32) {
                
                Image(systemName: "exclamationmark.triangle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width/3)
                
                VStack {
                Text("Exposure Warning")
                    .font(.largeTitle)
                    .bold()
                    
                Text("You have been exposed to a confirmed case of COVID-19.")
                    .font(.subheadline)
                    .fixedSize(horizontal: false, vertical: true)
                    
                }.foregroundColor(.white)
                .multilineTextAlignment(.center)
                
                
                Text("In order to fight against this infection, you are required to self-isolate for 14 days, in line with the UK government guidelines")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                
                HStack {
                    Spacer()
                    Text("I Understand")
                        .foregroundColor(.black)
                    Spacer()
                }
                .padding(.vertical)
                .background(Color.white)
                .cornerRadius(30)
                .foregroundColor(.label)
                .onTapGesture {
                    isShowingView = false
                }
                    
                
            }.padding()
        }.ignoresSafeArea()
    }
}

struct InfectionView_Previews: PreviewProvider {
    static var previews: some View {
        InfectionView(isShowingView: .constant(true))
    }
}
