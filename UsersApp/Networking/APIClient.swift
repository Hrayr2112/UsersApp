//
//  APIClient.swift
//  UsersApp
//
//  Created by Hrayr Yeghiazaryan on 30.11.2019.
//  Copyright © 2019 Hrayr Yeghiazaryan. All rights reserved.
//

import Alamofire

protocol APIClientProtocol {
    func request<T>(_ resource: Resource<T>) async throws -> Data
}

struct APIClient: APIClientProtocol {
    func request<T>(_ resource: Resource<T>) async throws -> Data {
        
        try await withUnsafeThrowingContinuation { continuation in
            Alamofire.request(resource.request).validate().responseData { response in
                if let data = response.data {
                    continuation.resume(returning: data)
                    return
                }
                if let err = response.error {
                    continuation.resume(throwing: err)
                    return
                }
                fatalError("should not get here")
            }
        }
    }
}
