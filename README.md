# HARA
> 많은 정보와 선택지 속에서 내가 진짜 원하는 것은 무엇인지 발견하고, 스스로의 힘을 믿어주기 위해 고민 결정을 돕는 서비스 해라.


# 👨‍👧‍👧 팀원 소개
| <img width="321" alt="Screen Shot 2023-01-04 at 1 41 19 PM" src="https://user-images.githubusercontent.com/32871014/210506646-f4871397-959d-4fea-8bbf-6f88a40acefa.png"> | <img width="369" alt="Screen Shot 2023-01-04 at 1 41 49 PM" src="https://user-images.githubusercontent.com/32871014/210506658-4c3b7704-6fea-4646-b6c4-0c78935d4de8.png"> | <img width="298" alt="Screen Shot 2023-01-04 at 1 41 35 PM" src="https://user-images.githubusercontent.com/32871014/210506682-3538a9b1-ecc7-45d2-b160-c27a4fab7faa.png"> |
| :---------------------------------------------------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------------------------------------------: |
|                                         [daminoworld](https://github.com/daminoworld)                                         |                                          [oy6uns](https://github.com/oy6uns)                                    |                                         [loveitall](https://github.com/loveitall)                                      |
|                                         30기, 31기 아요 하고 있는 감자입니다..리드...쉽지 않아요 그렇지만 우리 해라와 함께 해라~ 잘 해라~~|                                          즐기고 싶지만 마음처럼 쉽게 되지 않는,,,,그래도 해라 아요미들과 함께라면,,,,행보케,,,,💞                                   |                                         계절학기 이슈로,,,바쁜 하루를 살 예정이지만그래도~! 앱잼은 열심히 참여해보겠습니다~!!                                      |


# 👁‍🗨 Library

|                     라이브러리                      |                   용도                    |
| :-------------------------------------------------: | :---------------------------------------: |
|    [SnapKit](https://github.com/SnapKit/SnapKit)    |      간편한 코드 베이스 레이아웃을 위해 사용      |
|       [Then](https://github.com/devxoul/Then)       | 인스턴스 초기화를 간편하게 하기 위해 사용 |
| [Moya](https://github.com/Moya/Moya) |           간결한 네트워크 레이어 구성 위해 사용            |



# 🖥 Code Convention
> [해라 아요의 전체 Code Convention을 보고 싶다면?!](https://daffy-lawyer-1b8.notion.site/code-convention-8a38d2bdc984401da6659ccd026ba771)

## MARK
```
// MARK: - Protocols 웬만하면 파일로 빼자.
// MARK: - Properties 변수 선언
// MARK: - Initialization init()쓸때 
// MARK: - View Life Cycle 
// MARK: - Functions
// MARK: - Delegate, Datasource 등 각각 명시
// MARK: - Layout 
// MARK: - Network
```
## 네이밍
- 약어는 항상 `대문자`로 표기합니다. (id 제외)
- 약어 사용 범위
    
    ```
    TableView -> TV
    TableViewCell -> TVC
    CollectionView -> CV
    CollectionViewCell -> CVC
    ViewController -> VC
    identifier -> id
    ```
    
- 약어 사용 범위 외의 것들은 모두 full name으로 표기합니다.
    
    ```swift
    ex) tabBarController -> 그대로
    ```

# 🌀 Git Flow
> [해라 아요의 전체 Git Convention을 보고 싶다면?!](https://daffy-lawyer-1b8.notion.site/Git-Convention-3ddd6578da6e48df90b0dbc6a25f3313)
 
## 작업 순서
```
1. Issue 생성
2. Branch 생성
3. 작업, commit
4. push
5. PR 작성
6. 코드 리뷰 (24시간 이내)
7. 두 명(권장), 한 명(최소) Approve 받았을 경우 셀프 merge
8. Delete Branch
```
## Commit Convention
```
[작업] #이슈번호-커밋제목

[Chore] #1-그냥 보통 잡일
[Feat] #1-새로운 주요 기능 추가
[Add] #2-파일 추가, 에셋 추가, etc
[Fix] #2-버그 수정
[Del] #2-쓸모없는 코드, 뭐 어쩌고 삭제
[Refactor] #2-코드 리팩토링 -> 결과는 똑같음. 근데 코드가 달라짐
[Move] #2-프로젝트 구조 변경(폴더링 등)
[Rename] #2-파일, 클래스, 변수명 등 이름 변경
[Docs] #2-Wiki, README 파일 수정
```

## Branch

- 가장 처음에 붙는 분류 영역에서는, 커밋 컨벤션의 워딩과 동일하게 작성합니다.

### Branch Naming

> `분류` /`#이슈 번호` - `작업할 뷰` - `상세 작업 내역`
> 

```swift
Chore/#3-Project-Setting
Feat/#3-HomeView-UI
Fix/
```

## Merge

- 본인의 `PR`은 본인이 `Merge`합니다.
- 최대한 빨리, 최대 24시간 이내에 코드 리뷰를 등록합니다.
- 최신화를 자주 하자!
- Approve를 최소 1명한테 받아야 Merge가 가능합니다.
    - 2명이 최대한 Approve 줄 수 있도록 합시다!
- 코드 리뷰를 하면서 필수적인 수정 사항을 발견할 경우, `Approve` 대신 `Request Changes`를 주어 수정을 요구합니다.
    - 해당 `PR` 작업자는, 수정 사항을 반영하여 새로 `commit`을 추가한 후, 해당 `PR`에 `push`하여 `Re-request review`를 요청합니다.
        1. `Request Changes`: 컨벤션 
        2. `Approve`: 일단 OK! 로직, 리팩토링 가능한 부분, 더 나은 코드를 위한 제안 등
- 모든 작업이 완료되어 `Merge`가 된 경우, 해당 `PR` 하단의 `Delete Branch`를 선택하여 작업이 끝난 `Branch`를 삭제합니다.

## 🗂 Foldering
```markdown
# 📁 Foldering Convention
├── Application
│   ├── AppDelegate.swift
│   └── SceneDelegate.swift
├── Global
│   ├── Base
│   │   ├── BaseNVC.swift
│   │   └── BaseVC.swift
│   └── Extensions
│       ├── UIColor+.swift
|       ├── UIFont+.swift
│       └── 기타 Extension 파일.swift
|
├── Info.plist
├── Network
│   ├── Base
│   │   ├── APIConstants.swift
│   │   └── NetworkConstants.swift
│   ├── Services
│   │   └── TogetherService.swift
│   ├── DataModel
│   │   ├── TogetherResponse.swift
│   ├── APIs
│   │   ├── TogetherAPI.swift
├── Resources
│   ├── Assets.xcassets
│   ├── Colorsets.xcassets
│   └── Fonts
│     
└── Sources
    ├── Components
    │   └── DefaultNavigationView.swift
    ├── HaraTabBarController.swift
    └── Scenes
        ├── Together
        ├── Write
        └── Storage
```
 

