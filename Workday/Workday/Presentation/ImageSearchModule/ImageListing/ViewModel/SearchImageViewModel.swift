//
//  SearchImageViewModel.swift
//  Workday
//
//  Created by Harish Garg on 27/08/23.
//

import Foundation

enum Media: String{
    case Image
    case Video
    case Audio
    
    var media: String {
        get {
            switch self {
            case .Image:
                return "image"
            case .Video:
                return "video"
            case .Audio:
                return "audio"
            }
        }
    }
}


class SearchImageViewModel{
    
    //MARK: Variables
    var mediaType: Media = .Image
    var records = [Items]()
    
    
    // MARK: Apis Call
    func searchImages(searchString: String, page: Int, completion: ((Bool,String) -> Void)?) {
        let parameters = ["page":"\(page)","page_size": AppConstants.limitPerPage,"q":searchString,"media_type":mediaType.media]
        let rest = RestManager<SearchNasaImageBase>()
        rest.makeRequest(request : WebAPI().createNasaRequest(params : parameters, type: .searchImages)!) { (result) in
            switch result {
            case .success(let response):
                debugPrint(response)
                //Check if it a fresh request then remove old records from the array
                if page == 1{
                    self.records.removeAll()
                }
                self.records.append(contentsOf: response.collection?.items ?? [])
                completion?(true,"")
            case .failure(let error):
                debugPrint(error.localizedDescription)
                completion?(false,error.localizedDescription)
            }
        }
    }
}
