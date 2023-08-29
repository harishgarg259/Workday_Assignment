//
//  ViewController.swift
//  Workday
//
//  Created by Harish Garg on 26/08/23.
//

import UIKit

class ImageListingViewController: UIViewController {

    //MARK: IBoutlets
    @IBOutlet weak var searchTextField: SearchTextField!
    @IBOutlet weak var searchedImagesTableView: UITableView!
    @IBOutlet weak var noRecordView: UIView!
    
    //MARK: Variables
    let viewModel = SearchImageViewModel()
    
    //MARK: Class Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: Private Default Methods
extension ImageListingViewController {
    
    private func setupUI() {
        setupNavigationBar()
        configureTableView()
    }
    
    private func setupNavigationBar() {
       
        //Set title
        self.title = "Search Images"
        
        //Set media type Search
        self.viewModel.mediaType = .Video

        //Search field callback
        searchTextField.userStoppedTypingHandler = { [weak self] in
            if let criteria = self?.searchTextField.text {
                if criteria.isEmpty || criteria.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    self?.viewModel.records?.removeAll()
                    self?.reloadTable()
                } else if criteria.count > AppConstants.searchCharacterLimit {
                    // Show loading indicator
                    self?.searchTextField.showLoadingIndicator()
                    self?.searchRecords(searchString: criteria)
                }
            }
        } as (() -> Void)
    }
    
    private func configureTableView() {
        searchedImagesTableView.registerCell(ImageDetailCell.self)
    }
    
    private func reloadTable(){
        self.searchedImagesTableView.reloadData()
    }
}

//MARK: Apis Call
extension ImageListingViewController
{
    private func searchRecords(searchString:String)
    {
        self.viewModel.searchImages(searchString: searchString)
        self.viewModel.searchImagesResponse = { (images,success,error) in
            DispatchQueue.main.async {
                self.searchTextField.stopLoadingIndicator()
                if success {
                    guard let records = images else {
                        return
                    }
                    self.viewModel.records = records
                    self.noRecordView.isHidden = !(self.viewModel.records?.isEmpty ?? false)
                    self.reloadTable()
                }
            }
        }
    }
}
