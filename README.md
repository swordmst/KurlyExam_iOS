# 컬리 과제 - Swift 프로젝트

## 프로젝트 개요
이 프로젝트는 컬리 과제로 개발된 iOS 애플리케이션으로, GitHub 레포지토리 검색 기능을 제공합니다.

## 아키텍처
- **MV 아키텍처**: Model-View 패턴을 채택하여 깔끔한 코드 구조 유지
- **Swift Concurrency**: async/await를 활용한 비동기 처리로 성능 최적화

## UI 개발 방식
- **SwiftUI**: 선언적 UI 프레임워크를 사용하여 직관적이고 반응형 인터페이스 구현

## 프로젝트 구조

### 📱 Layout
#### ChipLayout
- Recent 검색 결과를 ChipView 형태로 표시하는 커스텀 레이아웃
- 태그 형태의 UI로 이전 검색어를 시각적으로 표현

### 🗃️ Model
#### Data
- **GithubRepoModel**: GitHub 레포지토리 정보를 받아오는 데이터 모델
  - 레포지토리의 기본 정보, 별점, 포크 수 등을 포함

#### RecentSearchTextModel
- 이전 검색 결과를 관리하는 모델
- 사용자의 검색 히스토리를 추적하고 관리

#### SearchModel
- 검색 결과를 관리하는 모델
- 검색 상태, 결과 데이터, 에러 처리 등을 담당

### 🔧 Modules
#### NetworkEndpoint
- HTTP 네트워크의 Endpoint를 설정하는 모듈
- API URL 및 파라미터 구성을 체계적으로 관리

#### NetworkModule
- Alamofire를 래핑하여 HTTP 통신을 처리하는 모듈
- 재사용 가능한 네트워크 레이어 제공

#### UserDefaultsManager
- UserDefaults에 데이터를 읽고 쓸 수 있게 해주는 모듈
- 검색 히스토리 등의 로컬 데이터 저장 관리

#### WebView
- SwiftUI에서 WebView를 사용할 수 있게 해주는 모듈
- UIViewRepresentable을 활용한 WebKit 통합

### 🎨 View
#### AutoCompleteListView
- 검색 시 자동 완성을 표시하는 View
- 실시간 검색 제안 기능 제공

#### RecentItemView
- 이전 검색 결과를 표시해주는 View
- 검색 히스토리를 사용자 친화적으로 표현

#### SearchResultView
- 검색 결과를 표시해주는 View
- GitHub 레포지토리 정보를 리스트 형태로 표시

#### ContentView
- 전체 View를 설정해주는 루트 뷰
- 앱의 전체적인 네비게이션과 레이아웃을 관리

## 주요 기능
- GitHub 레포지토리 실시간 검색
- 검색 자동 완성 기능
- 검색 히스토리 관리
- 반응형 UI 디자인
- 웹뷰를 통한 레포지토리 상세 정보 확인

## 기술 스택
- **언어**: Swift
- **UI 프레임워크**: SwiftUI
- **네트워킹**: Alamofire
- **아키텍처**: MV Pattern
- **비동기 처리**: Swift Concurrency (async/await)
- **데이터 저장**: UserDefaults
