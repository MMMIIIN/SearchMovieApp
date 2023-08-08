//
//  MovieSearchUseCaseTest.swift
//  SearchMovieAppTests
//
//  Created by Mingwan Choi on 2023/08/01.
//

import XCTest
@testable import SearchMovieApp

final class MovieSearchUseCaseTest: XCTestCase {
    var usecase: MovieSearchUseCase!
    
    override func setUp() {
        self.usecase = DefaultMovieSearchUseCase(repository: DefaultMovieSearchRepository(movieSearchService: MockMovieSearchService()))
    }
    
    override func tearDown() {
        self.usecase = nil
    }
        
    func test_searchMovie란_함수가_존재하는가() async throws {
        let _ = try await self.usecase.searchMovie(query: "")
    }
    
    func test_loadNowPlayingMovies란_함수가_존재하는가() async throws {
        let _ = try await self.usecase.loadNowPlayingMovies()
    }
    
    func test_mock네트워크의_loadNowPlayingMovies란_함수가_올바르게_mock값을_리턴하는가() async throws {
        // given
        var movies: [Movie]
        // when
        movies = try await self.usecase.loadNowPlayingMovies()
        // then
        XCTAssertTrue(movies.contains { $0.title == "비공식작전" })
        XCTAssertTrue(movies.contains { $0.imagePath == "/7jTIUnjfaXu3ewCxEJXmIoMrish.jpg" })
        XCTAssertTrue(movies.contains { $0.overview == "10년 전, 유체이탈을 통해 기이한 사건을 겪은 '조쉬'와 '달튼' 부자는 그날의 기억을 모두 지운다. 10년 후,'조쉬'는 수상한 존재가 주변을 맴돌고 있음을 느끼고, 집을 떠나 대학에 입학한 ‘달튼'은 봉인된 기억 속 빨간 문에 대한 의문을 품게 된다. 램버트 가족에게 연달아 기괴한 사건들이 일어나고 과거의 비밀이 끔찍한 악몽으로 되살아나는데…" })
    }
    
    func test_mock네트워크의_searchMovie란_함수가_올바르게_mock값을_리턴하는가() async throws {
        // given
        var movies: [Movie]
        // when
        movies = try await self.usecase.searchMovie(query: "범죄도시")
        // then
        XCTAssertTrue(movies.contains { $0.title == "범죄도시" })
        XCTAssertTrue(movies.contains { $0.imagePath == "/lvfPG1fflSu5JPqgMtKG9rxym5Z.jpg" })
        XCTAssertTrue(movies.contains { $0.overview == "2004년 서울. 중국 하얼빈에서 활동하다 피신한 신흥 범죄조직의 악랄한 보스 장첸. 가리봉동 일대로 넘어온 장첸과 그의 일당들은 단숨에 기존 조직들을 장악하고 가장 강력한 세력인 춘식이파 보스 황사장까지 위협하며 도시 일대의 최강자로 급부상한다. 한편 대한민국을 뒤흔든 장첸 일당을 잡기 위해 오직 주먹 한방으로 도시의 평화를 유지해 온 괴물형사 마석도와  인간미 넘치는 든든한 리더 전일만 반장이 이끄는 강력반은 눈에는 눈 방식의  소탕 작전을 기획하는데..." })
    }
    
    func test_실제네트워크의_loadNowPlayingMovies란_함수가_잘동작하는가() async throws {
        let usecase = DefaultMovieSearchUseCase(repository: DefaultMovieSearchRepository(movieSearchService: DefaultMovieSearchService()))
        
        do {
            let movies = try await usecase.loadNowPlayingMovies()
            XCTAssertFalse(movies.isEmpty)
        } catch {
            XCTFail("Error")
        }
    }
    
    func test_실제네트워크의_searchMovie란_함수가_잘동작하는가() async throws {
        let title = "범죄도시"
        let usecase = DefaultMovieSearchUseCase(repository: DefaultMovieSearchRepository(movieSearchService: DefaultMovieSearchService()))

        do {
            let movies = try await usecase.searchMovie(query: title)
            XCTAssertFalse(movies.isEmpty)
        } catch {
            XCTFail("Error")
        }
    }
}
