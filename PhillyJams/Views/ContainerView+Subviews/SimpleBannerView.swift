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

