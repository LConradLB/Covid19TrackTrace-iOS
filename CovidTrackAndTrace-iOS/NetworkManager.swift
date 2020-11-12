//
//  NetworkManager.swift
//  CovidTrackAndTrace-iOS
//
//  Created by Lewis Luther-Braun on 06/11/2020.
//

import Foundation

class NetworkManager {
    
    static var shared = NetworkManager()
    let baseURL = "https://covid19-middleware.herokuapp.com"
    
    func validateTestCode(code: String, completion: @escaping (Bool?, Error?)->()) {
        
        let input = code.replacingOccurrences(of: " ", with: "")
        let url = URL(string: "\(baseURL)/api/verifyPositiveTest/\(input)")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Error: invalid HTTP response code")
                let error = NSError(domain:"Error: invalid HTTP response code", code:500, userInfo:nil)
                
                completion(nil, error)
                return
            }
            guard let data = data else {
                print("Error: missing response data")
                let error = NSError(domain:"Error: missing response data", code:500, userInfo:nil)
                completion(nil, error)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(TestResultValidation.self, from: data)
                guard result.response == .success else { return }
                completion(result.isValidResult, nil)
            }
            catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    func uploadPersonalTokens(tokens: [String]) {
        
        let Url = String(format: "\(baseURL)/api/infectedTokens")
        guard let serviceUrl = URL(string: Url) else { return }
        let parameters: [String: Any] = [
            "infectedTokens": tokens
        ]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            return
        }
        request.httpBody = httpBody
        request.timeoutInterval = 20
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func getListOfInfectedTokens(completion: @escaping ([String]) -> () ) {
        let url = URL(string: "\(baseURL)/api/infectedTokens")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                fatalError("Error: invalid HTTP response code")
            }
            guard let data = data else {
                fatalError("Error: missing response data")
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(InfectedTokensResponse.self, from: data)
                completion(result.infectedTokens)
            }
            catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}

struct TestResultValidation: Codable {
    let isValidResult: Bool
    let response: ResponseType
}

public enum ResponseType: String, Codable {
    case success
    case error
}

struct InfectedTokensResponse: Codable {
    let infectedTokens: [String]
}
