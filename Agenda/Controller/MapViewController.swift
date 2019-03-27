//
//  MapViewController.swift
//  Agenda
//
//  Created by ALUNO on 25/03/19.
//  Copyright © 2019 ALUNO. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var nome: String?
    var rua: String?
    var numero: String?
    var cep: String?
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        self.view.addSubview(activityIndicator)
        
        let searchRequest = MKLocalSearch.Request()
        let rua : String = self.rua!
        let numero : String = self.numero!
        let cep : String = self.cep!
        let local : String = String("\(rua), \(numero), \(cep)")
        searchRequest.naturalLanguageQuery = local
        
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        activeSearch.start { (response, error) in
            
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if response == nil {
                print("ERRO")
            }else {
                //Remover anotação
                //let anotacoes = self.mapa.annotations
                //self.mapa.removeAnnotation(anotacoes as! MKAnnotation)
                
                //Busca dados
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                //Cria anotação
                let anotacao = MKPointAnnotation()
                anotacao.title = self.nome
                anotacao.subtitle = local
                anotacao.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                self.map.addAnnotation(anotacao)
                
                //Zoom
                let coordenada: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
                let regiao = MKCoordinateRegion(center: coordenada, span: span)
                self.map.setRegion(regiao, animated: true)
            }
        }
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
