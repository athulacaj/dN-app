import 'package:daily_needs/brain/restaurants/vkp.dart';

import 'amummaKitchen.dart';
import 'coconut.dart';
import 'greenPark.dart';

Map restaurants = {
  'items': [],
  'shops': [
    {
      'name': "Black Bowl",
      'image':
          'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/restaurants%20%2FBlack%20bowl%2FWhatsApp%20Image%202020-09-25%20at%204.29.12%20PM.jpeg?alt=media&token=ff26e6f7-b91c-486b-a91b-a06cc41537bb',
      'imageType': 'online',
      'open': '9:00',
      'close': '19:00',
      'automatic': true,
      'items': blackBowl,
      'subCategory': [
        'Special Combo',
        'Rice',
        'Tandoor',
        'Chinese',
        'Kizhi',
        'Schezwan',
        'Non Veg',
        'Veg',
        'Add On',
      ]
    },
    {
      'name': "Green Park",
      'image':
          'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/restaurants%20%2FGreen%20Park%2FWhatsApp%20Image%202020-12-13%20at%2010.09.28%20PM.jpeg?alt=media&token=47a4a3e5-e3ed-4eeb-b805-dc4f7540355f',
      'imageType': 'online',
      'open': '9:00',
      'close': '19:00',
      'automatic': true,
      'items': greenPark,
      'subCategory': [
        "All",
        'Rice',
        'Tandoor',
        'Non Veg',
        'Veg',
        'Add On',
      ]
    },
    {
      'name': "Vkp's Cafe",
      'image': 'assets/Restaurants/vkp.jpeg',
      'imageType': 'offline',
      'open': '9:00',
      'close': '19:00',
      'automatic': true,
      'items': vkp,
      'subCategory': [
        "Vkp's Special",
        // 'Pizza',
        // 'Pasta',
        // 'Sandwich',
        // 'Alfaham',
        'Add On',
      ]
    },
    {
      'name': "Ammuma Kitchen",
      'image':
          'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/restaurants%20%2Fammoomas%20kitchen%2FAMMOMMA.jpg?alt=media&token=d2f9e809-f1f6-411e-87fa-fde27e72df59',
      'imageType': 'online',
      'open': '9:00',
      'close': '19:00',
      'items': ammmumaKitchen,
      'subCategory': [
        "All",
        '',
        'Mughlai',
      ]
    },
    {
      'name': "Coconut Grove",
      'image':
          'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/restaurants%20%2FCoconut%20Groves%2Fcoconut.jpg?alt=media&token=3328d528-85d4-4d3d-a83c-dafaaf29f2f6',
      'imageType': 'online',
      'open': '9:00',
      'close': '19:00',
      'items': coconut,
      'subCategory': [
        "All",
        'Alfaham',
        'Add On',
      ]
    },
  ]
};

