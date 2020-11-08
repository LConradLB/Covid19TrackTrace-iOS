//
//  Color+AssetColors.swift
//  CovidTrackAndTrace-iOS
//
//  Created by Lewis Luther-Braun on 07/11/2020.
//

import Foundation
import SwiftUI

extension Color {
    
    
    static var label = Color(UIColor.label)
    static var secondarySystemGroupedBackground = Color(UIColor.secondarySystemGroupedBackground)
    static var secondaryLabel = Color(UIColor.secondaryLabel)
    
    static var appBackground = Color(UIColor(named: "AppBackground") ?? .systemBackground)
    static var approvedColor = Color(UIColor(named: "ApprovedColor") ?? .systemGreen)
    static var rejectedColor = Color(UIColor(named: "RejectedColor") ?? .systemRed)
    static var interactionColor =  Color(UIColor(named: "InteractionColor") ?? .cyan)
    static var infectionBackground =  Color(UIColor(named: "InfectionBackground") ?? .cyan)
    static var shadowColor = Color(UIColor(named: "ShadowColor") ?? .black)
    
    
}
