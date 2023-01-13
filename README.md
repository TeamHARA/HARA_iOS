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

## 🔥 역할 분담

<details>
<summary> 담이닝 </summary>
<div markdown="1">

- **담이닝**
    - **함께고민 탭 화면**
    <img width="401" alt="Screen Shot 2023-01-13 at 8 38 03 PM" src="https://user-images.githubusercontent.com/32871014/212311899-7aea3a3e-5294-44be-a203-3eac23fbfa27.png">
    - **함께고민**
        
        <img width="255" alt="Screen Shot 2023-01-13 at 8 00 50 PM" src="https://user-images.githubusercontent.com/32871014/212310079-1a4c7154-96ef-427d-ac1d-d5942ba05c0d.png">
        
    - **상단 카테고리 - 컬렉션 뷰 (flowLayout 사용)**
    - **하단 고민글**
        - 외부 컬렉션 뷰 - 컴포지셔널 레이아웃으로 각 레이블 및 버튼과 내부 컬렉션뷰로 구성
        - 내부 컬렉션 뷰 - 각 선택지를 셀로 담고 있는 컬렉션 뷰
            - 내부 셀을 클릭시 투표하기 버튼 활성화
            - 투표결과 확인 - 외부 컬렉션 뷰의 셀에 있는 투표하기를 눌렀을 때 내부 셀을 바꿔주고 셀 위에 width가 0인 UIView를 덮어 놓고  원하는 퍼센티지 만큼의 비율로 width를 snapkit updateConstraint로 다시 넓이를 잡아 투표결과 화면 구현
            - 투표를 했을때 투표하기 버튼 비활성화
            - 고민 투표 화면
                <img width="636" alt="Screen Shot 2023-01-13 at 7 57 35 PM" src="https://user-images.githubusercontent.com/32871014/212309792-aad52399-d73c-4388-b23a-4e349ddf2631.png">
                
                
    - **고민 상세보기 화면**
        - 전체를 하나의 컴포지셔널 레이아웃을 사용한 컬렉션뷰로 고민글, 댓글 화면 두 개의 섹션으로 나누어 구현
        - 첫번째 섹션의 선택지의 개수가 동적이기 때문에 셀로 구현했지만 상단의 제목 및 내용과 하단의 투표하기버튼은 고정이기 때문에 헤터와 푸터로 정적인 영역을 구현
        - 두번째 섹션의 댓글창 상단의 댓글 개수 부분을 헤더 하단의 댓글 수가 동적이기 때문에 셀로 구현
        - **상세고민**
            
            <img width="181" alt="Screen Shot 2023-01-13 at 8 02 35 PM" src="https://user-images.githubusercontent.com/32871014/212310083-ffd3ab86-81fe-404a-a1d2-f836c39448f1.png">
            
    - **최종결정하기 화면**
        - 다른 뷰처럼 컬렉션뷰를 이용해 각 선택지 화면을 동적으로 구현
        - **최종결정하기**
            
            <img width="394" alt="Screen Shot 2023-01-13 at 8 05 31 PM" src="https://user-images.githubusercontent.com/32871014/212310086-0c319877-f879-4b8c-afc5-ccfa71d56045.png">
            
</div>
</details>

<details>
<summary> 성호잉 </summary>
<div markdown="1">

