//
//  OmdbApiService.swift
//  OmdbiOSCase
//
//  Created by Ali Şengür on 22.08.2022.
//

import Foundation
import Alamofire

protocol OmdbApiServiceProtocol {
    func searchMovie(with name: String, onSuccess: @escaping(MovieSearchModel) -> Void, onFailure: @escaping(String?) -> Void)
    func getMovieDetail(with imdbId: String, onSuccess: @escaping ((MovieDetailModel) -> Void), onFailure: @escaping(String?) -> Void)
}

class OmdbApiService: OmdbApiServiceProtocol {
    
    private let baseUrl = "http://www.omdbapi.com/"
    private let apiKey = "ec6eb389"
    
    func searchMovie(with name: String, onSuccess: @escaping(MovieSearchModel) -> Void, onFailure: @escaping(String?) -> Void) {
        
        let parameters: [String: String] = [
            "apiKey": apiKey,
            "s": name 
        ]
        
        AF.request(baseUrl,
                   method: .get,
                   parameters: parameters).validate().responseDecodable(of: MovieSearchModel.self) { result in
            
            if let responseValue = result.value {
                if let error = responseValue.error {
                    onFailure(error)
                    return
                }
                onSuccess(responseValue)
            }
        }
    }
    
    func getMovieDetail(with imdbId: String, onSuccess: @escaping ((MovieDetailModel) -> Void), onFailure: @escaping(String?) -> Void) {

        let parameters: [String: String] = [
            "apiKey": apiKey,
            "i": imdbId
        ]
        
        AF.request(baseUrl,
            method: .get,
                   parameters: parameters).validate().responseDecodable(of: MovieDetailModel.self, completionHandler: { result in

            if let responseValue = result.value {
                if let error = responseValue.error {
                    onFailure(error)
                    return
                }
                onSuccess(responseValue)
            }
        })
    }
}
