//
//  Mappable.swift
//  ObjectMapper
//
//  Created by Scott Hoyt on 10/25/15.
//  Copyright © 2015 hearst. All rights reserved.
//

import Foundation

/// BaseMappable should not be implemented directly. Mappable or StaticMappable should be used instead
public protocol BaseMappable {
	/// This function is where all variable mappings should occur. It is executed by Mapper during the mapping (serialization and deserialization) process.
	mutating func mapping(map: Map)
}

public protocol Mappable: BaseMappable {
    /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
    init?(map: Map)
}

public protocol StaticMappable: BaseMappable {
	/// This is function that can be used to:
	///		1) provide an existing cached object to be used for mapping
	///		2) return an object of another class (which conforms to Mappable) to be used for mapping. For instance, you may inspect the JSON to infer the type of object that should be used for any given mapping
	static func objectForMapping(map: Map) -> BaseMappable?
}

public extension BaseMappable {
	
	/// Initializes object from a JSON String
	public init?(JSONString: String, context: MapContext? = nil) {
		if let obj: Self = Mapper(context: context).map(JSONString: JSONString) {
			self = obj
		} else {
			return nil
		}
	}
	
	/// Initializes object from a JSON Dictionary
	public init?(JSON: [String: Any], context: MapContext? = nil) {
		if let obj: Self = Mapper(context: context).map(JSON: JSON) {
			self = obj
		} else {
			return nil
		}
	}
	
	/// Returns the JSON Dictionary for the object
	public func toJSON() -> [String: Any] {
		return Mapper().toJSON(self)
	}
	
	/// Returns the JSON String for the object
	public func toJSONString(prettyPrint: Bool = false) -> String? {
		return Mapper().toJSONString(self, prettyPrint: prettyPrint)
	}
}

public extension Array where Element: BaseMappable {
	
	/// Initialize Array from a JSON String
	public init?(JSONString: String, context: MapContext? = nil) {
		if let obj: [Element] = Mapper(context: context).mapArray(JSONString: JSONString) {
			self = obj
		} else {
			return nil
		}
	}
	
	/// Initialize Array from a JSON Array
	public init?(JSONArray: [[String: Any]], context: MapContext? = nil) {
		if let obj: [Element] = Mapper(context: context).mapArray(JSONArray: JSONArray) {
			self = obj
		} else {
			return nil
		}
	}
	
	/// Returns the JSON Array
	public func toJSON() -> [[String: Any]] {
		return Mapper().toJSONArray(self)
	}
	
	/// Returns the JSON String for the object
	public func toJSONString(prettyPrint: Bool = false) -> String? {
		return Mapper().toJSONString(self, prettyPrint: prettyPrint)
	}
}

public extension Set where Element: BaseMappable {
	
	/// Initializes a set from a JSON String
	public init?(JSONString: String, context: MapContext? = nil) {
		if let obj: Set<Element> = Mapper(context: context).mapSet(JSONString: JSONString) {
			self = obj
		} else {
			return nil
		}
	}
	
	/// Initializes a set from JSON
	public init?(JSONArray: [[String: Any]], context: MapContext? = nil) {
		guard let obj = Mapper(context: context).mapSet(JSONArray: JSONArray) as Set<Element>? else {
            return nil
        }
		self = obj
	}
	
	/// Returns the JSON Set
	public func toJSON() -> [[String: Any]] {
		return Mapper().toJSONSet(self)
	}
	
	/// Returns the JSON String for the object
	public func toJSONString(prettyPrint: Bool = false) -> String? {
		return Mapper().toJSONString(self, prettyPrint: prettyPrint)
	}
}
