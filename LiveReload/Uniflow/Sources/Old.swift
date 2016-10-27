public protocol Updateable: class {

    func update()

    func enumerateUpdateableChildren() -> AnySequence<Updateable>

}

public extension Updateable {

}


public class Tag {
    
    public static let root = Tag("<root>")
    
    public let name: String
    
    public let changeNotificationName: String
    
    public init(_ name: String) {
        self.name = name
        changeNotificationName = "\(name).didChange"
    }
    
}

extension Tag: CustomStringConvertible {
    public var description: String {
        return name
    }
}

extension Tag: Hashable {
    public var hashValue: Int {
        return name.hashValue
    }
}

public func ==(lhs: Tag, rhs: Tag) -> Bool {
    return (lhs.name == rhs.name)
}



public protocol Identity: CustomStringConvertible {
    
    func isEqualTo(other: Identity) -> Bool
    
    var hashValue: Int { get }
    
}

public extension Identity where Self: Equatable {
    
    public func isEqualTo(other: Identity) -> Bool {
        if other.dynamicType == Self.self {
            return self == (other as! Self)
        } else {
            return false
        }
    }
    
}

public func ==(lhs: Identity, rhs: Identity) -> Bool {
    return lhs.isEqualTo(rhs)
}


/// A box for putting identities in collections
public struct AnyIdentity: Hashable {
    
    public let identity: Identity
    
    public init(identity: Identity) {
        self.identity = identity
    }
    
    public var hashValue: Int {
        return identity.hashValue
    }
    
}

public func ==(lhs: AnyIdentity, rhs: AnyIdentity) -> Bool {
    return lhs.identity == rhs.identity
}


public struct StringIdentity: Identity {
    
    public let name: String
    
    public init(_ name: String) {
        self.name = name
    }
    
    public var description: String {
        return name
    }
    
}

extension StringIdentity: Hashable {
    public var hashValue: Int {
        return name.hashValue
    }
}

public func ==(lhs: StringIdentity, rhs: StringIdentity) -> Bool {
    return (lhs.name == rhs.name)
}


public protocol Identifiable: class {
    
    var uniqueIdentifier: String { get }
    
}