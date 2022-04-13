//
//  LayoutRequestService.swift
//  Thesis dynamic content
//
//  Created by erokha on 4/6/22.
//

import Foundation
import Alamofire

enum TDCNetworkError: Error {
    case unknown
}

class LayoutRequestService {
    func requestHardcodeLayout(
        closure: @escaping (Result<TDCViewDTO, TDCNetworkError>) -> Void
    ) {
        typealias ResultType = Result<TDCViewDTO, TDCNetworkError>
        let request = AF.request("http://127.0.0.1:5000")
        request.responseDecodable(of: TDCViewDTO.self) { (response) in
            switch response.result {
            case .success(let data):
                closure(.success(data))
            case .failure:
                closure(.failure(.unknown))
            }
        }
    }
}
