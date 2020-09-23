
import Foundation
struct WebItems: Decodable {
    let title: String
    let rows: [RowData]
}

struct RowData: Decodable {
    let title, rowDescription: String?
    let imageHref: String?

    enum CodingKeys: String, CodingKey {
        case title
        case rowDescription = "description"
        case imageHref
    }
}
