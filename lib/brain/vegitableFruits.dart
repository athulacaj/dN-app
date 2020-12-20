import 'package:daily_needs/brain/vegitableMap.dart';
import 'package:flutter/material.dart';
import 'package:daily_needs/brain/CakesAndIceCreams.dart';

Map vegFruitsInfo = {
  'Vegetables': vegetableMap,
  'Fruits': _fruitsMap,
  'Bakery': cakesMap
};

Map _fruitsMap = {
  'items': ambilyFruits,
  'shops': [
    {
      'name': 'Ambily Fruits',
      'image': 'assets/ambily.jpeg',
      'imageType': 'offline',
      'open': '9:00',
      'close': '9:00',
      'items': ambilyFruits
    },
  ]
};

List<Map> ambilyFruits = [
//    apple
  {
    'name': 'Misiri Apple',
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/fruits%2Fapple-min.jpg?alt=media&token=13d2e2f0-5b1f-4135-a5a9-c859903ce148',
    'color': Color(0xffFFE3E5).toString(),
    'imageType': 'online',
    'amount': 140,
    'quantity': 1,
    'unit': 'kg',
  },
  //APPLE NADAN
  {
    'name': 'Apple',
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/fruits%2Fapple-min.jpg?alt=media&token=13d2e2f0-5b1f-4135-a5a9-c859903ce148',
    'color': Color(0xffFFE3E5).toString(),
    'imageType': 'online',
    'amount': 120,
    'quantity': 1,
    'unit': 'kg',
  },
// APPLE NADA 2
  {
    'name': 'Apple Foreign',
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/fruits%2Fapple-min.jpg?alt=media&token=13d2e2f0-5b1f-4135-a5a9-c859903ce148',
    'color': Color(0xffFFE3E5).toString(),
    'imageType': 'online',
    'amount': 240,
    'quantity': 1,
    'unit': 'kg',
  },
  // orange
  {
    'name': 'Orange',
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/fruits%2Forange-min.jpg?alt=media&token=7bd561e3-110c-4eab-8eff-00069e4daabb',
    'color': Color(0xffFFE08E).toString(),
    'imageType': 'online',
    'amount': 60,
    'quantity': 1,
    'unit': 'kg',
  },
  // avocado
  // {
  //   'name': 'Avocado',
  //   'image':
  //       'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/fruits%2Favocados.jpg?alt=media&token=33b6e112-8e5e-4be7-a200-4ca53ddce2b0',
  //   'color': Color(0xffFFE08E).toString(),
  //   'imageType': 'online',
  //   'amount': 90,
  //   'quantity': 1,
  //   'unit': 'kg',
  // },

  // pomegranate
  {
    'name': 'Pomegranate',
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/fruits%2Fpromegranate-min.jpg?alt=media&token=277438b4-fae5-4efd-b6b1-5108f4444d20',
    'color': Color(0xffFFE3E5).toString(),
    'imageType': 'online',
    'amount': 120,
    'quantity': 1,
    'unit': 'kg',
  },
// mosambi Foreign
  {
    'name': 'Mosambi (New Zealand)',
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/fruits%2Fmosambi%20foreign-min.jpeg?alt=media&token=d29947f8-915a-42d5-b07e-2e025c1ea44b',
    'color': Color(0xffFFE08E).toString(),
    'imageType': 'online',
    'amount': 170,
    'available': true,
    'quantity': 1,
    'unit': 'kg',
  },
//    hybrid mosambi
  {
    'name': 'Mosambi Hybrid',
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/fruits%2Fhybrid%20mosambi-min.jpeg?alt=media&token=ec6d2769-63fe-4091-b83a-349fe6768f32',
    'color': Color(0xffFFE08E).toString(),
    'imageType': 'online',
    'amount': 60,
    'quantity': 1,
    'unit': 'kg',
  },
//green grapes
//  {
//    'name': 'Green Grapes',
//    'image':
//        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/fruits%2Fgreen%20grapes-min.jpeg?alt=media&token=facc7f39-c14d-42f0-b23a-52986a66c5b9',
//    'color': Color(0xffFFE08E).toString(),
//    'imageType': 'online',
//    'amount': 80,
//    'quantity': 1,
//    'unit': 'kg',
//    'available': false,
//  },
//    black Grapes
//  {
//    'name': 'Black Grapes',
//    'image':
//        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/fruits%2Fgrapes%20black-min.jpeg?alt=media&token=30ebd1d2-8461-4421-8085-74ff0cfa3d98',
//    'color': Color(0xffFFE08E).toString(),
//    'imageType': 'online',
//    'amount': 70,
//    'quantity': 1,
//    'unit': 'kg',
//  },
//    watermelon
  {
    'name': 'Watermelon',
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/fruits%2Fwatermelon-min.jpeg?alt=media&token=7184fd2a-87ee-446e-ba4c-d03ec1f8ec8d',
    'color': Color(0xffFFE08E).toString(),
    'imageType': 'online',
    'amount': 56,
    'quantity': 2,
    'unit': 'kg',
  },
//pineapple
  {
    'name': 'pineapple',
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/fruits%2Fpineapple-min.jpeg?alt=media&token=334afd58-6e44-431a-865f-b62d9595d9c3',
    'color': Color(0xffFFE08E).toString(),
    'imageType': 'online',
    'amount': 120,
    'quantity': 2,
    'unit': 'kg',
  },
//    mango romania
//  {
//    'name': 'Mango Romania',
//    'image':
//        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/fruits%2Fmango%20romania-min.jpeg?alt=media&token=e87e153a-d59a-49f7-8e45-25e9fe689b23',
//    'color': Color(0xffFFE08E).toString(),
//    'imageType': 'online',
//    'amount': 90,
//    'quantity': 1,
//    'unit': 'kg',
//    'available': false,
//  },
////    mango neelam
//  {
//    'name': 'Mango Neelam',
//    'image':
//        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/fruits%2Fmango%20neelam-min.jpeg?alt=media&token=3bd5d1c6-3e96-49cf-a1bd-c0994cbcfef3',
//    'color': Color(0xffFFE08E).toString(),
//    'imageType': 'online',
//    'amount': 90,
//    'quantity': 1,
//    'unit': 'kg',
//    'available': false,
//  },
////Passion Fruit
//  {
//    'name': 'Passion Fruit',
//    'image':
//        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/fruits%2Fpassion%20fruit-min.jpeg?alt=media&token=5668ad1e-a546-400a-9f21-aab3b920bf7d',
//    'color': Color(0xffFFE08E).toString(),
//    'imageType': 'online',
//    'amount': 100,
//    'quantity': 1,
//    'unit': 'kg',
//    'available': false,
//  },
];
