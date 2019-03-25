//
//  AddContatoViewController.swift
//  Agenda
//
//  Created by Willian Bibow on 3/20/19.
//  Copyright © 2019 ALUNO. All rights reserved.
//

import UIKit

class AddContatoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var nome: UITextField!
    @IBOutlet weak var genero: UITextField!
    @IBOutlet weak var rua: UITextField!
    @IBOutlet weak var numero: UITextField!
    @IBOutlet weak var cep: UITextField!
    @IBOutlet weak var telefone: UITextField!
    @IBOutlet weak var btnSAVE: UIBarButtonItem!
    @IBOutlet weak var site: UITextField!
    @IBOutlet weak var btnImportImage: UIButton!
    
    @IBOutlet weak var adduserImageView: UIImageView!
    
    var tableViewAnterior: TableViewController!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func createUsuario(nome: String,sex: String,id: Int,fone: String, cep: String, num: String, rua: String, imagem: UIImage) -> Pessoa{
        let p1 = Pessoa(context: context)
        let e1 = Endereco(context: context)
        let phone = Phone(context: context)
        let image = Imagens(context: context)
        image.imagem = imagem.pngData()
        e1.cep = cep
        e1.number = num
        e1.street = rua
        phone.number = fone
        p1.name = nome
        p1.id = Int64(id)
        p1.sex = sex
        p1.endereco = e1
        p1.site = NSURL(string: site.text!)! as URL
        p1.fones = phone
        p1.addToImagensRelation(image)
        return p1
    }
    
    func checkNull()-> Bool {
        if (nome.text! == "" || genero.text! == "" || rua.text == "" || numero.text == "" || cep.text == "" || telefone.text == "" || site.text == "" || adduserImageView.image == nil){
            return false
        }
        return true
        
    }
    
    @IBAction func SaveButton(_ sender: Any) {
        if ( checkNull()){
            let pessoa = createUsuario(nome: nome.text!, sex: genero.text!, id: tableViewAnterior.listaPessoas.countPessoas, fone: telefone.text!, cep: cep.text!, num: numero.text!, rua: rua.text!, imagem: adduserImageView.image!)
            tableViewAnterior.listaPessoas.addPessoa(pessoa)
            alertSuccess()
            saveContext()
        }else{
            alertError()
        }
        
        
        tableViewAnterior.tableView.reloadData()
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
    
    func saveContext(){
        do {
            try context.save()
        } catch  {
            print("ERRO AO SALVAR O CONTEXTO: \(error)")
        }
        
        
    }
    
    @IBAction func importImage(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self

        image.sourceType = .photoLibrary
        image.allowsEditing = false
        present(image, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            adduserImageView.image = image
        }else{
            //mensagem de erro caso falhe
        }

        self.dismiss(animated: true, completion:    nil)
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