- **성호잉**
    - **하단 탭바의 중간 고민쓰기 버튼 클릭시**
        - WriteVC(고민쓰기 탭)가 modal 방식으로 올라오게끔 한다.
        - 고민쓰기 완료 시 [홈화면, 고민보관함] 중 자신이 원래 보고 있던 탭이 보여지게끔 설정
    - **혼자/함께 고민 작성하기 화면**
        
        <aside>
        💡 WriteVC 라는 이름의 ViewController 위에 pageViewController를 올리고, 5개의 pageView를 만들었습니다.
        
        </aside>
        
        각 화면의 진행상황이 상단의 파란색 Bar에 나타납니다. 
        
        다음 화면 또는 이전 화면으로 넘어갈 시에, 상단 Bar가 잠깐 깜빡이는 애니메이션을 주어 넘어가는 듯한 느낌을 주었습니다.  
        
        📌 firstWriteStepVC : 고민 요약 및 상세 내용 작성
        
        - TextField, TextView의 delegate를 통해 글자수 체크
        
        📌 secondWriteStepVC : 고민의 선택지 작성(최소 2개~최대 4개까지)
        
        - 기본 선택지(2개)와 추가 선택지의 레이아웃이 달라 2가지 UIView를 만들어, 전체 뷰는 StackView로 구현했습니다.
        
        📌 thirdWriteStepVC : 고민의 각 선택지의 장단점을 작성(필수X, 선택사항)
        
        - secondWriteStepVC의 선택지 수 만큼 CollectionViewCell이 만들어지게끔 하였습니다.
        
        📌 fourthWriteStepVC : 고민의 카테고리를 지정
        
        - textField의 값을 pickerView로 선택한 카테고리의 값으로 지정해주었습니다.
        
        📌 fifthWriteStepVC : 혼자 고민인지 함께 고민인지 버튼을 통해 분류 지정
        
        - 각 button의 isselected의 참불을 검사하여 함께 고민으로 post를 보낼지, 혼자 고민으로 post를 보낼지를 지정해주었습니다.
        
        → 각 화면에서 특정 사항을 만족시키지 못하면, 다음 화면으로 넘어가는 화살표가 비활성화되게끔 해주었습니다. 
        
        → 모든 조건이 만족(delegate로 검사) 되면, 마지막 화면에서 업로드하기 버튼이 활성화되고, 업로드 버튼을 클릭시 아래의 write_notice 화면이 띄어지게 하였습니다. 
        
        - 고민쓰기 탭 각 화면별 사용 UIKit
            
            <img width="556" alt="KakaoTalk_Photo_2023-01-13-20-40-59 001" src="https://user-images.githubusercontent.com/32871014/212312350-804564a9-e327-43d0-b815-6a674bf0f9d5.png">
            
            <img width="479" alt="KakaoTalk_Photo_2023-01-13-20-41-00 002" src="https://user-images.githubusercontent.com/32871014/212312353-5c9188fb-61c4-4a4e-80d9-4e427b1c22f0.png">
            
            <img width="479" alt="KakaoTalk_Photo_2023-01-13-20-41-00 003" src="https://user-images.githubusercontent.com/32871014/212312358-77c3e0a6-0805-4ef9-9fe6-98218380d2c8.png">
            
            <img width="476" alt="KakaoTalk_Photo_2023-01-13-20-41-00 004" src="https://user-images.githubusercontent.com/32871014/212312362-2b11a44a-ce0b-446f-be4d-9bf3a19a7261.png">
            
    - **1초만에 고민 결정하기 화면**
        1. 고민의 제목을 입력하는 textField이 채워지면, 뽑기 버튼이 활성화 됩니다. 
        2. 뽑기 버튼을 클릭 시에 고민의 해결사항이 띄어지면서, 다시 뽑기 버튼으로 뽑기 버튼이 변경됩니다. 
        3. 다시 뽑기 버튼을 클릭시에 다시 초기화면으로 돌아옵니다. 
        
        아래의 지난 나의 고민은 최근 10개의 고민을 컬렉션 뷰의 Cell로 받아옵니다. 
        
        - 1초만에 고민결정 화면
            
            00 005" src="https://user-images.githubusercontent.com/32871014/212312364-49fc318e-326e-425b-8979-3f8071df6c7b.png">

</div>
</details>

