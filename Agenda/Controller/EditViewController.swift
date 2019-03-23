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
    
    var tableViewAnterior: TableViewController?
    
    var usuario : Pessoa?
    @IBOutlet weak var sexo: UITextField!
    

    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var cep: UITextField!
    @IBOutlet weak var numero: UITextField!
    @IBOutlet weak var rua: UITextField!
    @IBOutlet weak var nome: UITextField!
    @IBOutlet weak var site: UITextField!
    
    @IBOutlet weak var gotosite: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        let path:String = (usuario?.site!.path)!
        
        nome.text = usuario?.name
        sexo.text = usuario?.sex
        rua.text = usuario?.endereco?.street
        numero.text = usuario?.endereco?.number
        cep.text = usuario?.endereco?.cep
        site.text = path
        phone.text = usuario?.fones?.number
        // como percorrer vetor de nsset
//        for i in (usuario?.fones)!{
//            let fone = i as! Phone
//            phone.text = fone.number
//        }
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
    @IBAction func saveEditUsuario(_ sender: Any) {
        EditarUsuario()
        
    }
    
    func EditarUsuario(){
        if CamposCheck(){
            usuario?.name = nome.text
            usuario?.sex = sexo.text
            usuario?.endereco?.street = rua.text
            usuario?.endereco?.number = numero.text
            usuario?.endereco?.cep = cep.text
            usuario?.site = URL(string: site.text!)
            usuario?.fones?.number = phone.text
            alertSuccess()
            SaveContext()
            tableViewAnterior?.tableView.reloadData()
        }else{
            alertError()
        }
        
    }
    
    func CamposCheck()->Bool{
        if (nome.text! == "" || sexo.text! == "" || rua.text! == "" || numero.text! == "" || cep.text! == "" || site.text! == "" || phone.text! == ""){
            
            return false
        }
        
        return true
    }
    
    func SaveContext(){
        do {
            try context.save()
        } catch  {
            print("ERRO AO SALVAR O CONTEXTO: \(error)")
        }
        
        
    }
    
    func alertSuccess(){
        let alert = UIAlertController(title: "Salvo!", message: "Com Sucesso!", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default){
            acion -> Void in
            self.navigationController?.popViewController(animated: true)
        })
        self.present(alert,animated: true,completion: nil)
    }
    
    func alertError(){
        let alerterro = UIAlertController(title: "ERRO!", message: "Campo em branco!", preferredStyle: UIAlertController.Style.alert)
        
        alerterro.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default){
            acion -> Void in
        })
        
        self.present(alerterro,animated: true,completion: nil)
    }

}
