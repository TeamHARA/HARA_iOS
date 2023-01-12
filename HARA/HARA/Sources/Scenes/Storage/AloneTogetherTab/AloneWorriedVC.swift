//
//  WorriedAloneVC.swift
//  HARA
//
//  Created by 누리링 on 2023/01/06.
//

import UIKit
import SnapKit
import Then
import Moya

class AloneWorriedVC: UIViewController {

    // MARK: - Properties
    private let worriedAllButton = UIButton().then {
        $0.setImage(UIImage(named: "storage_ing_all"), for: .normal)
        $0.setImage(UIImage(named: "storage_complete_all"), for: .selected)
    }
    private let editButton = UIButton().then {
        $0.setTitle("편집", for: .normal)
        $0.setTitleColor(.hBlack, for: .normal)
        $0.titleLabel?.font = .haraB2M14
        $0.setTitle("완료", for: .selected)
    }
    
    private let clickButton = UIButton().then {
        $0.setImage(UIImage(named: "storage_check_off"), for: .normal)
    }
    
    var isWorring: Bool?
    private lazy var aloneCollectionView : UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isEditing = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.allowsFocusDuringEditing = true
        collectionView.allowsMultipleSelection = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset.bottom = 60
        return collectionView
    }()
    
    final let aloneLineSpacing: CGFloat = 10
    var aloneData: [StorageResponse] = []
    
    let categoryList: [String] = ["전체", "일상", "연애", "패션/뷰티", "커리어", "운동", "여행", "기타"]
    
///    var aloneList: [WorriedModel] = [
///        WorriedModel(worring: "storage_ing", categoryTitle: "일상", mainText: "난 이제 지쳤어요 땡벌", date: "2022.12.25"),
///    ]
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        registerCVC()
        setPress()
        isWorring = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isWorring == true {
            self.getAloneWorry(ifSolved: 0)
        } else {
            self.getAloneWorry(ifSolved: 1)
        }
    }
    
    // MARK: - Functions
    private func setPress() {
        worriedAllButton.press {
            self.isWorring?.toggle()
            if self.isWorring == true {
                self.worriedAllButton.setImage(UIImage(named: "storage_ing_all"), for: .normal)
                self.getAloneWorry(ifSolved: 0)
            }else{
                self.worriedAllButton.setImage(UIImage(named: "storage_complete_all"), for: .normal)
                self.getAloneWorry(ifSolved: 1)
            }
        }
        editButton.press {
            self.editButton.isSelected.toggle()
        }
    }
    /// 수직 스크롤이라는 가정 하에, rowCount는 몇개의 행을 사용할지를 저장한 변수
    private func registerCVC() {
        aloneCollectionView.register(
            AloneWorriedCVC.self, forCellWithReuseIdentifier: AloneWorriedCVC.className)
    }
}


// MARK: - UICollectionViewDelegateFlowLayout
extension AloneWorriedVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 343.adjustedW, height: 100.adjustedH)
    }
}

// MARK: - UICollectionViewDataSource
extension AloneWorriedVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return aloneData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let aloneCell = collectionView.dequeueReusableCell(withReuseIdentifier: AloneWorriedCVC.className, for: indexPath) as? AloneWorriedCVC else { return UICollectionViewCell() }
        aloneCell.dataBind(model: aloneData[indexPath.row])
        return aloneCell
    }
}

extension AloneWorriedVC {
    
    // MARK: - Layout
    private func setLayout() {
        view.backgroundColor = .clear
        view.addSubViews([aloneCollectionView, worriedAllButton, editButton])
        
        worriedAllButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10.adjustedH)
            $0.leading.equalToSuperview().offset(16.adjustedW)
            $0.width.equalTo(77.adjustedW)
            $0.height.equalTo(24.adjustedH)
        }
        
        editButton.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16.adjustedW)
            $0.width.equalTo(27.adjustedW)
            $0.height.equalTo(44.adjustedH)
        }
        
        aloneCollectionView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(44.adjustedH)
            $0.leading.equalToSuperview().offset(16.adjustedW)
            $0.trailing.equalToSuperview().inset(16.adjustedW)
            $0.bottom.equalToSuperview()
        }
    }
}

// MARK: - Network
extension AloneWorriedVC {
    func getAloneWorry(ifSolved: Int) {
        StorageAPI.shared.getStorageAloneList(param123: ifSolved) { [weak self] result in
            guard let res = result else {return}
            let count = (res.data?.count)!
            ///구조체로 들어오는 데이터 모델을 dataModel에 입력
            ///aloneList 역할을 대신 함, 서버 받으면 바로바로 셀에 띄워줄 준비 완료
            guard let dataModel = res.data else {return}
            self?.aloneData = dataModel
            self?.aloneCollectionView.reloadData()
        }
    }
}
