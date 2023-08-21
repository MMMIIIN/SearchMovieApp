# SearchMovieApp

#### TMDB의 API를 활용한 영화 검색 앱
https://developer.themoviedb.org/


<br>

### 기술적인 도전

- [RxSwift](https://github.com/ReactiveX/RxSwift)
- [CleanArchitecture + MVVM](https://github.com/kudoleh/iOS-Clean-Architecture-MVVM)
- [FlexLayout](https://github.com/layoutBox/FlexLayout), [PinLayout](https://github.com/layoutBox/PinLayout)
- DiffableDataSource
- [Moya](https://github.com/Moya/Moya)
- Network Stub
- UI Test

<br>

### 해당 프로젝트를 만든 이유

기회가 없어 사용해보지 못한 기술들을 경험해보고 싶었고, 어떻게 더 편하게 만들 수 있는지 직접 만들어보면서 배워보고 싶었습니다. 

- [RxSwift](https://github.com/ReactiveX/RxSwift)를 활용해 [CleanArchitecture + MVVM](https://github.com/kudoleh/iOS-Clean-Architecture-MVVM) 구조로 만들었습니다.
- [FlexLayout](https://github.com/layoutBox/FlexLayout)과 [PinLayout](https://github.com/layoutBox/PinLayout)을 사용해서 View를 만들었습니다. CollectionView는 DiffableDataSource를 사용해 부드러운 애니메이션의 UI를 만들었습니다.
- [Moya](https://github.com/Moya/Moya)를 사용해 네트워크 통신 코드와 실제 네트워크 환경에 의존하지 않는 Stub 코드를 만들었습니다.
- 각종 Unit Test코드와 [RxTest](https://github.com/ReactiveX/RxSwift/tree/main/RxTest)를 활용한 ViewModel 테스트 코드, UI Test코드를 만들었습니다.


<br>

### API키 넣는 방법

![image](https://github.com/MMMIIIN/SearchMovieApp/assets/78677571/872333ec-cb24-4b04-84b3-fea897789c1e)

<br>

### 해당 프로젝트를 통해서 배운점

- CleanArchitecture + MVVM 구조로 설계하니 각 레이어에 대한 테스트 코드를 짜는데 매우 용이했습니다.
- `withCheckedThrowingContinuation` 를 사용해서 Moya의 escaping closure를 async await 구조로 변경해서 사용하는 법을 배우고 적용할 수 있었습니다.
  <details>
  <summary>예시 코드</summary>
  <div markdown="1">
  <img width="1000" alt="image" src="https://github.com/MMMIIIN/SearchMovieApp/assets/78677571/46c7006f-e09d-4108-b21f-7aca8e1d4ac8">


  </div>
  </details>
- UI Test를 통해 해당 테스트의 스크린샷을 통해 실제 빌드를 돌리지 않고도 테스트 화면을 확인하는 방법을 배웠습니다.
  <details>
  <summary>스크린샷</summary>
  <div markdown="1">

  <img width="1000" alt="image" src="https://github.com/MMMIIIN/SearchMovieApp/assets/78677571/243c5411-6685-45d9-9036-5ed7e3e122b8">

  </div>
  </details>



### 아쉬웠던 점

- Async Await를 사용해서 네트워크 코드를 만들다 보니 ViewModel을 테스트 할 때 RxTest를 100% 활용하지 못한다는 느낌이 들었지만 어떻게 개선해야할지 방법을 찾을수가 없어서 아쉬웠습니다.
- FlexLayout과 PinLayout에 대한 예시가 많이 없어서 간단한 CollectionView를 만드는 과정임에도 어떤 Life Cycle에 코드를 추가해야 하는지 명확히 알기에 어려움이 있었습니다.
