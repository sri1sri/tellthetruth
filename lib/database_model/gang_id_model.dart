class GangCode{
  GangCode({
    this.groupID,
    this.empty,
  });

  final int groupID;
  final Null empty;
  
  
  factory GangCode.fromMap(Map<String, dynamic> data, String documentID){
    if(data == null){
      return null;
    }

    final int groupID = data['group_id'];
    final Null empty = data['empty'];


    return GangCode(
      groupID: groupID,
      empty: empty,

    );
  }

  Map<String, dynamic> toMap(){
    return {
      groupID != null ? 'group_id': 'empty' : groupID,
    };
  }
}