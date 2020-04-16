class CommonFiles{
  CommonFiles({
    this.groupsCount,
    this.questionsCount,
    this.iconsURL,
    this.empty,
  });

  final int groupsCount;
  final int questionsCount;
  final iconsURL;

  final Null empty;
  
  factory CommonFiles.fromMap(Map<String, dynamic> data, String documentID){
    if(data == null){
      return null;
    }

    final int groupsCount = data['groups_count'];
    final int questionsCount = data['questions_count'];
    final iconsURL = data['icons_url'];

    final Null empty = data['empty'];


    return CommonFiles(
      groupsCount: groupsCount,
      questionsCount:questionsCount,
      iconsURL:iconsURL,
      empty: empty,

    );
  }

  Map<String, dynamic> toMap(){
    return {
      groupsCount != null ? 'groups_count': 'empty' : groupsCount,
      questionsCount != null ? 'questions_count': 'empty' : questionsCount,
      iconsURL != null ? 'icons_url': 'empty' : iconsURL,

    };
  }
}