<details>
<summary> 누리링 </summary>
<div markdown="1">

            
- **누리링**
    - 고민보관함 혼자 고민, 함께고민 부분
        - StorageVC를 만들어 전체 화면 구성을 ViewController로 짰습니다
        - 혼자 고민, 함께 고민은 Segmented Control과 PageViewController로 짰습니다. PageView와 Segmented Control의 인덱스 번호를 통일해서 버튼을 누르거나, 옆으로 화면을 swipe하는 동작이 진행될 수 있게 했습니다.
        - 하단에 들어가는 고민 내용이 뜨는 목록들은 CollectionViewCell로 구현했고, 서버 연결을 통해 고민 목록이 뜰 수 있도록 했습니다.
        - 고민중과 고민해결은 왼쪽 상단 버튼을 클릭하면, 관련 값이 셀에 적용되어 보일 수 있도록 짰습니다
        - [실행화면이 궁금하다면?] 여기를 클릭해라!
            
            ![Simulator Screen Recording - iPhone 13 mini - 2023-01-13 at 04 40 38](https://user-images.githubusercontent.com/32871014/212311125-ca621889-064b-4bf0-89c0-c561206ae109.gif)

</div>
</details>
 
## 💜 프로젝트 회고

<details>
<summary>담이닝</summary>
<div markdown="1">

- **담이닝**
    
    지난 기수 YB로 앱잼을 하면서 앱잼 리드친구와 다른 팀원이 워낙 잘하는 친구여서 따로 신경 쓸 일이 없이 기본 세팅이 다 되어있는채로 상대적으로 편하게 내가 할 일만 집중해서 작업 할 수 있었다. 
    
    그러나 이번 기수 리드로서 직접 프로젝트 세팅부터 직접하려니 함께 프로젝트를 하기 위해 해야 할 일이 정말 많다는 것을 알게 되었다. 내가 지난기수에 편하게 작업 할 수 있도록 리드가 많은 것을 해줬구나 깨달으면서 동시에 내가 받은만큼 팀원들에게 해줘야겠다고 생각했지만 이렇게 직접 협업 프로젝트를 이끄는 것이 거의 처음이라 사소한 것 하나 하나 많은 것에 조금씩 어려움을 느꼈던 것 같다.
    
    그리고 무엇보다 개발하면서 내가 아직 잘 모르는 부분에 대해서 바로 물어볼 수 있는 사람이 없다는 것이 가장 어려웠고, 어려움을 겪고 있는 팀원의 문제가 나도 잘 모르는 부분일 때 좀 더 잘 도와주고 싶었는데 역량의 부족으로 그럴 수 없어서 아쉬웠다. 
    
    또한 내가 맡은 작업을 하면서 동시에 팀원들이 겪고 있는 문제도 같이 해결해 주면서 하다보니 역량 부족으로 제대로 내가 맡은 작업에 대해서 진도가 잘 나가지 않았었던 것 같다. 얼른 진행을 해야된다는 조급한 마음의 팀원들의 코드 리뷰도 제대로 확인하지 못했는데 그러다 보니 팀원들이 잘못 알고 쓰고 있는 것들을 빨리 고쳐주지 못했었던 어려움이 있었다. 
    
    그래도 이렇게 프로젝트를 리드하면서 내가 알지 못했던 것에 대해 많이 배웠고, 내가 잘 알려주지 못하는 부분은 함께 고민해보면서 오히려 내가 많이 배울 수 있었던 것 같다. 앱잼동안 해결되지 않는 문제에 대해 삽질도 하며 시간을 소비했는데 이것이 단순히 시간 낭비가 아니라 그만큼 더 배울 수 있는 시간이 되었다고 생각한다. 
    
    그리고 개발적으로 초기에 뷰를 짜는데 집중하여 서버의 API 구성해 대해서 크게 신경쓰지 못했는데 내가 구현해 놓은 로직을 다시 서버에서 주는 API 명세서에 맞추려다 보니 제대로 구현이 되지 않았다. 그래서 다음 이렇게 협업시에 서버의 명세서에 대해서 먼저 상세하게 협의를 보고 그에 맞춰서 로직을 구현해야겠다고 생각했다.

</div>
</details>

<details>
<summary>성호잉</summary>
<div markdown="1">

- **성호잉**
    1. Git
        
        2주동안 개발을 진행하면서 어느정도 git에 익숙해지고, 이제는 조금은(?) 능숙하게 쓸 수 있게 되었다. 컨플릭트가 나더라도 예전처럼 무섭지 않고, 혼자서 해결하는 법도 알게 되었다. 초반에 Git크라켄을 사용하면서, 브랜치의 대소문자 구분을 하지 못해서 push가 아예 안되는 이슈로 거진 하루를 날렸다. 후에 ‘Fork’로 프로그램을 변경하고 지금까지 문제 없이 잘 사용하고 있다. 어려웠던 Git Flow를 이제는 어느정도 이해 할 수 있게 되서 뿌듯했다. 
        
    2. 서버로의 데이터 전달
        
        처음에 뷰를 짤 때, 서버에게 전달해줄 데이터를 고려하지 않고 마냥 뷰를 연결시키는데에만 집중했던 것 같다. 서버의 Api 명세서에 나온 데이터 양식대로 구조체를 만들고, 그 데이터를 모든 뷰가 공유하게끔 해서 하나의 데이터 뭉텅이를 계속 들고가게끔 코드를 짰다면, 여러개의 delegate와 분기처리를 하지 않고 도 더 깔끔하고 가독성 좋은 코드를 짤 수 있었을 것 같다. 
        
        앱잼이 마지막이라고 생각하지 않고, 끝난 이후에도 계속 여러 디자인 패턴들을 공부해나가야 겠다. 
        
    3. 협업 관련
        
        기획이 원했던 플로우 방향, 화면 전환 방식, 이벤트 처리등이 개발자들이 이해한 방향과 조금 다른 부분이 계속 생겨 이를 하나로 맞추고 통일화 하는 것이 은근 쉽지 않았던 것 같다. 코드를 다 짜고 나중에 수정이 필요할 때 얼마나 시간이 소요될지를 모르기 때문에, 계속 중간중간에 회의를 진행하며 생각을 서로 공유하며 맞춰가는 노력을 했다. 처음에 좀 더 확실하게 기획이나 디자인에게 생각을 물어보고 확실화게 했다면 좀 더 시간을 절약할 수 있지 않을까 생각한다. 다음 협업은 훨씬 더 잘할 수 있을 것 같다.

</div>
</details>


<details>
<summary>누리링</summary>
<div markdown="1">

- **누리링**
    
    먼저 우리 팀원들한테 고맙다고 말하고 싶어요! 앱잼 기간동안 다들 너무너무 수고했어유ㅠㅠ 같이 하나씩 고민하고 어려운 부분들 뿌셔나가는 과정들 하나하나 소중합니다.
    
    저는 사실 UI 뷰 부분부터 많이 해맸던 거 같아요..! 열심히 한다고는 하지만 많이 부족한 팀워이었을 거라는 생각이 들어서..그 점이 제일 미안하고 고마워요..! 새로운 기능, 로직들을 짜는 방법도 담인오빠랑 성호한테 많이 물어보고, 아이디어 구하면서 진행했습니다. 막판에는 아빠짱 도움도 받아서 ㅠㅠ다들 고맙습니다. 
    
    앱잼 기간동안 계절학기를 같이 병행해서 오후에 팀원들이랑 함께하는 시간이 부족했거든요…! 그래서 그 시간을 매꾸기 위해서라도 오전에 기능이랑 구현들도 찾아보고 다른 코드들도 막 찾아보다가 수업에 들어가는 경우도 많았습니다. 하지만 결국 그 코드들을 잘 이해하고 제 논리에 적용하기 위해 응용해야하는데 그 부분에서의 제 실력이 많이 부족하다는 사실을 깨달아서 좀 위축되기도 했던 것 같아요,,,하지만..! 앱잼 이후가 진짜 시작이라고 생각하니!! 더 열심히 배우고 공부하고, 제가 부족하다고 느끼는 영역들 (뷰, 로직짜기, 코드 응용, 모야 너 진짜 모야?? 등등)을 채우기 위해 주변에도 많이 물어보고, 스터디도 진행하고 혼자 더 공부하는 시간을 올해 1월~2월에 진행해야겠다는 생각을 했습니다!!!!!!!
    
    아 참, 그리고 깃플로우도 저번 합세때 이후 써보는 거지만,,여전히 익숙하지 않아서 합숙 이전부터 담인오빠가 열심히 설명해줬고, 합숙 하면서도 계속 알려준 덕분에 깃 컨벤션, 깃 흐름을 얼추 이해할 수 있었습니다. 하지만 머지 과정에서 깃 충돌이 나거나 (깃 충돌 = 시간 잡아먹는 괴물ㅎㅁㅎ) main 브랜치와 remote브랜치 동기화 등등에 대한 부분은 좀 더 실습하고 경험하면서 이해해 나가야겠다 생각합니다. 흐름만 이해했지, 문제 상황이 닥치면 아무것도 할 수가 없더라구요….그게 너무너무너무 답답했습니다…
    
    우리팀 진짜 수고했고 많이 애정합니다!!!!!

</div>
</details>