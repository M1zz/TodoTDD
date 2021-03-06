//
//  DetailViewControllerTests.swift
//  TodoTDDTests
//
//  Created by 이현호 on 2021/03/05.
//  Copyright © 2021 tempYsoup. All rights reserved.
//

import XCTest
import CoreLocation
@testable import TodoTDD

class DetailViewControllerTests: XCTestCase {
  
  var detailViewController: DetailViewController!
  
  override func setUp() {
    super.setUp()
    
    let storyboard = UIStoryboard(name: Constants.MainBundleIdentifer, bundle: nil)
    detailViewController = (storyboard.instantiateViewController(withIdentifier: Constants.DetailViewControllerIdentifier) as! DetailViewController)
    
    detailViewController.loadViewIfNeeded()
  }
  
  override func tearDown() {
    detailViewController.item = nil
    
    super.tearDown()
  }
  
  func test_init_hasTitleLabel() {
    XCTAssertTrue(detailViewController.titleLabel.isDescendant(of: detailViewController.view))
  }
  
  func test_init_hasLocationLabel() {
    XCTAssertTrue(detailViewController.locationLabel.isDescendant(of: detailViewController.view))
  }
  
  func test_init_hasMapView() {
    XCTAssertTrue(detailViewController.mapView.isDescendant(of: detailViewController.view))
  }
  
  func test_viewDidLoad_givenItem_hasItem() {
    let coordinate = CLLocationCoordinate2DMake(1.0,
                                                2.0)
    let timestamp = 1456095600.0
    let testItem = ToDoItem(title: "Foo",
                            itemDescription: "Bar",
                            timeStamp: timestamp,
                            location: Location(name: "Infinite Loop 1, Cupertino",
                                               coordinate: coordinate))
    
    detailViewController.item = testItem
    
    detailViewController.viewDidLoad()
    
    XCTAssertEqual(detailViewController.titleLabel.text, testItem.title)
    XCTAssertEqual(detailViewController.locationLabel.text, testItem.location!.name)
    XCTAssertEqual(ceil(detailViewController.mapView.centerCoordinate.latitude), testItem.location!.coordinate!.latitude)
    XCTAssertEqual(ceil(detailViewController.mapView.centerCoordinate.longitude), testItem.location!.coordinate!.longitude)
  }
}
