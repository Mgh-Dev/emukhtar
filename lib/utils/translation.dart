// lib/utils/translation.dart
class AppLocalizations {
  final String locale;

  AppLocalizations(this.locale);

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title': 'Mukhtar',
      'name': 'Michel Assaad Al-Howeiss',
      'position': 'Mukhtar of Mar Mikhael Binabil',
      'phone': '+961 70 343 679',
      'address_label': 'Office Address:',
      'address': 'Wata El Mrouj, Farai Street, Tannous Al-Howeiss Building',
      'office_location': 'Office Location',
      'open_in_google_maps': 'Open in Google Map',
    },
    'ar': {
      'title': 'المختار',
      'name': 'ميشال أسد الحويس',
      'position': ' مختار مار ميخائيل بنابيل',
      'phone': '+961 70 343 679',
      'address_label': ': عنوان المكتب',
      'address': 'وطى المروج، شارع الفرعي، بناية طانيوس الحويس',
      'office_location': 'موقع المكتب',
      'open_in_google_maps': 'فتح في Google Map',
    },
  };

  String t(String key) => _localizedValues[locale]?[key] ?? key;
}
