abstract class AssociationServiceInterface {
  Future subscribeToAssociation(String associationId, String userId);
  Future unsubscribeToAssociation(String associationId, String userId);
}
