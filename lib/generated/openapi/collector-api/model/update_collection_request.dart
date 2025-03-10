//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:collector/generated/openapi/collector-api/model/collection_visibility_enum.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_collection_request.g.dart';

/// Stores information about the items in each user's collection.
///
/// Properties:
/// * [name] - The name of the collection (e.g., \"Science Fiction Books\", \"Marvel Movies\").
/// * [description] - A brief description of the collection.
/// * [visibility]
@BuiltValue()
abstract class UpdateCollectionRequest
    implements Built<UpdateCollectionRequest, UpdateCollectionRequestBuilder> {
  /// The name of the collection (e.g., \"Science Fiction Books\", \"Marvel Movies\").
  @BuiltValueField(wireName: r'name')
  String get name;

  /// A brief description of the collection.
  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'visibility')
  CollectionVisibilityEnum get visibility;
  // enum visibilityEnum {  PRIVATE,  PUBLIC,  };

  UpdateCollectionRequest._();

  factory UpdateCollectionRequest(
          [void updates(UpdateCollectionRequestBuilder b)]) =
      _$UpdateCollectionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateCollectionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateCollectionRequest> get serializer =>
      _$UpdateCollectionRequestSerializer();
}

class _$UpdateCollectionRequestSerializer
    implements PrimitiveSerializer<UpdateCollectionRequest> {
  @override
  final Iterable<Type> types = const [
    UpdateCollectionRequest,
    _$UpdateCollectionRequest
  ];

  @override
  final String wireName = r'UpdateCollectionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateCollectionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      );
    }
    yield r'visibility';
    yield serializers.serialize(
      object.visibility,
      specifiedType: const FullType(CollectionVisibilityEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateCollectionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateCollectionRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        case r'visibility':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CollectionVisibilityEnum),
          ) as CollectionVisibilityEnum;
          result.visibility = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateCollectionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateCollectionRequestBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}
