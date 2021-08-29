//
//  Wrapable.swift
//  SpotifyClone
//
//  Created by Shamseer Ali on 24/08/2021.
//

import Foundation
import Alamofire
import RxSwift

typealias  AFResult<T> = Result<T, Error>

protocol  Wrapable { }

extension Wrapable {
    
    func request<T: Decodable>(url : String, parm : [String : Any?]? = nil) -> Observable<AFResult<T>>  {
        
        let observer = PublishSubject<AFResult<T>>()
        
        let encoding: ParameterEncoding = JSONEncoding.default
        
        AF.request(url, method: .get, parameters: parm == nil ? nil: parm! as Parameters , encoding: encoding, headers: nil).responseData{  response in
            
            print("--------------------------")
            debugPrint(response)
            print("--------------------------")
            
            let resData = response.data
            let statusCode = response.response?.statusCode ?? 0
            
            
            switch statusCode{
            
            case 200:
                do {
                    guard let data = resData else{return}
                    let value = try JSONDecoder().decode(T.self, from: data)
                    observer.onNext(AFResult.success(value))
                } catch {
                    print(error.localizedDescription)
                    observer.onNext(AFResult.failure(Error.self as! Error))
                }
                break
                
            default:
                break
            }
            
            observer.onCompleted()
            
        }
        return observer
    }
}
