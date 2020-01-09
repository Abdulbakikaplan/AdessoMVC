//
//  News.swift
//  AdessoMVC
//
//  Created by Abdülbaki Kaplan on 1/9/20.
//  Copyright © 2020 Abdülbaki Kaplan. All rights reserved.
//

import Foundation

struct News {

    let status : String?
    let sources : [SourcesModel]
}

extension News : Decodable {

    enum  NewsCodingKeys : String, CodingKey {
        case status = "status"
        case sources = "sources"
}

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: NewsCodingKeys.self)

        status = try? container.decode(String.self, forKey: .status)
        sources = try! container.decode([SourcesModel].self, forKey: .sources)
    }

}
