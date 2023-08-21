import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String? injuryType;
  String? severity;

  //실제 부상과 중증도 리스트로 변경
  List<String> injuryList = ['부상1', '부상2', '부상3', '부상4'];
  List<String> severityList = ['중증도1', '중증도2', '중증도3', '중증도4'];

  void _searchMap(String? injurytype, String? severity) {
    if (severity == null || injuryType == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Text('중증도와 부상 종류를 선택하세요.'),
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
      Navigator.pushNamed(context, '/map_screen');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('상세 화면'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: injuryType,
              hint: const Text('부상 종류 선택'),
              onChanged: (value) {
                setState(() {
                  injuryType = value;
                });
              },
              items: injuryList.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            DropdownButton<String>(
              value: severity,
              hint: const Text('중증도 선택'),
              onChanged: (value) {
                setState(() {
                  severity = value;
                });
              },
              items: severityList.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _searchMap(injuryType, severity);
              },
              child: const Text('병원 탐색'),
            ),
          ],
        ),
      ),
    );
  }
}
