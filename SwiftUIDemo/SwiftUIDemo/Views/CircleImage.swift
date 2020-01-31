//
//  CircleImage.swift
//  Landmarks
//
//  Created by Glauco Dantas Beserra  on 09/01/20.
//  Copyright © 2020 Glauco Dantas Beserra . All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct CircleImage: View {
    
    private let bundle = Bundle(identifier: "com.db1.SwiftUIDemo")
    
    var body: some View {
        Image("db1-logo", bundle: bundle)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 200, height: 200, alignment: .center)
            .background(Color.white)
            
            .clipShape(Circle())
            .overlay(
                Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)
    }
}

@available(iOS 13.0, *)
struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage()
    }
}