List<Map> blackBowl = [
  {
    'name': 'Chapathi + Chilly Chicken',
    'openHour': 11,
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/restaurants%20%2FBlack%20bowl%2Fchappathi%20chilly%20gravy.jpg?alt=media&token=5f455c1b-b876-4867-812b-2ebfd80b62cb',
    'desc': '10 Pc Chapathi, Chilly chicken',
    'imageType': 'online',
    'isVeg': false,
    'category': "Special Combo",
    'amount': 320,
    'quantity': 1,
    'unit': '',
  },
  {
    'name': 'Porotta + Chilly Chicken',
    'openHour': 11,
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/restaurants%20%2FBlack%20bowl%2FPink-Chilli-Chicken-Tikka-Masala.jpg?alt=media&token=0a06021e-05b0-46c3-a853-28c515d36dd7',
    'desc': '10 Pc Porotta, Chilly chicken',
    'imageType': 'online',
    'isVeg': false,
    'category': "Special Combo",
    'amount': 320,
    'quantity': 1,
    'unit': '',
  },
  {
    'name': 'Fried Rice + Chilly Chicken',
    'openHour': 11,
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/restaurants%20%2FBlack%20bowl%2F_fried_rice-min.jpg?alt=media&token=9d8cc55a-eaed-4c83-9e77-79ace354e0cb',
    'desc': '4 Portion Fried Rice, Chilly chicken',
    'imageType': 'online',
    'isVeg': false,
    'category': "Special Combo",
    'amount': 700,
    'quantity': 1,
    'unit': '',
  },
  {
    'name': 'Kizhi Poratta ',
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/restaurants%20%2Fammoomas%20kitchen%2Fbeef%20kizhi%20porotta~2.jpg?alt=media&token=d71b1cca-4acc-44cd-8156-959a3855dbe0',
    'desc': 'Kizhi Poratta -Beef  \n(delivery may be delayed)',
    'imageType': 'online',
    'isVeg': false,
    'category': "Kizhi",
    'amount': 110,
    'quantity': 1,
    'unit': '',
  },
  {
    'name': 'Kizhi  Biriyani  Chicken',
    'desc':
        'Two piece chicken, Egg ,Kizhi Biriyani \n(delivery may be delayed)',
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/restaurants%20%2Fammoomas%20kitchen%2FKIZHI%20chicken%20BIRIYANI%20with%20egg.jpg?alt=media&token=c48afe97-c310-4cf1-95a5-749aa327c838',
    'imageType': 'online',
    'isVeg': false,
    'category': 'Kizhi',
    'amount': 140,
    'quantity': 1,
    'unit': '',
  },

  {
    'name': 'Noodles + Chicken 65',
    'openHour': 11,
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/restaurants%20%2FBlack%20bowl%2Fnood-min.JPG?alt=media&token=444cf001-9c2a-4ee8-a9e4-a5fabff798b8',
    'desc': '4 Potion Noodles, chicken 65',
    'imageType': 'online',
    'isVeg': false,
    'category': "Special Combo",
    'amount': 700,
    'quantity': 1,
    'unit': '',
  },
  {
    'name': 'Alfham Combo',
    'openHour': 14,
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/restaurants%20%2FBlack%20bowl%2Falfaham%20combo-min.jpg?alt=media&token=744cab65-a433-4920-8132-f53048bb9e13',
    'desc': 'Full Alfham, Kuboos, Mayonnaise, Salad',
    'imageType': 'online',
    'isVeg': false,
    'category': "Special Combo",
    'amount': 420,
    'quantity': 1,
    'unit': '',
  },
  {
    'name': 'Plate Shavarma + Sprite',
    'isAvailable': true,
    'openHour': 14,
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/restaurants%20%2FBlack%20bowl%2Fshawarma%20plate-min.jpg?alt=media&token=5a1433c6-8094-4a46-9537-8ecdb2d4f8e6',
    'desc': '5 plate Shavarma, Sprite',
    'imageType': 'online',
    'isVeg': false,
    'category': "Special Combo",
    'amount': 425,
    'quantity': 1,
    'unit': '',
  },
  {
    'name': 'Roll Shavarma + Sprite',
    'isAvailable': true,
    'openHour': 14,
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/restaurants%20%2FBlack%20bowl%2Fshawarma%20roll-min.jpg?alt=media&token=ad4526c3-086c-4702-a03b-147a10a093cd',
    'desc': '5 Roll Shavarma, Sprite',
    'imageType': 'online',
    'isVeg': false,
    'category': "Special Combo",
    'amount': 325,
    'quantity': 1,
    'unit': '',
  },
  {
    'name': 'Biriyani + Sprite',
    'isAvailable': true,
    'openHour': 11,
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/restaurants%20%2FBlack%20bowl%2Fbiriyani.jpg?alt=media&token=0fefa9a7-9321-4e91-a5c2-41f11a13b7b9',
    'desc': '5 Chicken Biriyani, Sprite ',
    'imageType': 'online',
    'isVeg': false,
    'category': "Special Combo",
    'amount': 675,
    'quantity': 1,
    'unit': '',
  },
  {
    'name': 'Biriyani + Sprite',
    'isAvailable': true,
    'openHour': 11,
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/restaurants%20%2FBlack%20bowl%2Fbiriyani.jpg?alt=media&token=0fefa9a7-9321-4e91-a5c2-41f11a13b7b9',
    'desc': '10 Chicken Biriyani, Sprite ',
    'imageType': 'online',
    'isVeg': false,
    'category': "Special Combo",
    'amount': 1325,
    'quantity': 1,
    'unit': 'kg',
  },
  {
    'name': 'Chapathi + Beef Fry',
    'openHour': 11,
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/restaurants%20%2FBlack%20bowl%2F7J4A4767-min.jpg?alt=media&token=4fc132c9-0019-4310-a8d6-93cac866818a',
    'desc': '10 Pc Chapathi, Beef Fry',
    'imageType': 'online',
    'isVeg': false,
    'category': "Special Combo",
    'amount': 270,
    'quantity': 1,
    'unit': '',
  },
  {
    'name': 'Porotta + Beef Fry',
    'openHour': 11,
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/restaurants%20%2FBlack%20bowl%2Fporotta%20beef%20fry-min.jpg?alt=media&token=3432834e-fcdb-4e85-90e2-954fab137f79',
    'desc': '10 Pc Porotta, Beef Fry',
    'imageType': 'online',
    'isVeg': false,
    'category': "Special Combo",
    'amount': 270,
    'quantity': 1,
    'unit': '',
  },
  {
    'name': 'Chapathi + Chicken Curry',
    'openHour': 11,
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/restaurants%20%2FBlack%20bowl%2F1-37.jpg?alt=media&token=85feb514-69e2-4966-91eb-81d65a16992f',
    'desc': '10 Pc Chapathi, Chicken Curry',
    'imageType': 'online',
    'isVeg': false,
    'category': "Special Combo",
    'amount': 270,
    'quantity': 1,
    'unit': '',
  },
  {
    'name': 'Porotta + Chicken Curry',
    'openHour': 11,
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/restaurants%20%2FBlack%20bowl%2Fporotta%20chicken%20currry-min.jpg?alt=media&token=b48d36cb-7b55-4d3c-a97b-b4f5e28c8a41',
    'desc': '10 Pc Porotta, Chicken Curry',
    'imageType': 'online',
    'isVeg': false,
    'category': "Special Combo",
    'amount': 270,
    'quantity': 1,
    'unit': 'kg',
  },
  // add on
  {
    'name': 'Porotta',
    'openHour': 11,
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/restaurants%20%2FBlack%20bowl%2FPOROTTA.jpg?alt=media&token=2504638f-5849-4ba8-a831-3dba320a8d62',
    'imageType': 'online',
    'isVeg': true,
    'category': "Add On",
    'amount': 10,
    'quantity': 1,
    'unit': '',
  },
  {
    'name': 'Kuboos',
    'openHour': 15,
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/restaurants%20%2FBlack%20bowl%2Fkuboos.jpg?alt=media&token=0ffb265b-b7e8-47a1-a212-7276ea19dd55',
    'imageType': 'online',
    'isVeg': true,
    'category': "Add On",
    'amount': 10,
    'quantity': 1,
    'unit': '',
  },

  // non veg

  {
    'name': 'Beef Chilly',
    'openHour': 11,
    'isVeg': false,
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/restaurants%20%2FBlack%20bowl%2Fnew%2Fchilli%20beef-min.jpg?alt=media&token=7a174f08-077a-44fb-89ea-5d807fe8cdf9',
    'imageType': 'online',
    'category': 'Non Veg',
    'types': [
      {'type': 'Quator', 'amount': 120, 'quantity': 1},
      {'type': 'Half', 'amount': 200, 'quantity': 1},
      {'type': 'full', 'amount': 320, 'quantity': 1},
    ],
    'amount': 130,
    'quantity': 1,
    'unit': '',
  },
  {
    'name': 'Pepper Chicken',
    'openHour': 11,
    'isVeg': false,
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/restaurants%20%2FBlack%20bowl%2Fnew%2Fpepper-chicken-min.jpg?alt=media&token=3239c3f2-fd59-4eef-8f9d-ac9747d93bf2',
    'imageType': 'online',
    'category': 'Non Veg',
    'types': [
      {'type': 'Quator', 'amount': 140, 'quantity': 1},
      {'type': 'Half', 'amount': 250, 'quantity': 1},
      {'type': 'full', 'amount': 400, 'quantity': 1},
    ],
    'amount': 130,
    'quantity': 1,
    'unit': '',
  },
  {
    'name': 'Chilly Chicken',
    'openHour': 11,
    'isVeg': false,
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/restaurants%20%2FBlack%20bowl%2Fnew%2Fchilli-chicken-min.jpg?alt=media&token=4db34235-e484-463a-996d-5cd33061ace7',
    'imageType': 'online',
    'category': 'Non Veg',
    'types': [
      {'type': 'Quator', 'amount': 130, 'quantity': 1},
      {'type': 'Half', 'amount': 240, 'quantity': 1},
      {'type': 'full', 'amount': 360, 'quantity': 1},
    ],
    'amount': 0,
    'quantity': 1,
    'unit': '',
  },
  {
    'name': 'Ginger Chicken',
    'openHour': 11,
    'isVeg': false,
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/restaurants%20%2FBlack%20bowl%2Fnew%2FGinger-Chicken-min.jpg?alt=media&token=7ac1927d-5959-491e-8900-a1ff087770d1',
    'imageType': 'online',
    'category': 'Non Veg',
    'types': [
      {'type': 'Quator', 'amount': 130, 'quantity': 1},
      {'type': 'Half', 'amount': 240, 'quantity': 1},
      {'type': 'full', 'amount': 380, 'quantity': 1},
    ],
    'amount': 0,
    'quantity': 1,
    'unit': '',
  },
  {
    'name': 'Garlic Chicken',
    'openHour': 11,
    'isVeg': false,
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/restaurants%20%2FBlack%20bowl%2Fnew%2Fgarlic-chicken-min.jpg?alt=media&token=493b7afb-eebf-4575-9c3e-223c32986361',
    'imageType': 'online',
    'category': 'Non Veg',
    'types': [
      {'type': 'Quator', 'amount': 130, 'quantity': 1},
      {'type': 'Half', 'amount': 240, 'quantity': 1},
      {'type': 'full', 'amount': 370, 'quantity': 1},
    ],
    'amount': 0,
    'quantity': 1,
    'unit': '',
  },
  // Schezwan
  {
    'name': 'Schezwan Fried Rice Chicken',
    'openHour': 11,
    'isVeg': false,
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/restaurants%20%2FBlack%20bowl%2Fnew%2Fschezwan-fried-rice-chicken-min.jpg?alt=media&token=93f17ba4-5086-4bb6-9e92-7cd4610efe24',
    'imageType': 'online',
    'category': 'Schezwan',
    'amount': 140,
    'quantity': 1,
    'unit': '',
  },

  {
    'name': 'Schezwan Fried Rice Egg',
    'openHour': 11,
    'isVeg': false,
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/restaurants%20%2FBlack%20bowl%2Fnew%2FSchezwan-Egg-Fried-Rice-3-min.jpg?alt=media&token=65f578c4-a8f4-4151-8a0a-a0890337b66e',
    'imageType': 'online',
    'category': 'Schezwan',
    'amount': 120,
    'quantity': 1,
    'unit': '',
  },
  // ---- // noodles
  {
    'name': 'Schezwan Noodles Chicken',
    'openHour': 11,
    'isVeg': false,
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/restaurants%20%2FBlack%20bowl%2Fnew%2FSCHEZWAN-CHICKEN-NOODLES-min.jpg?alt=media&token=73e85c64-454a-4332-8001-159de4f4c9c7',
    'imageType': 'online',
    'category': 'Schezwan',
    'amount': 150,
    'quantity': 1,
    'unit': '',
  },
  {
    'name': 'Schezwan Noodles Veg',
    'openHour': 11,
    'isVeg': true,
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/restaurants%20%2FBlack%20bowl%2Fnew%2FSchezwan-Noodles%20%20veg-min.jpg?alt=media&token=9e6cbeb0-5740-4e5b-b87d-cd8431acf939',
    'imageType': 'online',
    'category': 'Schezwan',
    'amount': 120,
    'quantity': 1,
    'unit': '',
  },
  {
    'name': 'Schezwan Noodles Egg',
    'openHour': 11,
    'isVeg': false,
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/restaurants%20%2FBlack%20bowl%2Fnew%2Fschezwan-egg-noodles-1-min.jpg?alt=media&token=90079c3e-397a-4fe0-a979-2b98e8070797',
    'imageType': 'online',
    'category': 'Schezwan',
    'amount': 130,
    'quantity': 1,
    'unit': '',
  },
  // chinese
  {
    'name': 'Fried Rice Chicken',
    'openHour': 11,
    'isVeg': false,
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/restaurants%20%2FBlack%20bowl%2Fnew%2FFried-Rice-chicken-min.jpg?alt=media&token=c19fc5f9-30b3-4df3-b072-924e901e24bc',
    'imageType': 'online',
    'category': 'Chinese',
    'amount': 130,
    'quantity': 1,
    'unit': '',
  },
  {
    'name': 'Fried Rice Egg',
    'openHour': 11,
    'isVeg': false,
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/restaurants%20%2FBlack%20bowl%2Fnew%2FEgg-Fried-Rice-3-min.jpg?alt=media&token=ed7492ee-1f8d-48b7-b717-95a3a46b965c',
    'imageType': 'online',
    'category': 'Chinese',
    'amount': 110,
    'quantity': 1,
    'unit': '',
  },
  // ---- // noodles

  {
    'name': 'Noodles Veg',
    'openHour': 11,
    'isVeg': true,
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/restaurants%20%2FBlack%20bowl%2Fnew%2Fveg%20Noodles-min.jpg?alt=media&token=75258130-75d5-4b9a-8625-9fc8a72cb349',
    'imageType': 'online',
    'category': 'Chinese',
    'amount': 110,
    'quantity': 1,
    'unit': '',
  },

  {
    'name': 'Noodles Egg',
    'openHour': 11,
    'isVeg': false,
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/restaurants%20%2FBlack%20bowl%2Fnew%2Fegg-noodles-min.jpg?alt=media&token=8e9bb0bd-017e-466b-8e5f-f8e67b2cf39e',
    'imageType': 'online',
    'category': 'Chinese',
    'amount': 120,
    'quantity': 1,
    'unit': '',
  },
  // Rice
  {
    'name': 'Chicken Biriyani',
    'isAvailable': true,
    'openHour': 11,
    'isVeg': false,
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/restaurants%20%2FBlack%20bowl%2Fnew%2Fcb-min.jpg?alt=media&token=b874a76f-1b39-4456-871c-81538d30a490',
    'imageType': 'online',
    'category': 'Rice',
    'types': [
      {'type': 'Single', 'amount': 100, 'quantity': 1},
      {'type': 'full', 'amount': 130, 'quantity': 1},
    ],
    'amount': 0,
    'quantity': 1,
    'unit': '',
  },
  {
    'name': 'Gheee Rice',
    'openHour': 11,
    'isVeg': true,
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/restaurants%20%2FBlack%20bowl%2Fnew%2FGhee_Rice-min.jpg?alt=media&token=475d3db2-339a-4828-a1c5-230fb93c380d',
    'imageType': 'online',
    'category': 'Rice',
    'types': [
      {'type': 'Single', 'amount': 40, 'quantity': 1},
      {'type': 'full', 'amount': 70, 'quantity': 1},
    ],
    'amount': 0,
    'quantity': 1,
    'unit': '',
  },
  {
    'name': 'Biriyani Rice',
    'openHour': 11,
    'isVeg': true,
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/restaurants%20%2FBlack%20bowl%2Fnew%2Fbiriyani%20rice-min.jpg?alt=media&token=bc86fe2e-1db0-42a5-9d83-0ffbcd870506',
    'imageType': 'online',
    'category': 'Rice',
    'types': [
      {'type': 'Single', 'amount': 40, 'quantity': 1},
      {'type': 'full', 'amount': 80, 'quantity': 1},
    ],
    'amount': 0,
    'quantity': 1,
    'unit': '',
  },
  // veg
  {
    'name': 'Gobi Manchurian',
    'openHour': 11,
    'isVeg': true,
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/restaurants%20%2FBlack%20bowl%2Fnew%2Fgoby-min.jpg?alt=media&token=7d18d97b-77c6-4ed0-97cd-6d78181e9b11',
    'imageType': 'online',
    'category': 'Veg',
    'amount': 80,
    'quantity': 1,
    'unit': '',
  },
  {
    'name': 'Paneer Chilly',
    'openHour': 11,
    'isVeg': true,
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/restaurants%20%2FBlack%20bowl%2Fnew%2FChilli-Paneer-Restaurant-Style-500x375-min.jpg?alt=media&token=612bd892-07b8-41bb-9013-1984f150bc53',
    'imageType': 'online',
    'category': 'Veg',
    'amount': 110,
    'quantity': 1,
    'unit': '',
  },
  // tandoor
  {
    'name': 'Alfaham ',
    'isAvailable': true,
    'openHour': 13,
    'isVeg': false,
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/restaurants%20%2FBlack%20bowl%2Falfaham%20combo-min.jpg?alt=media&token=744cab65-a433-4920-8132-f53048bb9e13',
    'imageType': 'online',
    'category': 'Tandoor',
    'amount': 110,
    'types': [
      {'type': 'Full', 'amount': 420, 'quantity': 1},
      {'type': 'Half', 'amount': 220, 'quantity': 1},
      {'type': 'Qt.', 'amount': 110, 'quantity': 1},
    ],
    'quantity': 1,
    'unit': '',
  },
  {
    'name': 'Shawarma ',
    'isAvailable': true,
    'openHour': 13,
    'isVeg': false,
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/restaurants%20%2FBlack%20bowl%2Fshawarma%20plate-min.jpg?alt=media&token=5a1433c6-8094-4a46-9537-8ecdb2d4f8e6',
    'imageType': 'online',
    'category': 'Tandoor',
    'types': [
      {'type': 'Roll', 'amount': 60, 'quantity': 1},
      {'type': 'Plate', 'amount': 80, 'quantity': 1},
    ],
    'amount': 0,
    'quantity': 1,
    'unit': '',
  },
];
