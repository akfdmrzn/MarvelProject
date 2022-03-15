//
//  CharacterDetailViewController.swift
//  MovieBox
//
//  Created by Akif Demirezen on 29.10.2019.
//  Copyright © 2019 akifdemirezen. All rights reserved.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
    let indicatorView = IndicatorView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
    
    @IBOutlet private weak var tableView: UITableView!

    var viewModel: CharacterDetailViewModelProtocol! {
        didSet {
            
        }
    }
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDesc: UILabel!
    @IBOutlet weak var imageViewCharacter: UIImageView!
    
    convenience init(viewModel: CharacterDetailViewModelProtocol) {
        self.init()
        self.viewModel = viewModel
        self.viewModel.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        viewModel.loadComics()
        reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func closePage(_ sender: Any) {
        viewModel.dismiss()
    }
        
    func prepareUI() {
        self.labelName.text = viewModel.getCharacterDetail().name
        self.labelDesc.text = viewModel.getCharacterDetail().description
        self.imageViewCharacter.setImage(with: "\(viewModel.getCharacterDetail().thumbnail?.path ?? "")\(AppConstants.ImagesExtend.portRaitUncanny)")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50.0
        tableView.register(cell: CharacterDetailCell.self)
    }
    
    func reloadData() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
}

extension CharacterDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getComicList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterDetailCell.identifier, for: indexPath) as! CharacterDetailCell
        cell.setup(with: viewModel.getComicList()[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension CharacterDetailViewController: CharacterDetailViewModelDelegate {
    
    func handleViewModelOutput(_ output: CharacterDetailViewModelOutput) {
        switch output {
        case .updateTitle(let title):
            self.title = title
        case .setLoading(let isLoading):
            DispatchQueue.main.async {
                if isLoading {
                    self.view.addSubview(self.indicatorView)
                    self.indicatorView.viewAnimate.play { finished in
                        
                    }
                }
                else{
                    self.indicatorView.removeFromSuperview()
                }
            }
        case .reloadComicList:
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.reloadData()
            }
        }
    }
    
}
