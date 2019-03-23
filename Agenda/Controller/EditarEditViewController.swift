//
//  EditarEditViewController.swift
//  Agenda
//
//  Created by ALUNO on 22/03/19.
//  Copyright © 2019 ALUNO. All rights reserved.
//

import UIKit
import CoreData

class EditarEditViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var usuario : Pessoa?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func EditarUsuario(){
        
        
    }
    
    func CamposCheck()->Bool{
        return false
    }
    
    func SaveContext(){
        do {
            try context.save()
        } catch  {
            print("ERRO AO SALVAR O CONTEXTO: \(error)")
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
