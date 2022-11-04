//
//  BannerViews.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 11/2/22.
//

import SwiftUI

struct SimpleBannerView: View {
    let message: String
    var backgroundColor: Color = .white
    
    var body: some View {
        ZStack {
            backgroundColor
            
            Text(message)
                .foregroundColor(.white)
        }
        .frame(maxHeight: 44)
        .padding([.bottom], -16)
    }
}

struct InfoBannerView: View {
    @Binding var isPresentingInfo: Bool
    @Binding var isPresenting: Bool
    let backgroundColor: Color = .white
    
    var body: some View {
        ZStack {
            backgroundColor
            
            HStack {
                
                Button {
                    isPresentingInfo = true
                } label: {
                    Label {
                        Text("")
                    } icon: {
                        Image(systemName: "info.circle")
                            .font(.system(size: 24))
                            .foregroundColor(.lightBlue)
                    }
                }
                
                Text("|")
                    .font(.system(size: 20))
                    .foregroundColor(.black.opacity(0.25))
                    .padding([.trailing], 8)
                    .padding([.bottom],4)
                
                Link("Add an Event", destination: URL(string: "https://forms.gle/ZdcBWFYL97iuhDZx8")!)
                    .font(.subheadline)
                    .foregroundColor(Color.lightBlue)
                
                Spacer()
                
                Button {
                    isPresenting = false
                } label: {
                    Label {
                        Text("")
                    } icon: {
                        Image(systemName: "multiply")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black.opacity(0.50))
                    }
                }
                .padding([.bottom], 4)
            }
            .padding([.leading], 24)
            .padding([.trailing], 18)
            
        }
        .frame(maxHeight: 44)
        .padding([.bottom], -16)
    }
}


