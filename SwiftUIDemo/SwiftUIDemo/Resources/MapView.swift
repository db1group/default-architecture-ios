//
//  MapView.swift
//  Landmarks
//
//  Created by Glauco Dantas Beserra  on 09/01/20.
//  Copyright © 2020 Glauco Dantas Beserra . All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        let coordinate = CLLocationCoordinate2D(latitude: 34.011286,
                                                longitude: -116.166868)
        let span = MKCoordinateSpan(latitudeDelta: 2.0,
                                    longitudeDelta: 2.0)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)
    }
}
