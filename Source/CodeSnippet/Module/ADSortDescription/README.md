
# SortDescrition

A base protocol to all the sort descriptions of an app.

A sort description describes how two entities can be compared in more a flexible way than `Comparable`.

```swift
struct Person {
    let id: String
    let name: String
    let age: Int
}

extension SortDescription where T == Person {

    static func perName() -> SortDescription {
        SortDescription { lhs, rhs in
            [lhs.name, lhs.id].isInLocalizedIncreasingOrder(comparedTo: [rhs.name, rhs.id])
        }
    }

    static func perAge() -> SortDescription {
        SortDescription { lhs, rhs in
            if lhs.age == rhs.age {
                return [lhs.id].isInLocalizedIncreasingOrder(comparedTo: [rhs.id])
            }
            return lhs.age < rhs.age
        }
    }
}

```

- `SortDescription.swift`: The protocol definition.
- `Sequence+LocalizedOrder.swift` & `Sequence+SortDescription.swift`: helper extensions to lexicographically compared string sequences.
