//
//  LabelButton.swift
//  CovidTrackAndTrace-iOS
//
//  Created by Lewis Luther-Braun on 13/11/2020.
//

import SwiftUI

struct LabelButton: View {
    @Environment(\.colorScheme) var colorScheme
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
                .foregroundColor(.label)
            
            Spacer()
        }
        .frame(height: height)
        .background(Color.secondaryAppBackground)
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

struct LabelButton_Previews: PreviewProvider {
    static var previews: some View {
        LabelButton(label: "Debug", icon: .debug, onTap: nil)
    }
}
