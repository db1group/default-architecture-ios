//
//  ContentView.swift
//  Landmarks
//
//  Created by Glauco Dantas Beserra  on 09/01/20.
//  Copyright © 2020 Glauco Dantas Beserra . All rights reserved.
//

import SwiftUI
import Core

@available(iOS 13.0, *)
struct ContentView: View {
    
    let parent: SwiftUIDemoCoordinator
    
    init(coordinator: SwiftUIDemoCoordinator) {
        self.parent = coordinator
    }
    
    var body: some View {
        VStack {
            MapView()
                .edgesIgnoringSafeArea(.top)
                .frame(height: 300)
            
            CircleImage()
                .offset(y: -130)
                .padding(.bottom, -130)
            
            VStack(alignment: .leading) {
                Text("DB1")
                    .font(.title)
                HStack {
                    Text("Global Software")
                        .font(.subheadline)
                    Spacer()
                    Text("Maringá - PR")
                        .font(.subheadline)
                }
            }
            .padding()
            
            Spacer()
            // Faz sentido?
        }.onDisappear(perform: {
            self.parent.onFlowFinish()
        })
    }
}

@available(iOS 13.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coordinator: SwiftUIDemoCoordinator(navigationController: UINavigationController()))
    }
}
