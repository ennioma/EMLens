//
//  Entities.swift
//  EMLens
//
//  Created by Ennio Masi on 20/05/2017.
//  Copyright © 2017 ennioma. All rights reserved.
//

import Foundation

struct Actor {
    let name: String
    let surname: String
}

extension Actor {
    struct Lenses {
        static let name = Lens<Actor, String>(
            get: {$0.name},
            set: {(value, me) in Actor(name: value, surname: me.surname) }
        )
        static let surname = Lens<Actor, String>(
            get: {$0.surname},
            set: {(value, me) in Actor(name: me.name, surname: value) }
        )
    }
}

struct Movie {
    let title: String
    let mainActor: Actor
}

extension Movie {
    struct Lenses {
        static let actor = Lens<Movie, Actor>(get: { (movie) -> Actor in
            return movie.mainActor
        }, set: { (actor, me) -> Movie in
            return Movie(title: me.title, mainActor: actor)
        })
    }
}
