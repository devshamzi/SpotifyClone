//
//  ViewController.swift
//  SpotifyClone
//
//  Created by Shamseer Ali on 24/08/2021.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    var datasource = [DetailModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getData()
        
    }

    
    func getData(){
        HomeSevices.shared.searchTerm(term: "")
            .subscribe(onNext: { [weak self] (result) in
                guard let self = self else {return}
                switch result {
                case .success(let value):
                   print(value)
                    self.datasource = value
                    
                case .failure(let error):
                    print(error)
                }
            })
            .disposed(by: DisposeBag())
    }

}

