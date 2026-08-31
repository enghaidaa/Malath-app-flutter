class EndPoints {
  static const String baseUrl = 'http://10.0.2.2:3000';

  static const String health = '/health';

  static const String quranSurahs = '/api/v1/quran/surahs';

  static String quranSurahById(int id) => '/api/v1/quran/surahs/$id';

  static const String azkar = '/api/v1/azkar';

  static String azkarByCategory(String category) =>
      '/api/v1/azkar/category/$category';

  static const String prayerTimings = '/api/v1/prayers/timings';
}
