//
//  ContentView.swift
//  MapViewTest
//
//  Created by 羅壽之 on 2024/11/27.
//

import SwiftUI
import MapKit
import CoreLocation

struct ContentView: View {
    
    @State var places: [Place] = [
        Place(name: "Taipei 101", address: "", position: CLLocationCoordinate2D(latitude: 25.033611, longitude: 121.565)),
        Place(name: "Sun Moon Lake", address: "", position: CLLocationCoordinate2D(latitude: 23.851880, longitude: 120.921873)),
        Place(name: "Kenting National Park", address: "", position: CLLocationCoordinate2D(latitude: 21.955439, longitude: 120.777463)),
        Place(name: "Alishan National Forest", address: "阿里山，嘉義，台灣")
    ]
    
    // starting region (our school)
    @State var region: MKCoordinateRegion =
    MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 23.892882, longitude: 121.543936), span: MKCoordinateSpan(latitudeDelta: 0.8, longitudeDelta: 0.8))
    
    // starting marker
    let initialPlace = Place(name: "Dong Hwa University", address: "", position: CLLocationCoordinate2D(latitude: 23.892882, longitude: 121.543936))
    
    @State var markers: [Place] = []
    @State var searchText = ""
    
    let locationManager = CLLocationManager()
    
    
    var body: some View {
        NavigationView {
            VStack {
//                Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow),annotationItems: markers) {
                Map(coordinateRegion: $region,annotationItems: markers) {
                    place in
                    //MapMarker(coordinate: place.position!)
                    //MapPin(coordinate: place.position!)
                    MapAnnotation(coordinate: place.position!) {
                        VStack {
                            Image(systemName: "mappin.circle.fill")
                                .font(.title)
                                .foregroundColor(.red)
                            Text(place.name)
                                .font(.caption)
                                .foregroundColor(.gray)
                                .background(Color.yellow)
                        }
                    }
                }
            } // VStack
            .navigationTitle("Discover Taiwan")
            
            // toolbar
            .toolbar {
                // seach one place
                ToolbarItem(placement: .navigationBarLeading) {
                    TextField("Search one place", text: $searchText, onCommit:  {
                        searchPlaces(query: searchText)
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                // sample places
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        ForEach(places.indices, id:\.self) { index in
                            Button("\(places[index].name)") {
                                moveToPlace(index: index)
                            }
                        }
                    } label: {
                        Image(systemName: "line.horizontal.3")
                    }
                }
                
                //Show route
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if let target = markers.first {
                            showRoute(destination: target)
                        }
                    } label: {
                        Image(systemName: "location.viewfinder")
                    }
                    .disabled(markers.isEmpty)
                }
            } // toolbar
            
        } // NavigationView
        .onAppear {
            locationManager.requestWhenInUseAuthorization()
        }
        
    } // body
    
    func moveToPlace(index: Int) {
        let place = places[index]
        // check the position first
        if place.position == nil {
            // get the position from the address
            let geoCoder = CLGeocoder()
            geoCoder.geocodeAddressString(place.address) { placemarks, error in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                guard let placemarks = placemarks else {
                    print("No placemarks found")
                    return
                }
                // update the position
                places[index].position = placemarks.first!.location?.coordinate
                
                withAnimation {
                    region.center = places[index].position!
                    markers = [places[index]]
                }
            }
        }
        else {
            withAnimation {
                region.center = places[index].position!
                markers = [places[index]]
            }
        }
    }
    
    func showRoute(destination: Place) {
        guard destination.position != nil else { return }
        
        // Using MapItem
//        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: destination.position!, addressDictionary: nil))
//        mapItem.name = destination.name
//        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])  // car driving route
        
        // Using UIApplication.shared.open
        if let url = URL(string: "maps://?daddr=\(destination.position!.latitude),\(destination.position!.longitude)&directionsmode=driving") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func searchPlaces(query: String) {
        guard query.isEmpty == false else { return }
        
        // declare a region covering the whole Taiwan island
        let searchRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 23.7, longitude: 121.0),
            span: MKCoordinateSpan(latitudeDelta: 5.0, longitudeDelta: 3.0)
        )
        
        // Create a search request
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        request.region = searchRegion
        
        // Initialize the search
        let search = MKLocalSearch(request: request)
        
        // Start the search
        search.start { response, error in
            if let error = error {
                print("Search error: \(error)")
                return
            }
            
            guard let response = response else {
                print("No results found.")
                return
            }
            
            // Get the first result
            if let mapItem = response.mapItems.first {
                let name = mapItem.name ?? "No Name"
                let location = mapItem.placemark.title ?? "No Address"
                let position = mapItem.placemark.coordinate
                
                withAnimation {
                    region.center = position
                    markers = [Place(name: name, address: location, position: position)]
                }
            }
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
