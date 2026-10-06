import 'package:flutter/material.dart';
import 'package:rumah_sehat/services/api_service.dart';
import 'package:rumah_sehat/widgets/future_list_page.dart';

class InfoPoliScreen extends StatelessWidget {
  const InfoPoliScreen({super.key});
  @override
  Widget build(BuildContext c) =>
      FutureListPage(Icons.local_hospital_outlined, 'Info Poli', ApiService.fetchPoli);
}