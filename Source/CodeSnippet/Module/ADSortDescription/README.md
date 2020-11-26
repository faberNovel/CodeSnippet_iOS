
# SortDescrition

A base protocol to all the sort descriptions of an app.

A sort description describes how two entities can be compared in more a flexible way than `Comparable`.

```swift
struct Person {
    let id: String
    let name: String
    let age: Int
}

struct PerNamePersonSortDescription: SortDescription {

    func areInIncreasingOrder(_ lhs: Person, _ rhs: Person) -> Bool {
        [lhs.name, lhs.id].isInLocalizedIncreasingOrder(comparedTo: [rhs.name, rhs.id])
    }
}

struct PerAgePersonSortDescription: SortDescription {

    func areInIncreasingOrder(_ lhs: Person, _ rhs: Person) -> Bool {
        if lhs.age == rhs.age {
            return [lhs.id].isInLocalizedIncreasingOrder(comparedTo: [rhs.id])
        }
        return lhs.age < rhs.age
    }
}

```

- `SortDescription.swift`: The protocol definition.
- `Sequence+LocalizedOrder.swift` & `Sequence+SortDescription.swift`: helper extensions to lexicographically compared string sequences.
