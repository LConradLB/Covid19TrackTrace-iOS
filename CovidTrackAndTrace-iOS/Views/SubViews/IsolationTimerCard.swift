//
//  IsolationTimerCard.swift
//  CovidTrackAndTrace-iOS
//
//  Created by Lewis Luther-Braun on 13/11/2020.
//

import SwiftUI


struct IsolationTimerCard: View {
    @State var dateIsolatingUntil: Date
    
    var body: some View {
        let progress = checkProgressPercentage()
        VStack(alignment: .leading) {
            Text("Containment Countdown")
                .bold()
            
            let daysComplete = (14 - calculateDaysLeft())
            if(daysComplete > 0) {
                Text(getCompleetedDaysText(daysComplete: daysComplete))
                    .font(.caption)
            }
            HorizontalProgressBar(progress: progress,
                                  overlay: AnyView(IsolationProgressOverlay(dateIsolatingUntil: $dateIsolatingUntil, progress: progress)))
                .frame(height: 80)
                .shadow(color: Color.shadowColor.opacity(0.4),
                        radius: 12)
            
            
        }
    }
    
    func getCompleetedDaysText(daysComplete: Int) -> String {
        let dayPlural = daysComplete > 1 ? "days" : "day"
        return "You have completed \(daysComplete) \(dayPlural) of isolation"
    }
    
    func checkProgressPercentage() -> Float {
        let dateNow = Date()
        let dateStarted = Calendar.current.date(byAdding: .day, value: -14, to: dateIsolatingUntil)!
        var progress = Float((dateStarted.timeIntervalSinceReferenceDate - dateNow.timeIntervalSinceReferenceDate)/(dateStarted.timeIntervalSinceReferenceDate - dateIsolatingUntil.timeIntervalSinceReferenceDate))
        return Float(floor(progress * 100)/100)
    }
    
    func calculateDaysLeft() -> Int {
        let diffs = Calendar.current.dateComponents([.day, .hour, .minute], from: Date(), to: dateIsolatingUntil)
        var daysLeft = (diffs.day ?? 0)
        
        
        if diffs.hour ?? 0 > 0 { daysLeft = daysLeft + 1 }
        
        if  diffs.day == 0,
            diffs.hour == 0,
            diffs.minute ?? 0 > 0 { daysLeft = daysLeft + 1 }
        return daysLeft
    }
}

struct IsolationProgressOverlay: View {
    @Binding var dateIsolatingUntil: Date
    var progress: Float
    var body: some View {
        HStack {
            if self.progress < 0.5 { Spacer() }
            
            VStack(alignment: self.progress < 0.5 ? .trailing : .leading,
                   spacing: 0) {
                Spacer()
                Text(String(format: "%.0f%%", min(self.progress, 1.0)*100.0))
                    .font(.title)
                    .foregroundColor(self.progress < 0.5 ? .label : .white)
                    .bold()
                Text(getCompletedDaysText(isolateUntil: dateIsolatingUntil))
                    .font(.callout)
                    .foregroundColor(self.progress < 0.5 ? .label : .white)
                    .bold()
            }
            if self.progress >= 0.5 { Spacer() }
            
        }.padding()
    }
    
    func getCompletedDaysText(isolateUntil: Date) -> String {
        let diffs = Calendar.current.dateComponents([.day, .hour, .minute], from: Date(), to: dateIsolatingUntil)
        
        if (diffs.day ?? 0) > 0 {
            let daysLeft = (diffs.day ?? 0) + (diffs.hour ?? 0 > 0 ? 1 : 0)
            return "\(daysLeft) \(daysLeft != 1 ? "Days" : "Day") Left"
        } else if (diffs.hour ?? 0) > 0 {
            let hoursLeft = diffs.hour ?? 0
            return "\(hoursLeft) \(hoursLeft != 1 ? "Hours" : "Hour") Left"
        } else if (diffs.minute ?? 0) > 0{
            let minutesLeft = diffs.minute ?? 0
            return "\(minutesLeft) \(minutesLeft != 1 ? "Minutes" : "Minute") Left"
        }
        
        return "Containment Compelete"
    }
}

struct HorizontalProgressBar: View {
    @Environment(\.colorScheme) var colorScheme
    var progress: Float
    let overlay: AnyView
    
    var body: some View {
        ZStack {
            GeometryReader { reader in
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(.secondaryAppBackground)
                
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(progress >= 1 ? .approvedColor : .interactionColor)
                    .frame(width: reader.size.width * CGFloat(min(self.progress, 1.0)))
                    .animation(.linear)
                
                overlay
                    .frame(height: reader.size.height)
                
            }
        }
    }
}

struct IsolationTimerCard_Previews: PreviewProvider {
    static var previews: some View {
        IsolationTimerCard(dateIsolatingUntil: Calendar.current.date(byAdding: .hour, value: 1, to: Date())!)
            .padding()
    }
}


extension Float {
    func round(to places: Int) -> Float {
        let divisor = pow(10.0, Double(places))
        return Float((Double(self) * divisor).rounded() / divisor)
    }
}
