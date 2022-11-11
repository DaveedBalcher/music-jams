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
    let backgroundColor: Color = .white
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(backgroundColor)

            HStack {
                Link("Add an Event", destination: URL(string: "https://forms.gle/ZdcBWFYL97iuhDZx8")!)
                    .font(.subheadline)
                    .foregroundColor(Color.lightBlue)
                
                Text("|")
                    .font(.system(size: 16))
                    .foregroundColor(.black.opacity(0.25))
                    .padding([.bottom],4)
                
                Button {
                    isPresentingInfo = true
                } label: {
                    Label {
                        Text("")
                    } icon: {
                        Image(systemName: "info.circle")
                            .font(.system(size: 16))
                            .foregroundColor(.lightBlue)
                    }
                }
                .padding([.leading], -8)
            }
            .padding([.leading], 4)
            .padding([.trailing], 8)
            
        }
        .frame(maxHeight: 24)
        .padding([.trailing], -8)
    }
}


