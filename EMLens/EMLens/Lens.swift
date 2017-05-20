public struct Lens<Container, View> {
    public let get: (Container) -> View
    public let set: (View, Container) -> Container
}

precedencegroup ComposePrecedence {
    associativity: left
}

infix operator >>> : ComposePrecedence

func >>> <Container, View, Subview>(lhs: Lens<Container, View>, rhs: Lens<View, Subview>) -> Lens<Container, Subview> {
    return Lens(get: { rhs.get(lhs.get($0)) },
                set: { (c, a) in return lhs.set(rhs.set(c, lhs.get(a)), a) }
    )
}

//let a = Actor(name: "Ennio", surname: "Masi")
//let l1 = Actor.Lenses.name.get(a)
//let l2 = Actor.Lenses.surname.get(a)
//
//Actor.Lenses.name.set(Actor.Lenses.name.get(a), a).name
//
//let m = Movie(title: "movie01", actor: a)
//
//print(m.actor)
//print(m.title)
//
//let l3 = Movie.Lenses.actor >>> Actor.Lenses.surname
//let m2 = l3.set("ciao", m)
//
//print(m2.actor)
//print(m2.title)
//let a = Actor(name: "George", surname: "Clooney")
//let m = Movie(title: "A beautiful movie", actor: a)
//print(m.actor) // George Clooney
//print(m.title) // A beautiful movie
//let l3 = Movie.Lenses.actor >>> Actor.Lenses.surname
//let m2 = l3.set("Pitt", m)
//print(m2.actor) // George Pitt
//print(m2.title) // A Beautiful movie
