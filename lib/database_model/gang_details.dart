class GangDetails{
  GangDetails({
    this.gangID,
    this.gangName,
    this.gangCode,
    this.gangIconURL,

    this.empty,
  });

  final String gangID;
  final String gangName;
  final int gangCode;
  final String gangIconURL;

  final Null empty;

  factory GangDetails.fromMap(Map<String, dynamic> data, String documentID){
    if(data == null){
      return null;
    }

    final String gangID = documentID;


    final String gangName = data['gang_name'];
    final int gangCode = data['gang_code'];
    final String gangIconURL = data['gang_icon_url'];
    final Null empty = data['empty'];


    return GangDetails(
      gangID: gangID,
      gangName:gangName,
      gangCode:gangCode,
      gangIconURL:gangIconURL,
      empty: empty,

    );
  }

  Map<String, dynamic> toMap(){
    return {
      gangName != null ? 'gang_name': 'empty' : gangName,
      gangCode != null ? 'gang_code': 'empty' : gangCode,
      gangIconURL != null ? 'gang_icon_url': 'empty' : gangIconURL,

    };
  }
}