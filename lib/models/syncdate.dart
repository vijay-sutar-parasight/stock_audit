class SyncDate{
  final int? syncId;
  final String? syncCode;
  final String? syncDate;

  SyncDate({this.syncId, required this.syncCode, required this.syncDate});

  SyncDate.fromMap(Map<String, dynamic> res):
        syncId = res['sync_id'],
        syncCode = res['sync_code'],
        syncDate = res['sync_date'];

Map<String, Object?> toMap(){
  return{
    'sync_id' : syncId,
    'sync_code' : syncCode,
    'sync_date' : syncDate,
  };
}
}