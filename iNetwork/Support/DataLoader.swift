//
//  DataLoader.swift
//  iNetwork
//
//  Created by Nowroz Islam on 24/6/24.
//

import Foundation

struct DataLoader {
    private init() { }
    
    static func load<T: Decodable>(from endpoint: String) async -> T {
        let data = await fetchSerializedData(from: endpoint)
        let content: T = decodeData(data)
        return content
    }
    
    static func decodeData<T: Decodable>(_ data: Data) -> T {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Decoding error. Found null, expected \(type) - \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(let context) {
            fatalError("Decoding error. Invalid JSON file - \(context)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Decoding error. Type mismatch - \(context))")
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Decoding error. Missing \(key.stringValue) - \(context)")
        } catch {
            fatalError("Failed to decode data - \(error.localizedDescription)")
        }
    }
    
    static func fetchSerializedData(from endpoint: String) async -> Data {
        print("fetching data...")
        guard let url = URL(string: endpoint) else {
            fatalError("Invalid URL")
        }
        
        guard let (data, response) = try? await URLSession.shared.data(from: url) else {
            fatalError("Failed to fetch data from the internet")
        }
        
        guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
            fatalError("Invalid response")
        }
        
        return data
    }
}
