//
//  Places.swift
//  MapViewTest
//
//  Created by 羅壽之 on 2024/11/27.
//

import MapKit

struct Place: Identifiable {
    let id = UUID()
    let name: String
    let address: String
    var position: CLLocationCoordinate2D?
}
