//
//  EMLensTests.swift
//  EMLensTests
//
//  Created by Ennio Masi on 20/05/2017.
//  Copyright © 2017 ennioma. All rights reserved.
//

import XCTest
@testable import EMLens

class EMLensTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    /*
     Lens.get(Lens.set(Va, C)) == Va
     */
    func testLaw01() {
        let actor = Actor(name: "Brad", surname: "Pitt")

        XCTAssertEqual(Actor.Lenses.name.get(Actor.Lenses.name.set("Ennio", actor)), "Ennio")
    }

    /*
     Lens.set(Lens.get(Va), C) == C
     */
    func testLaw02() {
        let oldName = "Brad"
        let actor = Actor(name: oldName, surname: "Pitt")
        
         let updatedName = Actor.Lenses.name.set(Actor.Lenses.name.get(actor), actor)
        
        XCTAssertEqual(Actor.Lenses.name.get(updatedName), oldName)
    }
    
    /*
     Lens.set(Vb, Lens.set(Va, C)) == Lens.set(Vb, C)
     */
    func testLaw03() {
        let actor = Actor(name: "Brad", surname: "Pitt")
        
        let movie = Movie(title: "Awesome movie", mainActor: actor)
        
        let l3 = Movie.Lenses.actor >>> Actor.Lenses.name
        let result = l3.set("Ennio", movie)
        
        XCTAssertEqual(result.mainActor.name, "Ennio")
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
