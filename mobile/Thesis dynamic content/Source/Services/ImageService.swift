//
//  ImageService.swift
//  Thesis dynamic content
//
//  Created by erokha on 4/14/22.
//

import Foundation
import Alamofire
import UIKit

enum TDCImageError: Error {
    case rawError(String)
    case clouldNotCovertImageToData
    case noDataLoaded
    case unknown
}

final class ImageService {
    func loadImage(
        with url: String,
        closure: @escaping (Result<UIImage, TDCImageError>) -> Void
    ) {
        let request = AF.request(url,method: .get)
        
        request.response{ response in
            switch response.result {
            case .success(let data):
                guard let data = data else {
                    closure(.failure(.noDataLoaded))
                    return
                }
                if let image = UIImage(data: data, scale:1) {
                    closure(.success(image))
                } else {
                    closure(.failure(.clouldNotCovertImageToData))
                }
            case .failure(let error):
                closure(
                    .failure(
                        .rawError(error.localizedDescription)
                    )
                )
           }
       }
    }
}
