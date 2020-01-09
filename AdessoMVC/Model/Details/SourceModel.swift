//
//  SourceModel.swift
//  AdessoMVC
//
//  Created by Abdülbaki Kaplan on 1/9/20.
//  Copyright © 2020 Abdülbaki Kaplan. All rights reserved.
//

import Foundation

struct SourceModel: Equatable {
    let id:Bool?
    let name: String?
}

extension SourceModel: Decodable {
    enum SourceCodingKeys:String, CodingKey {
        case id = "id"
        case name = "name"
    }

    init(from decoder : Decoder) throws {
        let container = try decoder.container(keyedBy: SourceCodingKeys.self)

        id = try? container.decode(Bool.self, forKey: .id)
        name = try? container.decode(String.self, forKey: .name)
    }
}
