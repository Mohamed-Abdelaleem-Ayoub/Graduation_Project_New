import 'package:flutter/material.dart';
import 'package:graduation_project/constans.dart';
import 'package:graduation_project/models/consultant_model.dart';
import 'package:graduation_project/widgets/custom_specialist_card.dart';

class ConsultantPage extends StatelessWidget {
  static String id = 'ConsultantPage';
  const ConsultantPage({super.key});
  final List<ConsultantModel> consultantsList = const [
    ConsultantModel(
      name: 'سوزان الفضالي',
      description: 'أستاذ علم الاجتماع التربوي، خبيرة في مشاكل التربية',
      image: 'assets/images/Specialistimages/1.jpeg',
      address: 'مدينة نصر – شارع مكرم عبيد',
      phoneNumber: '01012567144',
    ),
    ConsultantModel(
      name: 'وائل فؤاد سليمان',
      description:
          'استشارى الطب النفسى و طب نفسى الاطفال والمراهقين وعلاج الادمان',
      image: 'assets/images/Specialistimages/2.jpeg',
      address: 'فيصل ٦٨أ شارع الملك فيصل الرئيسي ',
      phoneNumber: '0120111344',
    ),
    ConsultantModel(
      name: 'أحمد هارون',
      description: 'استشاري طب نفسي وتربوي،',
      image: 'assets/images/Specialistimages/3.jpeg',
      address: 'مصر الجديدة – شارع الثورة',
      phoneNumber: '01012567144',
    ),
    ConsultantModel(
      name: 'هالة منصور',
      description: 'أستاذ علم الاجتماع التربوي، خبيرة في مشاكل التربية',
      image: 'assets/images/Specialistimages/4.jpeg',
      address: 'مدينة نصر – شارع مكرم عبيد',
      phoneNumber: '01012567144',
    ),
    ConsultantModel(
      name: 'وليد هندي',
      description: 'استشاري الصحة النفسية والأسرية',
      image: 'assets/images/Specialistimages/5.jpeg',
      address: 'المعادي – شارع 9',
      phoneNumber: '01003008525',
    ),
    ConsultantModel(
      name: ' مايكل فيكتور',
      description: 'استشاري الطب النفسي و علاج الإدمان',
      image: 'assets/images/Specialistimages/6.jpeg',
      address: 'مصر الجديدة : شارع خليفة المأمون',
      phoneNumber: '16676',
    ),
    ConsultantModel(
      name: 'محمد طه',
      description: 'استشاري نفسي تربوي، مؤلف مشهور في مجال التربية النفسية',
      image: 'assets/images/Specialistimages/7.jpeg',
      address: 'الدقي – قرب نادي الصيد',
      phoneNumber: '01111154515',
    ),
    ConsultantModel(
      name: 'أحمد عمارة',
      description: 'مختص في الإرشاد النفسي والتربوي والعلاقات الأسرية',
      image: 'assets/images/Specialistimages/8.jpeg',
      address: ' القاهرة الجديدة – شارع التسعين',
      phoneNumber: '01022555528',
    ),
    ConsultantModel(
      name: 'نهى زكريا',
      description: 'معالجة نفسية وتربوية ',
      image: 'assets/images/Specialistimages/9.jpeg',
      address: 'مدينة نصر – عباس العقاد',
      phoneNumber: '01001554477',
    ),
    ConsultantModel(
      name: 'شيماء المصري',
      description: 'الإستشارات النفسية والارشاد الأسري والتربوي',
      image: 'assets/images/Specialistimages/10.jpeg',
      address: 'مصر  – القاهرة',
      phoneNumber: ' 010 65191852',
    ),
    ConsultantModel(
      name: 'محمد منصور',
      description: 'معالج نفسي تربوي للأطفال والمراهقين',
      image: 'assets/images/Specialistimages/11.jpeg',
      address: 'الدقي – ميدان المساحة',
      phoneNumber: '01221114455',
    ),
    ConsultantModel(
      name: 'عزة حسن',
      description: ' أخصائية تعديل سلوك وصحة نفسية تربوية',
      image: 'assets/images/Specialistimages/12.jpeg',
      address: 'مدينة نصر – التجمع الخامس  – اكتوبر',
      phoneNumber: '01020102602',
    ),
    ConsultantModel(
      name: 'نورهان الالفي',
      description: 'أخصائي علاج نفسيي',
      image: 'assets/images/Specialistimages/13.jpeg',
      address: 'مصر الجديدة: خليفة المأمون - روكسي عمارة كوين سنتر',
      phoneNumber: '46916',
    ),
    ConsultantModel(
      name: 'احمد عكاشة',
      description: 'استشارى الامراض النفسية وعلاج الادمان متخصص ',
      image: 'assets/images/Specialistimages/14.jpeg',
      address: 'القاهرة الجديدة حى البنفسج 2 التجمع الاول',
      phoneNumber: '229200901',
    ),
    ConsultantModel(
      name: ' ميرا يوسف',
      description: 'استشاري نفسي وأسري تربوي',
      image: 'assets/images/Specialistimages/15.jpeg',
      address: 'الجيزة، الدقي والمهندسين',
      phoneNumber: '16676',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // backgroundColor: kBackgroundColor,
        elevation: 0,

        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Consultant!',
              style: TextStyle(
                fontFamily: kFontFamily,
                color: Color(0xff333333),
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Icon(
                Icons.waving_hand_rounded,
                color: Colors.amber,
                size: 15,
              ),
            ),
          ],
        ),
        actions: const [
          Icon(Icons.settings),
          Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 16),
        child: GridView.builder(
          itemCount: consultantsList.length,
          clipBehavior: Clip.none,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 20,
            childAspectRatio: 200 / 370,
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            return ConsultantCard(consultant: consultantsList[index]);
          },
        ),
      ),
    );
  }
}
