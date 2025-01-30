String extractId(String id) {
  id = id.replaceAll('http://id.who.int/icd/entity/', '');
  return id;
}
