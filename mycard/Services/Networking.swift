//
//  Networking.swift
//  mycard
//
//  Created by Joseph Maclean Arhin on 2/4/21.
//

import Foundation

import UIKit

/// Result enum is a generic for any type of value
/// with success and failure case
public enum Result<T> {
    case success(T)
    case failure(Error)
}

final class Networking: NSObject {

    // MARK: - Private functions
    private static func getData(url: URL,
                                completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    // MARK: - Public function

    /// downloadImage function will download the thumbnail images
    /// returns Result<Data> as completion handler
    public static func downloadImage(url: URL,
                                     completion: @escaping (Result<Data>) -> Void) {
        Networking.getData(url: url) { data, _, error in

            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data, error == nil else {
                return
            }

            DispatchQueue.main.async {
                completion(.success(data))
            }
        }
    }
}
