//
//  SubmitResultView.swift
//  CovidTrackAndTrace-iOS
//
//  Created by Lewis Luther-Braun on 06/11/2020.
//

import SwiftUI

struct SubmitResultView: View {
    let networkingManager = NetworkManager.shared
    @EnvironmentObject var state: AppStore
    
    @State var textFieldContent: String = ""
    @State var networkRequestInProgress: Bool = false
    @State var showCard: Bool = false
    @State var isPositiveResult: Bool = false
    @State var showErrorMessage: Bool = false
    
    var body: some View {
        
        ZStack {
            Color.appBackground
                .ignoresSafeArea()
            
            VStack {
                let viewModel = self.viewModel()
                if(showCard) {
                    ResultCard(isPositiveResult: isPositiveResult)
                }
                
                VStack(alignment: .leading) {
                    Text(viewModel.calloutTitle)
                        .bold()
                        .foregroundColor(viewModel.calloutTitleColor)
                    
                    TextField("Result Code", text: $textFieldContent)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.label, lineWidth: 1)
                                .foregroundColor(.clear))
                }.padding()
                
                HStack {
                    if networkRequestInProgress { EmptyView() } else { Spacer() }
                    if networkRequestInProgress {
                        ProgressView()
                            .accentColor(.white)
                            .foregroundColor(.white)
                    }
                    else {
                        Text(viewModel.submitButtonTitle)
                    }
                    if networkRequestInProgress { EmptyView() } else { Spacer() }
                }.onTapGesture {
                    getResponseForTestCode()
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.interactionColor)
                .cornerRadius(25)
                .padding()
                
                Spacer()
            }
        }
        .navigationTitle("Submit Result Code")
        
        
    }
    
    func viewModel() -> SubmitResultViewModel {
        return showErrorMessage
            ? SubmitResultViewModel(calloutTitle: "Error, please try again later",
                                    calloutTitleColor: .red,
                                    submitButtonTitle: "Try Again")
            : SubmitResultViewModel(calloutTitle: "Enter Your Ressult",
                                    calloutTitleColor: .label,
                                    submitButtonTitle: "Submit")
    }
    
    func getResponseForTestCode() {
        withAnimation {
            showErrorMessage = false
            networkRequestInProgress = true
        }
        networkingManager.validateTestCode(code: textFieldContent) { isValid, error  in
            withAnimation {
                networkRequestInProgress = false
                
                guard error == nil else {
                    showErrorMessage = true
                    return
                }
                
                
                showCard = true
                if isValid! {
                    isPositiveResult = true
                    networkingManager.uploadPersonalTokens(tokens: state.personalTokens)
                } else {
                    isPositiveResult = false
                }
            }
        }
    }
}

struct ResultCard: View {
    let isPositiveResult: Bool
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 8) {
                
                isPositiveResult ? Label("You have tested positive", systemImage: "exclamationmark.triangle.fill") : Label("You have tested negative", systemImage: "checkmark.circle.fill")
                
                
                isPositiveResult ? Text("You should isolate for 15 days as per government guidelines") : Text("Stay safe and continue to follow the recommended guidelines.")
                
            }.padding()
            .foregroundColor(.white)
        }
        .background(isPositiveResult ? Color.rejectedColor : Color.approvedColor)
        .cornerRadius(15)
    }
}

struct SubmitResultViewModel {
    let calloutTitle: String
    let calloutTitleColor: Color
    let submitButtonTitle: String
}

struct SubmitResultView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitResultView()
    }
}
