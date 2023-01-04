//
//  TogetherVC.swift
//  HARA
//
//  Created by 김담인 on 2022/12/27.
//

import UIKit
import SnapKit
import Then

final class TogetherVC: UIViewController {
    
    // MARK: - Properties
    private let togetherNaviView = DefaultNavigationView()
    
    private let categoryCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.contentInset = UIEdgeInsets.zero
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.collectionViewLayout = layout
    }
    
    private let categoryTitles = ["전체", "일상", "연애", "패션/뷰티", "커리어", "운동", "여행", "기타"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setCategoryCV()
        registerCell()
        setLayout()
        categoryCV.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .right)
    }
    
    // MARK: - Function
    private func setCategoryCV() {
        categoryCV.dataSource = self
        categoryCV.delegate = self
    }
    
    private func registerCell() {
        categoryCV.register(cell: CategoryCVC.self, forCellWithReuseIdentifier: CategoryCVC.className)
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension TogetherVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizingCell = CategoryCVC()
        sizingCell.setData(data: categoryTitles[indexPath.row])
        sizingCell.categoryLabel.sizeToFit()
        
        let cellWidth = sizingCell.categoryLabel.frame.width + 24
        let cellHeight = CGFloat(31)
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

extension TogetherVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCVC.className, for: indexPath) as! CategoryCVC
        cell.setData(data: categoryTitles[indexPath.row])
        if indexPath.row != 0 {
            cell.contentView.layer.borderColor = UIColor.hBlue2.cgColor
            cell.contentView.layer.borderWidth = 1
        }
        return cell
    }
    
}

// MARK: - Layout
extension TogetherVC {
    private func setLayout() {
        self.view.addSubviews([togetherNaviView, categoryCV])
        
        togetherNaviView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        categoryCV.snp.makeConstraints {
            $0.top.equalTo(togetherNaviView.snp.bottom).offset(47)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(31)
        }
        
    }
    
}
