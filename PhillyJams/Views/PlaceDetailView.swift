//
//  PlaceDetailView.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 8/31/22.
//

import SwiftUI
import MusicVenues

struct PlaceDetailView: View {
    let placeVM: PlaceViewModel
    let eventsVM: [EventViewModel]
    
    @State private var isPresentingWebView = false
    
    var body: some View {
        
        ZStack(alignment: .top) {
            Rectangle()
                .fill(.regularMaterial)
                .frame(maxHeight: 92)
                .ignoresSafeArea()
            
            ScrollView {
                VStack {
                    ZStack(alignment: .bottomLeading) {
                        placeVM.image
                            .resizable()
                            .padding(90)
                            .foregroundColor(.white)
                            .scaledToFit()
                            .background(
                                Rectangle()
                                    .foregroundColor(placeVM.color)
                                    .cornerRadius(8)
                                    .shadow(radius: 8)
                            )
                        
                        VStack(alignment: .leading) {
                            HStack(spacing: 0) {
                                Text("Type: ")
                                Text(placeVM.type)
                            }
                            HStack(spacing: 0) {
                                Text("Genres: ")
                                Text(placeVM.genres)
                            }
                            HStack(spacing: 0) {
                                Text("Vibe: ")
                                Text(placeVM.vibes)
                            }
                        }
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(12)
                    }
                    .padding(12)
                    
                    
                    // TODO: Add place description
                    
                    Text("Events")
                        .font(.headline)
                        .padding()
                    
                    if eventsVM.isEmpty {
                        Text("List of jams and open mics coming soon...")
                            .padding()
                            .font(.callout)
                            .foregroundStyle(.gray)
                    } else {
                        ForEach(eventsVM, id: \.self) { eventVM in
                            HStack {
//                                let title = [event.description, event.title].filter { !$0.isEmpty }.joined(separator: ": ")
//                                let date = [event.nextDate, event.startTime, event.endTime].filter { !$0.isEmpty }.joined(separator: " - ")
//                                let hosts = event.hosts?.filter { !$0.isEmpty }.joined(separator: " and ")
                                
                                VStack(alignment: .leading) {
                                    Text(eventVM.title)
                                        .fontWeight(.semibold)
                                    Text("\(eventVM.date)")
                                        .fontWeight(.light)
                                    Text("Host(s): \(eventVM.hosts)")
                                        .fontWeight(.light)
                                    if let url = eventVM.url {
                                        NavigationLink {
                                            WebView(url: url)
                                                .ignoresSafeArea()
                                        } label: {
                                            Text("Visit Event Page")
                                                .foregroundColor(Color.lightBlue)
                                        }
                                    }
                                }
                                .font(.subheadline)
                                .padding(8)
                                
                                Spacer()
                            }
                            .padding([.leading, .trailing], 16)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Link(destination: URL(string: "https://forms.gle/ZdcBWFYL97iuhDZx8")!) {
                        Label {
                            Text("Add")
                                .font(.caption)
                                .fontWeight(.light)
                                .offset(x: -4)
                        } icon: {
                            Image(systemName: "plus")
                                .foregroundColor(.lightBlue)
                        }
                    }
                }
            }
        }
        .navigationTitle(placeVM.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PlaceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            
            let event = Event.preview
            let place = Place(with: [event])

            PlaceDetailView(placeVM: PlaceViewModel(place: place), eventsVM: [EventViewModel(event)])
        }
    }
}
