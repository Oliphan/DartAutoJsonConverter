/// Marks a type for which a JsonConverter should be generated.
///
/// The type must define the following factory and method respectively:
///   - `factory TypeName.fromJson(Map<String, dynamic>)`
///   - `Map<String, dynamic> toJson()`
class AutoJsonConverter {
  const AutoJsonConverter();
}
