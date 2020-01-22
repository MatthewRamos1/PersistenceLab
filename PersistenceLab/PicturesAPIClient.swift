//
//  PicturesAPIClient.swift
//  PersistenceLab
//
//  Created by Matthew Ramos on 1/21/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import Foundation
import NetworkHelper

struct PicturesAPIClient {
    static func fetchPictures (completion: @escaping (Result<[Picture], AppError>) -> ()) {
        let endPointURL = "https://pixabay.com/api/?key=14980906-543f47e356fbfc99d3efe2dfe&q="
        guard let url = URL(string: endPointURL) else {
            completion(.failure(.badURL(endPointURL)))
            return
        }
        let request = URLRequest(url: url)
                NetworkHelper.shared.performDataTask(with: request) { (result) in
                    switch result {
                    case .failure(let appError):
                        completion(.failure(.networkClientError(appError)))
                    case .success(let data):
                        do {
                            let results = try JSONDecoder().decode([Picture].self, from: data)
                            completion(.success(results))
                        } catch {
                            completion(.failure(.decodingError(error)))
                        }
                    }
                }
            }
        }
