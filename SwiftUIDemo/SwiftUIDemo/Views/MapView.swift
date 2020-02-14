//
//  MapView.swift
//  Landmarks
//
//  Created by Glauco Dantas Beserra  on 09/01/20.
//  Copyright © 2020 Glauco Dantas Beserra . All rights reserved.
//

import SwiftUI
import MapKit

@available(iOS 13.0, *)
struct MapView: UIViewRepresentable {
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        let coordinate = CLLocationCoordinate2D(latitude: -23.416894,
                                                longitude: -51.934001)
        let span = MKCoordinateSpan(latitudeDelta: 0.3,
                                    longitudeDelta: 0.3)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)
    }
}

@available(iOS 13.0, *)
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
