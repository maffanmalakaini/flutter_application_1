import 'package:flutter/material.dart';
import 'package:rumah_sehat/services/api_service.dart';
import 'package:rumah_sehat/widgets/future_list_page.dart';

class InfoBedScreen extends StatelessWidget {
  const InfoBedScreen({super.key});
  @override
  Widget build(BuildContext c) => FutureListPage(Icons.bed, 'Info Bed', ApiService.fetchBed);
}