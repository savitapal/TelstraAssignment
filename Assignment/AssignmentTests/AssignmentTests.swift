//
//  AssignmentTests.swift
//  AssignmentTests
//
//  Created by test on 26/07/19.
//  Copyright © 2019 test. All rights reserved.
//

import XCTest
@testable import Assignment

class AssignmentTests: XCTestCase {

    let objViewController = ViewController()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        objViewController.setUpViews()
        objViewController.refreshCollectionView()
    }

    func testCollectionViewDateSourceDelegate() {
        XCTAssertTrue(objViewController.conforms(to: UICollectionViewDataSource.self))
        XCTAssertTrue(objViewController.conforms(to: UICollectionViewDelegate.self))
        XCTAssertTrue(objViewController.responds(to:
            #selector(objViewController.collectionView(_:numberOfItemsInSection:))))
        XCTAssertTrue(objViewController.responds(to:
            #selector(objViewController.collectionView(_:cellForItemAt:))))
    }
    
    func testCollectionViewCellHasReuseIdentifier() {
        let cell = objViewController.collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: IndexPath(row: 0, section: 0))
        let actualReuseIdentifer = cell.reuseIdentifier
        let expectedReuseIdentifier = "cell"
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }
    
}
