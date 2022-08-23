//
//  OmdbApiService.swift
//  OmdbiOSCase
//
//  Created by Ali Şengür on 22.08.2022.
//

import Foundation
import Alamofire

class OmdbApiService {
    
    private let baseUrl = "http://www.omdbapi.com/"
    private let apiKey = "ec6eb389"
    
    func searchMovie(with name: String, onSuccess: @escaping(MovieSearchModel) -> Void, onFailure: @escaping(String?) -> Void) {
        
        let parameters: [String: String] = [
            "apiKey": apiKey,
            "s": name 
        ]
        
        AF.request(baseUrl,
                   method: .get,
                   parameters: parameters).responseDecodable(of: MovieSearchModel.self) { result in
            
            if let responseValue = result.value {
                if let error = responseValue.error {
                    onFailure(error)
                    return
                }
                onSuccess(responseValue)
            }
        }
    }
}
