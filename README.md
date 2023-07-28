# 🎬 박스오피스 _ 웰다비🍿🥤

## 📖 목차
🍀 [소개](#소개) </br>
👨‍💻 [팀원](#팀원) </br>
⏱️ [타임라인](#타임라인) </br>
👀 [시각화된 프로젝트 구조](#시각화된_프로젝트_구조) </br>
🧨 [트러블 슈팅](#트러블_슈팅) </br>
📚 [참고 링크](#참고_링크) </br>

</br>

## 🍀 소개<a id="소개"></a>
`Whales`과 `Dasan`이 만든 박스오피스입니다.
영화진흥위원회의 Open API를 이용하여 일별 박스오피스 정보와 영화 상세 정보를 가져옵니다.

</br>

## 👨‍💻 팀원<a id="팀원"></a>
| 🐬Whales🐬 | 🌳Dasan🌳 |
| :--------: | :--------: |
| <Img src = "https://github.com/WhalesJin/FireSaturdayStudyClassC/assets/124643545/e4e33a5d-f56c-4a3d-80b5-484ab3c62f27" width="200"> | <Img src = "https://user-images.githubusercontent.com/106504779/253477235-ca103b42-8938-447f-9381-29d0bcf55cac.jpeg" width="200"> |
|[Github Profile](https://github.com/WhalesJin) |[Github Profile](https://github.com/DasanKim) |

</br>

## ⏱️ 타임라인<a id="타임라인"></a>
|날짜|내용|
|:--:|--|
|2023.07.24(월)| - [영화진흥위원회의 일별 박스오피스 API 문서](https://www.kobis.or.kr/kobisopenapi/homepg/apiservice/searchServiceInfo.do?serviceId=searchDailyBoxOffice)의 데이터 형식을 고려한 모델 타입 설계 |
|2023.07.25(화)| - `BoxOffic`, `BoxOfficeData`, `DailyBoxOfficeResult` 타입 생성 <br> - `DecodingManager`, `DataError` 타입 생성 및 구현 <br> - `DecodingManager`에 대한 Unit Test 진행 <br> - 파일 구룹화|
|2023.07.26(수)| - **Test Plan Reference** 오류 수정 <br> - [URLSession](https://developer.apple.com/documentation/foundation/urlsession) 공부 |
|2023.07.27(목)| - `Movie`, `MovieInformationResult`, `MovieInformation` 타입 생성 <br> - 각각의 관련 타입들 `BoxOffice`, `Movie` 파일로 **병합** <br> - `NetworkManager` 타입 생성 및 구현|
|2023.07.28(금)| - `Movie` 타입 오류 수정 <br> - `fetchData`매서드에 `completionHandler` 추가 <br> - README 작성|

</br>

## 👀 시각화된 프로젝트 구조<a id="시각화된_프로젝트_구조"></a>

### ℹ️ File Tree
    ┌── BoxOffice
    │   ├── BoxOffice
    │   │   ├── Application
    │   │   │   ├── AppDelegate
    │   │   │   └── SceneDelegate
    │   │   ├── Model
    │   │   │   ├── BoxOffice
    │   │   │   ├── Movie
    │   │   │   ├── DecodingManager
    │   │   │   ├── DataError
    │   │   │   └── NetworkManager
    │   │   ├── View
    │   │   │   ├── Main
    │   │   │   └── LaunchScreen
    │   │   └── Controller
    │   │       └── ViewController
    │   └── BoxOfficeTests
    │       └── DecodingManagerTests
    │           └── DecodingManagerTests
    └── README.md

### 📐 Diagram
- BoxOffice </br>
<img width = "200" src = "https://github.com/WhalesJin/FireSaturdayStudyClassC/assets/124643545/78f65173-c009-4e30-9d02-8caf2a4f6d38"> <br>
    
- Movie <br>
<img width = "900" src = "https://github.com/WhalesJin/FireSaturdayStudyClassC/assets/124643545/4a6854a9-5abd-4df8-88eb-ae96bfb20853"> <br>

<br>
 
## 🧨 트러블 슈팅<a id="트러블_슈팅"></a>

### 1️⃣ Unit Test
🚨 **문제점** <br>
- `DecodingManager` 타입의 decodeJSON`메서드`를 테스트하여, **decoding 및 parsing**이 잘 이루어지고 있는지를 확인하고 싶었습니다.

💡 **해결방법** <br>
- 현재로써는 `Error`를 어떻게 처리해야하는지 명확하지 않아 `do-catch`문 등으로 오류 처리하기보다, Tests 내에서 `XCTAssertThrowsError`, `XCTAssertNoThrow` 메서드를 사용하여 상황에 맞게 오류를 잘 던지고 있는지 확인하였습니다.

```swift
//DecodingManagerTests.swfit

func test_일치하는_dataAsset이없을때_notFoundAsset에러를_던진다() {
    //given
    let fileName = "없는파일이름"

    //when, then
    XCTAssertThrowsError(try sut.decodeJSON(fileName: fileName) as BoxOffice) { error in
        XCTAssertEqual(error as! DataError, DataError.notFoundAsset)
    }
}
    
func test_일치하는_dataAsset가있을때_notFoundAsset에러를_던지지않는다() {
    //given
    let fileName = "box_office_sample"

    //when, then
    XCTAssertNoThrow(try sut.decodeJSON(fileName: fileName) as BoxOffice)
}
```

<br>

### 2️⃣ Test Plan Reference 오류
`DecodingManager` 타입에 대한 Unit Test을 진행하였습니다. 후에 추후 추가될 Test들을 생각하여 `BoxOfficeTests`라는 상위 폴더를 생성하고, `DecodingManagerTests` 폴더 및 `BoxOffice.xctestplan` 파일을 `BoxOfficeTests` 폴더에 넣어주었습니다.

    └── BoxOfficeTests
        └── BoxOffice.xctestplan
        └── DecodingManagerTests
            └── DecodingManagerTests.swift

🚨 **문제점** <br>

- 폴더 및 파일들을 `BoxOfficeTests`로 이동한 후부터, 아래와 같은 메시지창이 뜨며 Unit Test가 실행되지 않았습니다.
   - error 메시지
   <img src="https://github-production-user-asset-6210df.s3.amazonaws.com/124643545/256756273-ba5fd051-9faa-44dd-a94d-c553a6f1f220.png" width="400">

   - missing된 DecodingManagerTests
   <img src="https://github-production-user-asset-6210df.s3.amazonaws.com/124643545/256756316-e934d064-053f-41d3-9ce4-8de7fd238d7b.png" width="400">

- 위와 같은 문제가 생긴 이유는 `Test Plan`의 위치를 옮길 때 `BoxOffice` 타겟에 대한 `Test Plan reference` 경로가 변경되었기 때문이었습니다.

   <img src = "https://github-production-user-asset-6210df.s3.amazonaws.com/124643545/256756329-6f5c135a-60e7-4b0a-82c8-fed4ee89c675.png" width = "700">

💡 **해결방법** <br>
- 이 문제를 해결할 수 있는 방법에는 2가지가 있었습니다:
    1. Test Plan의 `configurations` 설정
        - Test Plan > configurations > Target for Variable Expansion
        - Target for Variable Expansion 값을 none으로 바꾸었다가 다시 App으로 변경
    2. 기존 Test Plan 삭제 후 `새롭게 추가`
        - Product > Scheme > Edit scheme > Test
        - Test Plans에 있는 기존 BoxOffice Test Plan을 삭제하고, 다시 add
    
        <img src = "https://hackmd.io/_uploads/SkvTsgRqh.png" width = "500">

- 저희는 첫번째 방법으로는 해결이 되지 않아, 두번째 방법으로 해결하였습니다.

<br>

## 📚 참고 링크<a id="참고_링크"></a>

- [🍎Apple Docs: URLSession](https://developer.apple.com/documentation/foundation/urlsession)
- [🍎Apple Docs: Fetching Website Data into Memory](https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory)
- [🍎Apple Docs: Swift Closures - Capturing Values](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/closures/)
- [🍎Apple Docs: UICollectionView](https://developer.apple.com/documentation/uikit/uicollectionview)
- [🍎Apple Docs: XCTAssertThrowsError](https://developer.apple.com/documentation/xctest/1500795-xctassertthrowserror)
- [🍏WWDC: Modern cell configuration](https://developer.apple.com/videos/play/wwdc2020/10027/)
- <Img src = "https://github.com/WhalesJin/ios-bank-manager/assets/124643545/d1df2d8a-6667-438d-9643-aab8a83a4754" width="20"/> [Alamofire](https://github.com/Alamofire/Alamofire/blob/master/Source/Alamofire.swift)
- <Img src = "https://github.com/WhalesJin/ios-bank-manager/assets/124643545/d1df2d8a-6667-438d-9643-aab8a83a4754" width="20"/> [Moya](https://github.com/Moya/Moya/tree/master/Sources/Moya)
- <Img src = "https://github.com/mint3382/ios-calculator-app/assets/124643545/56986ab4-dc23-4e29-bdda-f00ec1db809b" width="20"/> [야곰닷넷: Test Double](https://yagom.net/courses/unit-test-작성하기/lessons/테스트를-위한-객체-만들기/topic/테스트를-위한-객체를-이용해서-테스트-작성하기/)
- <Img src = "https://hackmd.io/_uploads/ByTEsGUv3.png" width="20"/> [blog: URL 처리 방법](https://ios-development.tistory.com/1014)


</br>
