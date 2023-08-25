import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kpostal/kpostal.dart';

class HospitalJoinScreen extends StatefulWidget {
  const HospitalJoinScreen({super.key});

  @override
  State<HospitalJoinScreen> createState() => _HospitalJoinScreenState();
}

class _HospitalJoinScreenState extends State<HospitalJoinScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController roomsController = TextEditingController();
  String? latitude, longitude;

  List<String> treatmentTypes = [];

  void _join() {
    if (latitude == null ||
        longitude == null ||
        nameController.text == '' ||
        roomsController.text == '') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Text('입력되지 않은 정보가 있습니다.'),
            actions: <Widget>[
              TextButton(
                child: const Text('확인'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      print(nameController.text);
      print(latitude);
      print(longitude);
      print(treatmentTypes);
      print(roomsController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('병원 등록 화면'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: '병원 이름'),
              ),
              TextField(
                controller: locationController,
                decoration: const InputDecoration(labelText: '병원 위치'),
                onTap: () async {
                  Kpostal? result = await Navigator.push(context,
                      MaterialPageRoute(builder: (_) => KpostalView()));

                  if (result != null) {
                    locationController.text =
                        result.address; // 검색 결과의 주소를 입력 필드에 표시
                    print(result.address);
                    print(result.postCode);
                    print(result.address);
                    print(result.jibunAddress);
                    print(result.latitude.toString());
                    print(result.longitude.toString());
                    latitude = result.latitude.toString();
                    longitude = result.longitude.toString();
                  }
                },
              ),
              const SizedBox(height: 20),
              const Text('진료 가능과 종류:'),
              CheckboxListTile(
                title: const Text('내과'),
                value: treatmentTypes.contains('내과'),
                onChanged: (value) {
                  setState(() {
                    if (value!) {
                      treatmentTypes.add('내과');
                    } else {
                      treatmentTypes.remove('내과');
                    }
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('외과'),
                value: treatmentTypes.contains('외과'),
                onChanged: (value) {
                  setState(() {
                    if (value!) {
                      treatmentTypes.add('외과');
                    } else {
                      treatmentTypes.remove('외과');
                    }
                  });
                },
              ),
              TextField(
                controller: roomsController,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: const InputDecoration(labelText: '응급실 가용병수'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _join();
                },
                child: const Text('응급실 등록'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
