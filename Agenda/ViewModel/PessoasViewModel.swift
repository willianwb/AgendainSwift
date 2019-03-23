//
//  PessoasViewModel.swift
//  Agenda
//
//  Created by ALUNO on 18/03/19.
//  Copyright © 2019 ALUNO. All rights reserved.
//

import Foundation
import CoreData


class PessoasViewModel{

    let pessoasViewModel: Pessoas
    

    
    var ListaPessoas: [Pessoa] {
        return pessoasViewModel.ListaPessoas
    }
    
    var countPessoas: Int {
        return pessoasViewModel.ListaPessoas.count
    }
    
    func addPessoa(_ p: Pessoa){
        pessoasViewModel.add(p)
    }
    
    func removePessoa(_ n: Int){
        pessoasViewModel.remove(n)
        
    }
    
    
    init(){
        pessoasViewModel = Pessoas()
    }
    
    
    
    
    
    
    
    
    
    
}


