//
//  ContainerView.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 1/25/23.
//

import SwiftUI

struct ContainerView: View {
    @ObservedObject var vm: MainViewModel
    
    @State private var isPresentingInfo = false
    
    var body: some View {
        NavigationView {
            MainView(regions: $vm.regions, selectedRegion: $vm.selectedRegion, places: $vm.places, selectedPlace: $vm.selectedPlace)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Image("philly_jams_logo_navbar")
                            .padding([.leading], 12)
                            .padding([.trailing], 12)
                            .padding([.bottom], 4)
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        InfoBannerView(isPresentingInfo: $isPresentingInfo)
                    }
                }
                .popover(isPresented: $isPresentingInfo){
                    InfoView(isPresenting: $isPresentingInfo)
                }
        }
    }
}

extension UINavigationController {
    open override func viewWillLayoutSubviews() {
        // Remove back button text
        super.viewWillLayoutSubviews()
        navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
}
