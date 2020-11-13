//
//  UploadResultView.swift
//  CovidTrackAndTrace-iOS
//
//  Created by Lewis Luther-Braun on 08/11/2020.
//

import SwiftUI

struct UploadResultCard: View {
    
    var body: some View {
            HStack{
                Spacer()
                HStack {
                    VStack(alignment: .leading) {
                        Group {
                            Text("Upload Your Test Code")
                                .font(.title2)
                                .bold()
                                .fixedSize(horizontal: false, vertical: true)
                            Text("Been for a test? Upload your code to get your results")
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .foregroundColor(.white)
                        .font(.subheadline)
                        Spacer()
                        
                        HStack {
                            Spacer()
                            Text("Upload Code")
                                .bold()
                            Spacer()
                        }
                        .padding(.vertical)
                        .background(Color.white)
                        .cornerRadius(30)
                        .foregroundColor(.black)
                    }
                    
                    Image("vials")
                        .resizable()
                        .foregroundColor(.white)
                        .scaleEffect(0.5)
                        .aspectRatio(contentMode: .fit)
                }.padding()
                Spacer()
            }
            .frame(height: UIScreen.main.bounds.height/4)
            .background(Color.interactionColor)
            .cornerRadius(24)
        }
        
}

struct UploadResultView_Previews: PreviewProvider {
    static var previews: some View {
        UploadResultCard()
            .padding()
    }
}
