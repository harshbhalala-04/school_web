import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:school_web/model/blueprint_model.dart';

class PaperGenerateController extends GetxController {
  final testPaperName = ''.obs;
  final className = ''.obs;
  final subjectName = ''.obs;
  final time = ''.obs;
  final instruction = ''.obs;
  List<BluePrint> blueprint =[];
  

  getBlueprint({className,subjectName}) async{
    List<Map> blueprintMap = <Map>[];
      await FirebaseFirestore.instance
      .collection('Blueprint')
      .where('Class',isEqualTo: className.toString())
      .where('SubjectName',isEqualTo: subjectName.toString())
      .get().then((value) {
        value.docs.forEach((element) {
          // BluePrint bluePrint = blueprint.
          // blueprint.add()
          element.exists ?
          blueprintMap.add({
            'id' : element.id,
            'BlueprintName' : element.data()['BluePrintName'],
            'Class' : element.data()['Class'],
            'SubjectName' : element.data()['SubjectName'],
            
          }) : blueprintMap=<Map>[];
          print(blueprintMap);
        }); 
      });
  }
}