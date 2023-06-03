//
//  PillListVC.swift
//  Pill-osophy
//
//  Created by saint on 2023/05/30.
//

import UIKit

import SnapKit
import Then

class PillListVC: UIViewController {
    
    private let appIcon = UIImageView().then{
        $0.image = UIImage(named: "appname")
        $0.backgroundColor = .clear
    }
    
    private lazy var baseTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    let searchBar = UISearchBar().then {
        $0.placeholder = "Search"
    }
    
    var pillList: [PillModel] = [
        PillModel(albumImage: "1", title: "아로나민골드", singer: "혼합비타민제", num: 0),
        PillModel(albumImage: "2", title: "게보린", singer: "해열.진통.소염제", num: 0),
        PillModel(albumImage: "3", title: "우루사", singer: "간장질환용제", num: 0),
        PillModel(albumImage: "4", title: "타이레놀", singer: "해열.진통.소염제", num: 0),
        PillModel(albumImage: "5", title: "머시론", singer: "피임제", num: 0),
        PillModel(albumImage: "6", title: "인후신", singer: "해열.진통.소염제", num: 0),
        PillModel(albumImage: "7", title: "아세트아미노펜", singer: "해열.진통.소염제", num: 0),
        PillModel(albumImage: "8", title: "이가탄", singer: "치과구강용약", num: 0),
        PillModel(albumImage: "9", title: "지르텍", singer: "항히스타민제", num: 0),
        PillModel(albumImage: "10", title: "인사돌플러스", singer: "치과구강용약", num: 0),
        PillModel(albumImage: "11", title: "임팩타민", singer: "비타민 B제", num: 0),
        PillModel(albumImage: "12", title: "멜리안", singer: "피임제", num: 0),
        PillModel(albumImage: "13", title: "액티리버모닝", singer: "간장질환용제", num: 0),
        PillModel(albumImage: "14", title: "둘코락스에스", singer: "하제, 완장제", num: 0),
        PillModel(albumImage: "15", title: "판시딜", singer: "단백아미노산제제", num: 0),
        PillModel(albumImage: "16", title: "센시아", singer: "기타의 조직세포의 기능용의약품", num: 0),
        PillModel(albumImage: "17", title: "모드콜에스", singer: "해열.진통.소염제", num: 0),
        PillModel(albumImage: "18", title: "이지엔6이브", singer: "해열.진통.소염제", num: 0),
        PillModel(albumImage: "19", title: "벤포벨", singer: "기타의 비타민제", num: 0),
        PillModel(albumImage: "20", title: "동성정로환", singer: "정장제", num: 0),
        PillModel(albumImage: "21", title: "카베진코와", singer: "건위소화제", num: 0)
    ]
    var filterdata: [PillModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        filterdata = pillList
        baseTableView.delegate = self
        baseTableView.dataSource = self
        searchBar.delegate = self
        registerTV()
        setLayout()
        // Do any additional setup after loading the view.
    }
    
    private func registerTV() {
        baseTableView.register(PillListTVC.self,
                               forCellReuseIdentifier: PillListTVC.className
        )
    }
}

extension PillListVC{
    private func setLayout() {
        view.backgroundColor = .white
        view.addSubviews([appIcon, searchBar, baseTableView])
        
        appIcon.snp.makeConstraints{
            $0.top.equalToSuperview().offset(60)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(157)
            $0.height.equalTo(50)
        }
        
        searchBar.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(100)
        }
        
        baseTableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(70 * pillList.count)
        }
    }
}

extension PillListVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let pillCell = tableView.dequeueReusableCell(
            withIdentifier: PillListTVC.className, for: indexPath)
                as? PillListTVC else { return UITableViewCell() }
        
        pillCell.dataBind(model: filterdata[indexPath.row])
        return pillCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension PillListVC: UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterdata = []
        if searchText == ""
        {
            filterdata = pillList
        }
        
        for pill in pillList{
                if pill.title.uppercased().contains(searchText.uppercased())
                {
                    filterdata.append(pill)
                }
        }
       
        self.baseTableView.reloadData()
    }
}
