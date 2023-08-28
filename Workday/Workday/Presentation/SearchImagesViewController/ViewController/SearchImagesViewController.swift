//
//  ViewController.swift
//  Workday
//
//  Created by Harish Garg on 26/08/23.
//

import UIKit

class SearchImagesViewController: UIViewController {

    //MARK: IBoutlets
    @IBOutlet weak var searchTextField: SearchTextField!
    @IBOutlet weak var searchedImagesTableView: UITableView!
    @IBOutlet weak var noRecordView: UIView!
    
    //MARK: Variables
    var viewModel = SearchImageViewModel()
    var records: [Items]?
    
    //MARK: Class Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: Private Default Methods
extension SearchImagesViewController {
    
    private func setupUI() {
        setupNavigationBar()
        configureTableView()
    }
    
    func setupNavigationBar() {
       
        self.title = "Search Images"

        searchTextField.userStoppedTypingHandler = {
            if let criteria = self.searchTextField.text {
                if criteria.isEmpty || criteria.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    self.records?.removeAll()
                    self.reloadTable()
                } else if criteria.count > AppConstants.searchCharacterLimit {
                    // Show loading indicator
                    self.searchTextField.showLoadingIndicator()
                    self.searchRecords(searchString: criteria)
                }
            }
        } as (() -> Void)
    }
    
    func configureTableView() {
        searchedImagesTableView.registerCell(ImageDetailCell.self)
    }
    
    func reloadTable(){
        self.searchedImagesTableView.reloadData()
    }
}

//MARK: Apis Call
extension SearchImagesViewController
{
    func searchRecords(searchString:String)
    {
        self.viewModel.searchImages(searchString: searchString)
        self.viewModel.searchImagesResponse = { (images,success,error) in
            DispatchQueue.main.async {
                self.searchTextField.stopLoadingIndicator()
                if success {
                    guard let records = images else {
                        return
                    }
                    self.records = records
                    self.noRecordView.isHidden = !(self.records?.isEmpty ?? false)
                    self.reloadTable()
                }
            }
        }
    }
}
