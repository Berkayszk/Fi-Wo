//
//  HomeViewController.swift
//  Fi Wo
//
//  Created by Berkay Sazak on 19.11.2023.
//

import UIKit


enum Sections : Int {
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let sectionTitles : [String] = ["Trending Movies","Popular","Trending Tv","Upcoming Movies","Top Rated"]
    
    private let homeFeedTables : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(homeFeedTables)
        configureNavBar()
        homeFeedTables.dataSource = self
        homeFeedTables.delegate = self
        
        let headerview = HeroHeaderUIView(frame: CGRect(x:0, y:0, width: view.bounds.width, height : 450))
        homeFeedTables.tableHeaderView = headerview
        

    }
    private func configureNavBar() {
        var image = UIImage(named: "fiwoLogo")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTables.frame = view.bounds
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue:
            
            APICaller.shared.getTrendingMovies { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.TrendingTv.rawValue:
            
            APICaller.shared.getTredingtvs { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.Popular.rawValue:
            
            APICaller.shared.getPopular { result in
                switch result {
                case.success(let titles):
                    cell.configure(with: titles)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.Upcoming.rawValue:
            
            APICaller.shared.getUpComingMovies { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.TopRated.rawValue:
            
            APICaller.shared.getTopRated { result in
                switch result {
                case.success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        default:
            return UITableViewCell()
        }
      
        return cell
                
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
    

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defoultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defoultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    

     

}

extension HomeViewController : CollectionViewTableViewCellDelegate {
    
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel) {
        
        DispatchQueue.main.async { [weak self] in
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }

    }
    
}
