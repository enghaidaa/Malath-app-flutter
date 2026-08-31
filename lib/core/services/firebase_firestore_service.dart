import 'package:cloud_firestore/cloud_firestore.dart';

import '../errors/exceptions.dart';

class FirebaseFirestoreService {
  final FirebaseFirestore _firestore;

  FirebaseFirestoreService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> addData({
    required String collectionPath,
    required Map<String, dynamic> data,
    String? documentId,
  }) async {
    try {
      if (documentId != null) {
        await _firestore
            .collection(collectionPath)
            .doc(documentId)
            .set(data);
      } else {
        await _firestore.collection(collectionPath).add(data);
      }
    } on FirebaseException catch (error) {
      throw FirestoreException(error.message ?? 'Failed to add data');
    } catch (_) {
      throw FirestoreException('Failed to add data');
    }
  }

  Future<Map<String, dynamic>?> getData({
    required String collectionPath,
    required String documentId,
  }) async {
    try {
      final document =
          await _firestore.collection(collectionPath).doc(documentId).get();

      if (!document.exists) {
        return null;
      }

      return document.data();
    } on FirebaseException catch (error) {
      throw FirestoreException(error.message ?? 'Failed to get data');
    } catch (_) {
      throw FirestoreException('Failed to get data');
    }
  }

  Future<void> updateData({
    required String collectionPath,
    required String documentId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _firestore
          .collection(collectionPath)
          .doc(documentId)
          .update(data);
    } on FirebaseException catch (error) {
      throw FirestoreException(error.message ?? 'Failed to update data');
    } catch (_) {
      throw FirestoreException('Failed to update data');
    }
  }

  Future<void> deleteData({
    required String collectionPath,
    required String documentId,
  }) async {
    try {
      await _firestore.collection(collectionPath).doc(documentId).delete();
    } on FirebaseException catch (error) {
      throw FirestoreException(error.message ?? 'Failed to delete data');
    } catch (_) {
      throw FirestoreException('Failed to delete data');
    }
  }
}
