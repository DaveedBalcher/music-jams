//
//  InfoView.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 8/31/22.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Welcome to Philly Jams!\n")
                .font(.title2)
                .foregroundColor(.secondary)

            Text(
                """
                Philly Jams is built to advance engagement in neighborly collaboration via playing music. Musicians and music lovers use the app to discover events that fit their favorite genre of music and social vibe.
                
                We heavily value your feedback and contributing your knowledge. Please fill out the following short survey:
                
                """
            )
            Link("Click here", destination: URL(string: "https://forms.gle/K3MBdoiw5xfSkxx2A")!)
                .foregroundColor(.blue)
            
            Text(
                """
                
                
                Comments or questions?
                
                Email Daveed: Drummer.Philly@gmail.com
                """
            )
            Spacer()
        }
        .padding([.top], 48)
        .padding()
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
