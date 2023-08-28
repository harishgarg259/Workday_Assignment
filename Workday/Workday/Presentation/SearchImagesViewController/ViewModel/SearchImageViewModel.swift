//
//  SearchImageViewModel.swift
//  Workday
//
//  Created by Harish Garg on 27/08/23.
//

import Foundation

enum Media: String{
    case Image = "image"
    case Video = "video"
    case Audio = "audio"
}


class SearchImageViewModel{
    var mediaType: Media = .Image
    var searchImagesResponse: (([Items]?,Bool,String) -> Void)?
}


// MARK: Apis Call
extension SearchImageViewModel
{
    
    //Search Players call
    func searchImages(searchString: String) {
        let parameters = ["page":"1","page_size":AppConstants.limitPerPage,"q":searchString,"media_type":mediaType.rawValue]
        let rest = RestManager<SearchNasaImageBase>()
        rest.makeRequest(request : WebAPI().createNasaRequest(params : parameters, type: .searchImages)!) { [weak self] (result) in
            switch result {
            case .success(let response):
                debugPrint(response)
                self?.searchImagesResponse?(response.collection?.items,true,"")
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self?.searchImagesResponse?(nil,false,error.localizedDescription)
            }
        }
    }
}
