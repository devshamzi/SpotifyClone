//
//  HomeSevices.swift
//  SpotifyClone
//
//  Created by Shamseer Ali on 24/08/2021.
//

import RxSwift

struct HomeSevices : Wrapable{
    
    static let shared = HomeSevices()
    
    private init(){}
    
    func searchTerm(term : String) -> Observable<AFResult<[DetailModel]>> {

        return request(url: "https://jsonplaceholder.typicode.com/todos")
    }
    
}


struct DetailModel : Codable {
    var userId : Int?
    var id : Int?
    var title : String?
    var completed : Bool?
}
