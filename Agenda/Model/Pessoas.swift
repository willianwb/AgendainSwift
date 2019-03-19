//
//  Pessoas.swift
//  Agenda
//
//  Created by ALUNO on 18/03/19.
//  Copyright © 2019 ALUNO. All rights reserved.
//

import Foundation


class Pessoas{
    var ListaPessoas: [Pessoa]
    
    func add(_ p: Pessoa){
        ListaPessoas.append(p)
    }
    
    func remove(_ number : Int){
        ListaPessoas.remove(at: number)
    }
    
    init(){
        ListaPessoas = [Pessoa]()
        
    }
}
