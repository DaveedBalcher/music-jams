//
//  PageHeader.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 9/23/22.
//

import SwiftUI

struct PageHeader: View {
    let title: String
    let actionText: String
    let didComplete: ()->Void
    
    var body: some View {
        HStack {
            Spacer(minLength: 86)
            Spacer()
            Text(title)
                .font(.headline)
            Spacer()
            Button {
                didComplete()
            } label: {
                Text(actionText)
                    .foregroundColor(Color.lightBlue)
            }
            .frame(width: 86)
        }
        .background(.white)
        .padding([.top], 24)
    }
}
