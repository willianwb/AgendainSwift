//
//  EditViewController.swift
//  Agenda
//
//  Created by ALUNO on 20/03/19.
//  Copyright © 2019 ALUNO. All rights reserved.
//

import UIKit
import CoreData

class EditViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var btnAddPic: UIView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var tableViewAnterior: TableViewController?
    
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
        nome.text = usuario?.name
        sexo.text = usuario?.sex
        rua.text = usuario?.endereco?.street
        numero.text = usuario?.endereco?.number
        cep.text = usuario?.endereco?.cep
        site.text = usuario?.site?.absoluteString
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return The number of rows in section.
        return (usuario?.imagensRelation?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //return A configured cell object.
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
        
        for img in (usuario?.imagensRelation)!{
            let imagem = img as! Imagens
            cell.usuarioImageView.image = UIImage(data: imagem.imagem!)

        }
        return cell
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
            let img = Imagens(context: context)
            img.imagem = image.pngData()
            usuario?.addToImagensRelation(img)
        }else{
            //mensagem de erro caso falhe
        }
        
        self.dismiss(animated: true, completion:    nil)
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "webview"{
            let next = segue.destination as! WebViewController
            next.myURL = usuario?.site
            
        }
    }

}
