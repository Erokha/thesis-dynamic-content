import Foundation
import Alamofire

enum TDCNetworkError: Error {
    case unknown
}

class LayoutRequestService {
    private static let baseURL = "http://127.0.0.1:5000"
    func requestHardcodeLayout(
        closure: @escaping (Result<TDCBaseViewDTO, TDCNetworkError>) -> Void
    ) {
        typealias ResultType = Result<TDCBaseViewDTO, TDCNetworkError>
        let request = AF.request("http://127.0.0.1:5000/main_view")
        request.responseDecodable(of: TDCBaseViewDTO.self) { (response) in
            switch response.result {
            case .success(let data):
                closure(.success(data))
            case .failure:
                closure(.failure(.unknown))
            }
        }
    }
}

extension LayoutRequestService {
    func requestPage(
        pageURI: String,
        closure: @escaping (Result<TDCViewDTO, TDCNetworkError>) -> Void
    ) {
        typealias ResultType = Result<TDCViewDTO, TDCNetworkError>
        let request = AF.request("\(LayoutRequestService.baseURL)\(pageURI)")
        request.responseDecodable(of: TDCViewDTO.self) { (response) in
            switch response.result {
            case .success(let data):
                closure(.success(data))
            case .failure(let error):
                debugPrint(error)
                closure(.failure(.unknown))
            }
        }
    }
}
