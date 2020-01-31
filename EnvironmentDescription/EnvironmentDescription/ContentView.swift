//
//  ContentView.swift
//  EnvironmentDescription
//
//  Created by Glauco Dantas Beserra  on 30/01/20.
//  Copyright © 2020 DB1 Global Software. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct ContentView: View {
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
        }
    }
}

@available(iOS 13.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
