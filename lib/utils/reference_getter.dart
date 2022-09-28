String getReference(
    {required int yearResultIndex,
    required bool isFirstSemester,
    required String courseUniqueID}) {
  return 'Y-$yearResultIndex S-${isFirstSemester ? 1 : 2} C-$courseUniqueID';
}
