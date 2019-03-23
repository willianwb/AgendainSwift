//
//  EditViewController.swift
//  Agenda
//
//  Created by ALUNO on 20/03/19.
//  Copyright © 2019 ALUNO. All rights reserved.
//

import UIKit
import CoreData

class EditViewController: UIViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var usuario : Pessoa?
    @IBOutlet weak var sexo: UITextField!
    

    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var cep: UITextField!
    @IBOutlet weak var numero: UITextField!
    @IBOutlet weak var rua: UITextField!
    @IBOutlet weak var nome: UITextField!
    @IBOutlet weak var site: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path:String = (usuario?.site!.path)!
        
        nome.text = usuario?.name
        sexo.text = usuario?.sex
        rua.text = usuario?.endereco?.street
        numero.text = usuario?.endereco?.number
        cep.text = usuario?.endereco?.cep
        site.text = path
        for i in (usuario?.fones)!{
            let fone = i as! Phone
            phone.text = fone.number
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "edit"{
            let next = segue.destination as! EditarEditViewController
            next.usuario = usuario
            
        }
    }

}
