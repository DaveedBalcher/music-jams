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
    let fillColor: Color
    let borderColor: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(borderColor, lineWidth: 1)
                .background(RoundedRectangle(cornerRadius: 8).fill(fillColor))
            
            Text(text)
                .foregroundColor(borderColor)
                .font(.footnote)
                .fontWeight(.semibold)
        }
        .offset(x: 0, y: -21)
        .frame(width: labelWidth + 12, height: 20)
    }
}
