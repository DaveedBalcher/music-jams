//
//  BannerViews.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 11/2/22.
//

import SwiftUI

struct SimpleBannerView: View {
    let backgroundColor: Color = .white
    let message: String
    
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
    let backgroundColor: Color = .white
    @Binding var isPresentingInfo: Bool
    
    var body: some View {
        ZStack {
            Color.white
            
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
                
                Link("Add an event", destination: URL(string: "https://forms.gle/ZdcBWFYL97iuhDZx8")!)
                    .foregroundColor(Color.lightBlue)
                
                Spacer()
            }
            .padding([.leading, .trailing],24)
            
        }
        .frame(maxHeight: 44)
        .padding([.bottom], -16)
    }
}


