//
//  ItemListViewControllerTests.swift
//  TodoTDDTests
//
//  Created by 이현호 on 2020/07/01.
//  Copyright © 2020 tempYsoup. All rights reserved.
//

import XCTest
@testable import TodoTDD

class ItemListViewControllerTests: XCTestCase {
    // import test controller view
    var itemListViewController: ItemListViewController!
    
    // setup
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        itemListViewController = storyboard.instantiateViewController(withIdentifier: "ItemListViewController") as! ItemListViewController
        
        itemListViewController.loadViewIfNeeded()
    }
    
    // tearDowm
    override class func tearDown() {
        super.tearDown()
    }
    
    /**
        1. itemListViewController에 테이블 뷰가 있는가?
        2. Add 버튼의 타겟이 itemListViewController인가?
        3. Add 버튼을 눌렀을 때 InputViewController가 나타나는가?
        4. inputViewController와 ItemListViewController는 ItemManager를 공유하는가?
     */
    
    // Do itemListViewController have an tableview?
    func test_init_hasTableView() {
        XCTAssert(itemListViewController.tableView.isDescendant(of: itemListViewController.view))
    }
    
    func test_init_itemListViewController_hasAddBarButtonWithSelfAsTarget() {
        XCTAssertNil(itemListViewController.presentedViewController)
        
        _test_performAddItem()
        
        XCTAssertNotNil(itemListViewController.presentedViewController)
        XCTAssertTrue(itemListViewController.presentedViewController is InputViewController)
        
    }
    
    private func _test_performAddItem() {
      guard let addItemButton = itemListViewController.navigationItem.rightBarButtonItem else {
        return XCTFail()
      }
      guard let action = addItemButton.action else {
        return XCTFail()
      }
      
      // set item list view controller as root so that it is visible in view hierachy
      UIApplication.shared.keyWindow?.rootViewController = itemListViewController
      
      itemListViewController.performSelector(onMainThread: action,
                                             with: addItemButton,
                                             waitUntilDone: true)
    }
    
}
