//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Manuel Carvalho on 14/1/19.
//  Copyright © 2019 Manuel Carvalho. All rights reserved.
//

import UIKit
import MapKit


struct Udacity: Decodable {
    let latitude: Double
    let longitude: Double
}

struct Student1 {
    let objectId: String
    var uniqueKey: String = ""
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaURL: String
    let latitude: Double
    let longitude: Double
    let createdAt: String
    let updatedAt: String
}

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var udacity = [Student1]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapList()
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                let url = URL(string: toOpen)
                app.open(url!, options: [:], completionHandler: nil)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    

    
    func mapList(){
        var annotations = [MKPointAnnotation]()
        for students in Model.udacity {
            
            let lat = CLLocationDegrees(students.latitude)
            let long = CLLocationDegrees(students.longitude)
            
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
//            let first = dictionary["firstName"] as! String
//            let last = dictionary["lastName"] as! String
//            let mediaURL = dictionary["mediaURL"] as! String
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            //annotation.title = "\(first) \(last)"
            //annotation.subtitle = mediaURL
            
            annotations.append(annotation)
        }
        
        self.mapView.addAnnotations(annotations)
        
    }
    
}
