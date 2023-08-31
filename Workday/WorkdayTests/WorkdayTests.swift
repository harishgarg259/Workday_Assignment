//
//  WorkdayTests.swift
//  WorkdayTests
//
//  Created by Harish Garg on 26/08/23.
//

import XCTest
@testable import Workday

final class WorkdayTests: XCTestCase {
    
    func test_searchApiResponse_with_valid_searchQuery(){
        
        //Arrange
        let rest = RestManager<SearchNasaImageBase>()
        let parameters = ["page":"\(1)","page_size": AppConstants.limitPerPage,"q":"apollo","media_type":"image"]
        let expectation = self.expectation(description: "valid_searchQuery")
        
        rest.makeRequest(request : WebAPI().createNasaRequest(params : parameters, type: .searchImages)!) { (result) in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
                XCTAssertEqual(response.collection?.items?[safe: 0]?.data?[safe: 0]?.title, "Sample Movie")
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10.0)
        
    }
    
    func test_searchApiResponse_with_wrong_searchQuery(){
        
        //Arrange
        let rest = RestManager<SearchNasaImageBase>()
        let parameters = ["page":"\(500)","page_size": AppConstants.limitPerPage,"query":"apollo","media_type":""]
        let expectation = self.expectation(description: "invalid_searchQuery")
        rest.makeRequest(request : WebAPI().createNasaRequest(params : parameters, type: .searchImages)!) { (result) in
                        
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssertEqual(error.description, "Maximum number of search results have been displayed. Please refine your search.")
            }
            
            expectation.fulfill()

        }
        waitForExpectations(timeout: 10.0)
        
    }

}
