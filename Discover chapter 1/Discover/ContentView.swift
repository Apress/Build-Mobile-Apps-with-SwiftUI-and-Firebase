import SwiftUI
import MapKit

struct Place: Identifiable {
    var id = UUID()
    var title: String
    var coordinate: CLLocationCoordinate2D
    var architecte: String
}

struct ContentView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.9028, longitude: 12.4964), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    let annotations = [
        Place(title: "Fontana di Trevi", coordinate: CLLocationCoordinate2D(latitude: 41.900833, longitude: 12.483056), architecte: "Nicola Salvi"),
        Place(title: "Pantheon", coordinate: CLLocationCoordinate2D(latitude: 41.8986, longitude: 12.4768), architecte: "Marcus Agrippa"),
        Place(title: "Villa Medici", coordinate: CLLocationCoordinate2D(latitude: 41.908, longitude: 12.483), architecte: "Bartolomeo Ammannati"),
        Place(title: "Colosseo",  coordinate: CLLocationCoordinate2D(latitude: 41.890278, longitude: 12.492222), architecte: "Flavian Emperors")
    ]
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: annotations) {
            MapMarker(coordinate: $0.coordinate)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
