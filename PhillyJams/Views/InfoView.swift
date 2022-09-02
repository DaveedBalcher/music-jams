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
                Use this iOS app to navigate Philly's weekly and monthly music jam sessions and open mics.
                
                We want to invigorate music communities around Philadelphia and help you find your musical vibe. We rely on Philadelphians like you to build and validate this exclusive centralized collection.
                
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
