//
//  RequestProtocol.swift
//  StoreApp
//
//  Created by Scizor on 15/11/20.
//

import Foundation
import RxSwift

protocol RequestProtocol {
    associatedtype
    Target: RequestInfos
    func requestObject<Model: Codable>(model: Model.Type, _ target: Target) -> Observable<Model>
    func requestData(target: Target) -> Observable<Data>
}

final class Request<Target: RequestInfos> : RequestProtocol {
    //MARK: - Public methods
    func requestObject<Model: Codable>(model: Model.Type, _ target: Target) -> Observable<Model> {
        guard let url = URL(string: "\(target.baseURL)\(target.endpoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")") else {
            return Observable.error(NSError())
        }
        
        var request = URLRequest(url: url)
        
        do {
            request = try target.parameterEncoding.encode(request: URLRequest(url: url), parameters: target.parameters)
        } catch {
            return Observable.error(NSError())
        }
        
        return Observable.create { observer in
            URLSession.shared.dataTask(with: request) { data, resp, error in
                if let error = error {
                    observer.onError(error)
                    observer.onCompleted()
                }
                
                guard let data = data else {
                    observer.onError(NSError())
                    observer.onCompleted()
                    return
                }
                
                do {
                    let modelList = try JSONDecoder().decode(Model.self , from: data)
                    observer.onNext(modelList)
                    observer.onCompleted()
                } catch {
                    observer.onError(NSError())
                    observer.onCompleted()
                }
            }.resume()
            
            return Disposables.create()
        }
        
        
    }
    
    func requestData(target: Target) -> Observable<Data> {
        guard let url = URL(string: "\(target.baseURL)\(target.endpoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")") else {
            return Observable.error(NSError())
        }
        
        var request = URLRequest(url: url)
        
        do {
            request = try target.parameterEncoding.encode(request: URLRequest(url: url), parameters: target.parameters)
        } catch {
            return Observable.error(NSError())
        }
        return Observable.create { observer in
            URLSession.shared.dataTask(with: request) { data, resp, error in
                if let error = error {
                    observer.onError(error)
                    observer.onCompleted()
                }
                
                guard let data = data else {
                    observer.onError(NSError())
                    observer.onCompleted()
                    return
                }
                
                observer.onNext(data)
                observer.onCompleted()

            }.resume()
            
            return Disposables.create()
        }
        
    }
}

