//
//  MovieInformationViewController.swift
//  BoxOffice
//
//  Created by Dasan & Whales on 2023/08/14.
//

import UIKit

class MovieInformationViewController: UIViewController {
    private var movieCode = String()
    
    init(movieCode: String) {
        self.movieCode = movieCode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
}
