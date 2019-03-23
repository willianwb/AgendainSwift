//
//  ViewController.swift
//  Agenda
//
//  Created by ALUNO on 18/03/19.
//  Copyright © 2019 ALUNO. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var listaPessoas = PessoasViewModel()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        loadContext()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let pessoa = Pessoa(context: context)
//        pessoa.name = "Flobervaldo Antares Montanha"
//        let pessoa2 = Pessoa(context: context)
//        pessoa2.name = "JOAO Antares Montanha"
//        let pessoa3 = Pessoa(context: context)
//        pessoa3.name = "JOAQUINO Antares Montanha"
        
//        ListaPessoas.addPessoa(pessoa)
//        ListaPessoas.addPessoa(pessoa2)
//        ListaPessoas.addPessoa(pessoa3)
        
        
    }
    
    func loadContext(){
        let req : NSFetchRequest<Pessoa> = Pessoa.fetchRequest()
        print(req)
        
        do {
            try listaPessoas.pessoasViewModel.ListaPessoas = context.fetch(req)
        } catch  {
            print("ERRO AO LER O CONTEXTO: \(error)")
        }
        
    }
    
    func SaveContext(){
        do {
            try context.save()
        } catch  {
            print("ERRO AO SALVAR O CONTEXTO: \(error)")
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ListarPessoas"{
            let next = segue.destination as! TableViewController
            next.listaPessoas = listaPessoas
            next.controllerInicial = self
            
        }
    }
    

}

