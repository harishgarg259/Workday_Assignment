import Foundation

struct SearchNasaImageBase : Codable {
	let collection : Collection?

	enum CodingKeys: String, CodingKey {

		case collection = "collection"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		collection = try values.decodeIfPresent(Collection.self, forKey: .collection)
	}

}

struct Collection : Codable {
    let version : String?
    let href : String?
    let items : [Items]?
    let metadata : Metadata?
    let links : [Links]?
}

struct Items : Codable {
    let href : String?
    let data : [Details]?
    let links : [Links]?
}

struct Metadata : Codable {
    let total_hits : Int?
}

struct Details : Codable {
    let center : String?
    let title : String?
    let keywordswords : [String]?
    let nasa_id : String?
    let date_created : String?
    let media_type : String?
    let description : String?
}

struct Links : Codable {
    let rel : String?
    let prompt : String?
    let href : String?
}
