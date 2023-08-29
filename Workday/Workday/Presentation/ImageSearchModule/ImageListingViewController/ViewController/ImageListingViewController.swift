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
    private let refreshControl = UIRefreshControl()
    
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
        setupRefreshControl()
    }
    
    private func setupNavigationBar() {
       
        //Set title
        self.title = "Search Images"
        
        //Set media type Search
        self.viewModel.mediaType = .Video

        //Search field callback
        searchTextField.userStoppedTypingHandler = { [weak self] in
            if self?.searchTextField.hasText() ?? false {
                // Fetch record from API
                self?.searchTextField.showLoadingIndicator()
                self?.searchRecords(searchString: self?.searchTextField.text ?? "")
            }else{
                self?.viewModel.records?.removeAll()
                self?.reloadTable()
            }
        } as (() -> Void)
    }
    
    private func configureTableView() {
        searchedImagesTableView.registerCell(ImageDetailCell.self)
    }
    
    private func reloadTable(){
        self.noRecordView.isHidden = (self.searchTextField.text?.isEmpty ?? true) ? true : !(self.viewModel.records?.isEmpty ?? false)
        self.refreshControl.endRefreshing()
        self.searchedImagesTableView.reloadData()
        self.searchTextField.stopLoadingIndicator()
    }
    
    private func setupRefreshControl(){
        refreshControl.addTarget(self, action: #selector(refreshSearchData), for: .valueChanged)
        self.searchedImagesTableView.refreshControl = refreshControl
    }
    
    @objc func refreshSearchData(refreshControl: UIRefreshControl) {
        if self.searchTextField.hasText() {
            searchRecords(searchString: self.searchTextField.text ?? "")
        }else{
            self.refreshControl.endRefreshing()
        }
    }
    
}

//MARK: Apis Call
extension ImageListingViewController
{
    private func searchRecords(searchString:String)
    {
        self.viewModel.searchImages(searchString: searchString)
        self.viewModel.searchImagesResponse = { [weak self](images,success,error) in
            DispatchQueue.main.async {
                
                //Error Handling
                if success {
                    guard let records = images else {
                        return
                    }
                    self?.viewModel.records = records
                }else{
                    self?.showAlert(withMessage: error)
                }
                
                self?.reloadTable()
            }
        }
    }
}
