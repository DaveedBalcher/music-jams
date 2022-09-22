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
                Philly Jams is built to advance engagement in neighborly creativity and collaboration via playing music. Musicians and music lovers use the app to discover events that fit their favorite genre of music and social vibe.
                
                This community is built on fellow Philadelphian's feedback and contributed knowledge.
                
                """
            )
            Link("Add a venue or event", destination: URL(string: "https://forms.gle/ZdcBWFYL97iuhDZx8")!)
                .foregroundColor(.blue)
            
            Link("Leave a comment or question", destination: URL(string: "https://forms.gle/ycYkYEcLsuzLNQEJA")!)
                .foregroundColor(.blue)
            
            
            Text(
                """
                
                
                Comments or questions?
                
                Email Daveed: Daveed@daveedmakesapps.com
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
