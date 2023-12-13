class FaceBookUser {
  late String email;
  late int id;
  late String name;
  late PictureData pictureData;
  FaceBookUser.fromMap(Map<String, dynamic> userMap) {
    email = userMap['email'];
    id = int.parse(userMap['id']);
    name = userMap['name'];
    pictureData = PictureData.fromMap(userMap['picture']['data']);
  }
}

class PictureData {
  late double height;
  late double width;
  late bool isSilhouette;
  late String url;

  PictureData.fromMap(Map<String, dynamic> picture) {
    height = double.parse(picture['height'].toString());
    width = double.parse(picture['width'].toString());
    isSilhouette = picture['is_silhouette'] == 0;
    url = picture['url'];
  }
}

/* {
    "email" = "dsmr.apps@gmail.com",
    "id" = 3003332493073668,
    "name" = "Darwin Morocho",
    "picture" = {
        "data" = {
            "height" = 50,
            "is_silhouette" = 0,
            "url" = "https://platform-lookaside.fbsbx.com/platform/profilepic/?asid=3003332493073668",
            "width" = 50,
        },
    }
}
 */
