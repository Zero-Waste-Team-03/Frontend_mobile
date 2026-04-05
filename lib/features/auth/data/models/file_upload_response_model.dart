import 'package:equatable/equatable.dart';

class FileUploadResponseModel extends Equatable {
  final String? id;
  final String? url;
  final String? jobId;

  const FileUploadResponseModel({this.id, this.url, this.jobId});

  factory FileUploadResponseModel.fromJson(Map<String, dynamic> json) {
    // Handle nested response structure: {success, timeStamp, data: {attachmentId, jobId}}
    final data = json['data'] as Map<String, dynamic>?;

    return FileUploadResponseModel(
      id: data?['attachmentId'] as String? ?? json['id'] as String?,
      url: data?['url'] as String? ?? json['url'] as String?,
      jobId: data?['jobId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'url': url, 'jobId': jobId};
  }

  @override
  List<Object?> get props => [id, url, jobId];
}
