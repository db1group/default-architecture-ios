//
//  CircleImage.swift
//  Landmarks
//
//  Created by Glauco Dantas Beserra  on 09/01/20.
//  Copyright © 2020 Glauco Dantas Beserra . All rights reserved.
//

import SwiftUI

struct CircleImage: View {
    var body: some View {
        Image("turtlerock")
            .clipShape(Circle())
            .overlay(
                Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)
    }
}
