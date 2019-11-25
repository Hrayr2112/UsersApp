//
//  RequestService.swift
//  UsersApp
//
//  Created by Hrayr Yeghiazaryan on 19.11.2019.
//  Copyright © 2019 Hrayr Yeghiazaryan. All rights reserved.
//

import Alamofire

protocol APIActionProtocol: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var actionParameters: [String: Any] { get }
    var baseURL: String { get }
    var authHeader: [String: String] { get }
    var encoding: ParameterEncoding { get }
}

extension APIActionProtocol {
    func asURLRequest() throws -> URLRequest {
        let originalRequest = try URLRequest(url: baseURL.appending(path),
                                             method: method,
                                             headers: authHeader)
        let encodedRequest = try encoding.encode(originalRequest,
                                                 with: actionParameters)
        return encodedRequest
    }
}

open class Resource<T> {
  let request: APIAction
  let parse: (Any) -> Result<T>
  
  init(request: APIAction, parse: @escaping (Any) -> Result<T>) {
    self.request = request
    self.parse = parse
  }
}

public enum Result<Value> {
    case success(Value)
    case failure(Error)
}

protocol APIClientProtocol {
  func request<T>(_ resource: Resource<T>, completion: @escaping (Result<T>) -> Void)
}

struct APIClient: APIClientProtocol {
  func request<T>(_ resource: Resource<T>, completion: @escaping (Result<T>) -> Void) {
    Alamofire
      .request(resource.request)
      .responseData { (dataResponse) in
        completion(dataResponse.result.flatMap2(resource.parse))
    }
  }
}

protocol APIAction: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var actionParameters: [String: Any] { get }
    var baseURL: String { get }
    var authHeader: [String: String] { get }
    var encoding: ParameterEncoding { get }
}

extension APIAction {
    func asURLRequest() throws -> URLRequest {
        let originalRequest = try URLRequest(url: baseURL.appending(path),
                                             method: method,
                                             headers: authHeader)
        let encodedRequest = try encoding.encode(originalRequest,
                                                 with: actionParameters)
        return encodedRequest
    }
}

class UsersResource: Resource<[User]> {
    
    init() {
        super.init(request: UserAction.getUsers) { response -> Result<[User]> in
            if let data = response as? Data {
                do {
                    let decodedUsers = try JSONDecoder().decode(Array<User>.self, from: data)
                    return Result.success(decodedUsers)
                } catch {
                    return Result.failure(CustomError(value: error.localizedDescription))
                }
            }
            return Result.failure(CustomError(value: "No data"))
        }
        
    }
}

struct CustomError: LocalizedError {
  let value: String
  var localizedDescription: String {
    return value
  }
}

struct ApiService {
  
  private let api: APIClientProtocol = APIClient()
  
  func getUsers(_ completion: @escaping (Result<[User]>) -> Void) {
    api.request(UsersResource(), completion: completion)
  }
}
