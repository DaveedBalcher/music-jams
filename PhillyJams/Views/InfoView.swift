//
//  InfoView.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 8/31/22.
//

import SwiftUI

struct InfoView: View {
    @Binding var isPresenting: Bool
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Group {
                    Text("Welcome to Philly Jams!\n")
                        .font(.title2)
                        .foregroundColor(.secondary)

                    Text(
                        """
                        Philly Jams is built to advance engagement in neighborly creativity and collaboration via playing music. Musicians and music lovers use the app to discover events that fit their favorite genre of music and social vibe.
                        
                        This community is built on fellow Philadelphian's contributed knowledge of music jam scenes.
                        
                        """
                    )
                    Link("Add a venue or event", destination: URL(string: "https://forms.gle/ZdcBWFYL97iuhDZx8")!)
                        .foregroundColor(Color.lightBlue)
                    
                    Text(
                    """
                        
                    """
                    )
                    
                    Link("Leave a comment or question", destination: URL(string: "https://forms.gle/ycYkYEcLsuzLNQEJA")!)
                        .foregroundColor(Color.lightBlue)
                }
                .padding([.leading, .trailing])
            
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    isPresenting = false
                } label: {
                    Text("Done")
                        .foregroundColor(.lightBlue)
                }
            }
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            InfoView(isPresenting: .constant(true))
        }
    }
}
