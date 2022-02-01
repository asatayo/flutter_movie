class Torrent {
  final String url;
  final String hash;
  final String quality;
  final String type;
  final int seeds;
  final int peers;
  final String size;
  final int sizeBytes;
  final String dateUploaded;
  final int dateUploadedUnix;
  Torrent({required this.url, required this.hash, required this.quality, required this.type, required this.seeds, required this.peers, required this.size, required this.sizeBytes, required this.dateUploaded, required this.dateUploadedUnix,});
   factory Torrent.fromJson(Map<String, dynamic> json) {
     return Torrent( 
       url: json['url'], 
       hash: json['hash'],
       quality: json['quality'], 
       type: json['type'], 
       seeds: json['seeds'], 
       peers: json['peers'], 
       size: json['size'],
       sizeBytes: json['size_bytes'], 
       dateUploaded: json['date_uploaded'], 
       dateUploadedUnix: json['date_uploaded_unix']
     );
   }
}
