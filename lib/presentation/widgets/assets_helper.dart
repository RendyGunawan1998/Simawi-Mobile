class AssetsHelper {
  static String icRS = icon("ic_rs.png");
  static String icDokter = icon("ic_dokter.png");
  static String icAdmin = icon("ic_admin.png");
  static String icPasien = icon("ic_pasien.png");
  static String icBin = icon("bin.png");
  static String icEditing = icon("editing.png");
// icons
  // static String imgProfile = img("profile.png");

  static String icon(String name) {
    return "assets/icons/$name";
  }

  static String img(String name) {
    return "assets/images/$name";
  }
}
