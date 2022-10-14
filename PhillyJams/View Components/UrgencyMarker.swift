//
//  UrgencyMarker.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 10/14/22.
//

import SwiftUI

struct UrgencyMarker: View {
    let text: String
    let labelWidth: Double
    let primaryColor: Color
    let secondaryColor: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(secondaryColor, lineWidth: 1)
                .background(RoundedRectangle(cornerRadius: 8).fill(primaryColor))
            
            Text(text)
                .foregroundColor(secondaryColor)
                .font(.footnote)
                .fontWeight(.semibold)
        }
        .offset(x: 0, y: -21)
        .frame(width: labelWidth, height: 20)
    }
}
