//
//  SearchViewModel.swift
//  TvOSSample
//
//  Created by Luis Enrique Diaz Ramirez on 06/06/23.
//

import Foundation

class SearchViewModel: NSObject{
    var httpClient: HTTPClientProtocol!
    
    private(set) var empData: Characters!{
        didSet{
            self.bindEmployeeViewModelToController()
        }
    }
    
    var bindEmployeeViewModelToController: (() -> ()) = {}
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
    
    func callFuncToGetEmpData() async throws{
        let url = URLManager.EndPoint.employees()
        let employees: Characters = try await self.httpClient.fetch(url: url)
        self.empData = employees
    }
    
}

