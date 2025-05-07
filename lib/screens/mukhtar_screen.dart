import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/translation.dart'; // Import your translation file

class MukhtarScreen extends StatefulWidget {
  final String locale; // 'en' or 'ar'

  const MukhtarScreen({super.key, required this.locale});

  @override
  State<MukhtarScreen> createState() => _MukhtarScreenState();
}

class _MukhtarScreenState extends State<MukhtarScreen> {
  late GoogleMapController mapController;
  final LatLng _officeLocation = const LatLng(33.911727, 35.745657);
  final Set<Marker> _markers = {};
  late AppLocalizations t;

  @override
  void initState() {
    super.initState();
    t = AppLocalizations(widget.locale);
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId('office'),
          position: _officeLocation,
          infoWindow: InfoWindow(
            title: t.t('title'),
            snippet: t.t('address'),
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    });
  }

  void _callPhoneNumber() async {
    final phoneNumber = 'tel:${t.t('phone')}';
    if (await canLaunchUrl(Uri.parse(phoneNumber))) {
      await launchUrl(Uri.parse(phoneNumber));
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isArabic = widget.locale == 'ar';

    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          t.t('title'),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Directionality(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Section
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            t.t('name'),
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          Text(
                            t.t('position'),
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          const SizedBox(height: 15),
                          GestureDetector(
                            onTap: _callPhoneNumber,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  t.t('phone'),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(Icons.phone, color: Colors.blue, size: 20),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            t.t('address_label'),
                            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.right,
                          ),
                          const SizedBox(height: 15),
                          Text(
                            t.t('address'),
                            style: const TextStyle(fontSize: 16),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      width: 150,
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[300],
                        image: const DecorationImage(
                          image: AssetImage('assets/mukhtar_profile.jpg'),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                          color: const Color(0xFF075E54),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Map Section
                Column(
                  children: [
                    Text(
                      t.t('office_location'),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF075E54),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: const Color(0xFF075E54),
                          width: 2,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child: GoogleMap(
                          onMapCreated: _onMapCreated,
                          initialCameraPosition: CameraPosition(
                            target: _officeLocation,
                            zoom: 15,
                          ),
                          markers: _markers,
                          myLocationEnabled: true,
                          myLocationButtonEnabled: true,
                          compassEnabled: true,
                          zoomControlsEnabled: false,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.directions, color: Colors.white),
                      label: Text(
                        t.t('open_in_google_maps'),
                        style: const TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF075E54),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        final url = Uri.parse(
                          'https://www.google.com/maps/search/?api=1&query=${_officeLocation.latitude},${_officeLocation.longitude}',
                        );
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
