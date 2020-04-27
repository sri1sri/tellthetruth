class CommonFiles{
  CommonFiles({
    this.iconsURL,
    this.appVersion,
    this.isAppUpdated,
    this.underMaintenance,
    this.empty,
  });

  final iconsURL;
  final String appVersion;
  final bool isAppUpdated;
  final bool underMaintenance;
  final Null empty;
  
  factory CommonFiles.fromMap(Map<String, dynamic> data, String documentID){
    if(data == null){
      return null;
    }

    final iconsURL = data['icons_url'];
    final String appVersion = data['app_version'];
    final bool isAppUpdated = data['is_app_updated'];
    final bool underMaintenance = data['under_maintenance'];

    final Null empty = data['empty'];


    return CommonFiles(
      iconsURL:iconsURL,
      appVersion: appVersion,
      isAppUpdated: isAppUpdated,
      underMaintenance: underMaintenance,
      empty: empty,

    );
  }

  Map<String, dynamic> toMap(){
    return {
      iconsURL != null ? 'icons_url': 'empty' : iconsURL,
      appVersion != null ? 'app_version': 'empty' : appVersion,
      isAppUpdated != null ? 'is_app_updated': 'empty' : isAppUpdated,
      underMaintenance != null ? 'under_maintenance': 'empty' : underMaintenance,
    };
  }
}