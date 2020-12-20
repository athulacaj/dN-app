import 'grocery/oil&Ghee.dart';
import 'grocery/pickels&jams.dart';

Map groceyMap = {
  'categories': [
    {
      'name': 'Pulses & Spices',
      'image': 'assets/grocery/pulses.jpeg',
      'category': ['Pulses', 'Spices', 'Masala', 'Sugar & Sarkara'],
      'ads': [
        'http://www.pulsecanada.com/wp-content/uploads/2018/01/Potential-What-is-a-Pulse-Image-min-e1515774203184.jpg'
      ],
      'Pulses': pulsesList,
      'Spices': spicesList,
      'Masala': masalaList,
      'Sugar & Sarkara': sugarSarkaraList,
    },
    {
      'name': 'Rice & Home Bakings',
      'image': 'assets/grocery/1/homeBakings.jpeg',
      'ads': [],
      'category': ['Rice Powders', 'Rice'],
      'Rice Powders': ricePowdersList,
      'Rice': riceList,
    },
    // {
    //   'name': 'Biscuits & Snacks',
    //   'image':
    //       'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/groceries%2Fcatgory%2Fbiscuts.jpeg?alt=media&token=37ee76b3-32f1-4a3b-84b6-bcc48a4fde64',
    //   'imageType': 'online',
    // },
    {
      'name': 'Oil & Ghee',
      'image': 'assets/grocery/oil.jpeg',
      'category': ['Cooking Oils'],
      'ads': [],
      'Cooking Oils': cookingOil
    },
    // {'name': 'Dairy & Eggs', 'image': 'assets/grocery/1/eggs.jpeg'},
    {
      'name': 'Pickles & Jam',
      'image': 'assets/grocery/1/picklesandjam.jpeg',
      'category': ['Sauces & Pickles'],
      'ads': [],
      'Sauces & Pickles': saucesPickles
    },
    // {'name': 'Health & Beauty', 'image': 'assets/grocery/1/health.jpeg'},
    // {'name': 'Laundry', 'image': 'assets/grocery/laundry.jpeg'},
    // {'name': 'Disposable', 'image': 'assets/grocery/disposibles.jpeg'},
    // {
    //   'name': 'Health Care Essentials',
    //   'image': 'assets/grocery/1/sanitizer.jpeg'
    // },
    // {'name': 'Mother and Baby Care', 'image': 'assets/grocery/1/babycare.jpeg'},
    // {'name': 'Household Cleaning', 'image': 'assets/grocery/1/household.jpeg'},
  ],
};

List pulsesList = [
  {
    'name': 'Homely Vanpayar- 500g',
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/groceries%2Fnew%2Fpulses%2Fred%20payar.jpeg?alt=media&token=e21492ea-9175-48b8-9e40-c3895d7d9e7e',
    'imageType': 'online',
    'amount': 50,
    'mrp': 60,
    'quantity': 1,
    'unit': 'pkt',
    'category': 'pulses',
    'available': 'available'
  },
  {
    'name': 'Homely Kadala- 500g',
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/groceries%2Fnew%2Fpulses%2Fvicib%20kadala.jpeg?alt=media&token=ec918214-23c3-45e0-8da4-617ea571312b',
    'imageType': 'online',
    'amount': 51,
    'mrp': 55,
    'quantity': 1,
    'unit': 'pkt',
    'category': 'pulses',
    'available': 'available'
  },
  {
    'name': 'Homely Paripp- 500g',
    //red
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/groceries%2Fnew%2Fpulses%2Fdal.jpeg?alt=media&token=4f6a58a0-c67f-4c4d-b365-144f4875edb9',
    'imageType': 'online',
    'amount': 50,
    // 'mrp': 70,
    'quantity': 1,
    'unit': 'pkt',
    'category': 'pulses',
    'available': 'available'
  },
  {
    'name': 'Homely Urad Paripp- 500g',
    // yellow
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/groceries%2Fnew%2Fpulses%2Furad%20dal.jpeg?alt=media&token=d4c07885-696b-4f34-b167-02b4debb95f0',
    'imageType': 'online',
    'amount': 65,
    'mrp': 70,
    'quantity': 1,
    'unit': 'pkt',
    'category': 'pulses',
    'available': 'available'
  },
  {
    'name': 'Homely GreenPeas- 500g',
    // yellow
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/groceries%2Fnew%2Fpulses%2Fgreen%20peas.jpeg?alt=media&token=ae11cefd-0715-48d3-8738-207b64728c4e',
    'imageType': 'online',
    'amount': 115,
    // 'mrp': 40,
    'quantity': 1,
    'unit': 'pkt',
    'category': 'pulses',
    'available': 'available'
  },
  {
    'name': 'Homely Cherupayar- 500g',
    // yellow
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/groceries%2Fnew%2Fpulses%2Fgreen%20gram.jpeg?alt=media&token=e1ddcd36-d6b5-4782-ad13-1946022da949',
    'imageType': 'online',
    'amount': 72,
    'mrp': 75,
    'quantity': 1,
    'unit': 'pkt',
    'category': 'pulses',
    'available': 'available'
  },
];
List spicesList = [
  {
    'name': 'Homely jeerakam 50g',
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/groceries%2Fnew%2Fspices%2Fjeera.jpeg?alt=media&token=2c323aed-8201-440e-92d5-2174e8a6a373',
    'imageType': 'online',
    'amount': 25,
    'quantity': 1,
    'unit': 'pkt',
    'category': 'spices',
    'available': 'available'
  },
  {
    'name': 'Homely Kaduku 100g',
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/groceries%2Fnew%2Fspices%2Fmustard.jpeg?alt=media&token=911c7310-d758-4032-b111-501ff4be8306',
    'imageType': 'online',
    'amount': 14,
    //'mrp': 63,
    'quantity': 1,
    'unit': 'pkt',
    'category': 'spices',
    'available': 'available'
  },
  {
    'name': 'Homely Perum Jeerakam 50g',
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/groceries%2Fnew%2Fspices%2Fperumjeerkam.jpeg?alt=media&token=0abf74d8-9f83-40ee-b7de-30437581845c',
    'imageType': 'online',
    'amount': 14,
    //'mrp': 63,
    'quantity': 1,
    'unit': 'pkt',
    'category': 'spices',
    'available': 'available'
  },
  {
    'name': ' Homely Uluva 100g',
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/groceries%2Fnew%2Fspices%2Fuluva.jpeg?alt=media&token=8e44f0a8-239e-4cec-9883-adc8c3d540f4',
    'imageType': 'online',
    'amount': 15,
    //'mrp': 63,
    'quantity': 1,
    'unit': 'pkt',
    'category': 'spices',
    'available': 'available'
  },
  {
    'name': ' Homely Salt 1 Kg',
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/groceries%2Fnew%2Fspices%2Fsalt.jpeg?alt=media&token=54c644f4-2a51-4bd1-9fa5-0600c23f3139',
    'imageType': 'online',
    'amount': 15,
    'mrp': 17,
    'quantity': 1,
    'unit': 'pkt',
    'category': 'spices',
    'available': 'available'
  },
];
List masalaList = [
  {
    'name': 'Homely Chicken Masala 100g',
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/groceries%2Fnew%2Fmasala%2Fchicken%20masala.jpeg?alt=media&token=b3bac0ee-2de5-4fe6-814c-7cf7f3d4d638',
    'imageType': 'online',
    'amount': 35,
    'mrp': 36,
    'quantity': 1,
    'unit': 'pkt',
    'category': 'spices',
    'available': 'available'
  },
  {
    'name': 'Homely Chilly Powder 250g',
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/groceries%2Fnew%2Fmasala%2Fchilli%20powder.jpeg?alt=media&token=13c1dd37-ed64-468c-bc8b-51dffabf13de',
    'imageType': 'online',
    'amount': 63,
    'mrp': 65,
    'quantity': 1,
    'unit': 'pkt',
    'category': 'spices',
    'available': 'available'
  },
  {
    'name': 'Homely Coriander Powder 250g',
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/groceries%2Fnew%2Fmasala%2Fcorindar%20powder.jpeg?alt=media&token=987833f4-c766-4ee4-b059-0d31e9bccd04',
    'imageType': 'online',
    'amount': 54,
    'mrp': 55,
    'quantity': 1,
    'unit': 'pkt',
    'category': 'spices',
    'available': 'available'
  },
  {
    'name': 'Homely Fish Masala 100g',
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/groceries%2Fnew%2Fmasala%2Ffish%20masala.jpeg?alt=media&token=3405b247-90e3-4367-bf77-b35fb0e069f3',
    'imageType': 'online',
    'amount': 35,
    'mrp': 36,
    'quantity': 1,
    'unit': 'pkt',
    'category': 'spices',
    'available': 'available'
  },
  {
    'name': 'Homely Garam Masala 100g',
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/groceries%2Fnew%2Fmasala%2Fgaram%20masala.jpeg?alt=media&token=affedfb1-808e-475d-8d77-0237b69d11a8',
    'imageType': 'online',
    'amount': 33,
    'mrp': 35,
    'quantity': 1,
    'unit': 'pkt',
    'category': 'spices',
    'available': 'available'
  },
  {
    'name': 'Homely Kasmiri Chilli Powder 500g',
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/groceries%2Fnew%2Fmasala%2Fkashmiri%20chilli%20powder.jpeg?alt=media&token=3b3e5ba7-e191-454a-baa3-22dfb8ee5a3a',
    'imageType': 'online',
    'amount': 95,
    'quantity': 1,
    'unit': 'pkt',
    'category': 'spices',
    'available': 'available'
  },
  {
    'name': 'Homely Pepper Powder 50g',
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/groceries%2Fnew%2Fmasala%2Fpepper%20powder.jpeg?alt=media&token=d5dc44da-a01d-499b-86d6-f5b889550c54',
    'imageType': 'online',
    'amount': 65,
    'quantity': 1,
    'unit': 'pkt',
    'category': 'spices',
    'available': 'available'
  },
  {
    'name': 'Homely Rasam Powder 100g',
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/groceries%2Fnew%2Fmasala%2Frasam%20powder.jpeg?alt=media&token=4b016d45-f48e-493c-9404-b483359ef15a',
    'imageType': 'online',
    'amount': 30,
    'quantity': 1,
    'unit': 'pkt',
    'category': 'spices',
    'available': 'available'
  },
  {
    'name': 'Homely Meat Masala 100g',
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/groceries%2Fnew%2Fmasala%2Fvicib%20meat%20masala.jpeg?alt=media&token=8007bbd9-ac59-482a-a69e-56b140b71024',
    'imageType': 'online',
    'amount': 34,
    'mrp': 36,
    'quantity': 1,
    'unit': 'pkt',
    'category': 'spices',
    'available': 'available'
  },
];

List sugarSarkaraList = [
  {
    'name': 'Homely Jaggery 500g',
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/groceries%2Fnew%2Fsugar%20%26%20sarkara%2Fjaggery.jpeg?alt=media&token=9c03929f-3983-483f-8279-11f9477fc2d9',
    'imageType': 'online',
    'amount': 90,
    // 'mrp': 40,
    'quantity': 1,
    'unit': 'pkt',
    'category': 'pulses',
    'available': 'available'
  },
  {
    'name': 'Homely Sugar 1Kg',
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/groceries%2Fnew%2Fhomely%2Fsugar.jpg?alt=media&token=5e65b38a-d180-4d9d-8930-5608a8f15367',
    'imageType': 'online',
    'amount': 45,
    // 'mrp': 40,
    'quantity': 1,
    'unit': 'pkt',
    'category': 'pulses',
    'available': 'available'
  },

  // {
  //   'name': 'Turmeric 100g',
  //   'image': '',
  //   'imageType': 'online',
  //   'amount': 30,
  //   'quantity': 1,
  //   'unit': 'pkt',
  //   'category': 'spices',
  //   'available': 'available'
  // },
];
List ricePowdersList = [
  {
    'name': 'Homely Dosa Podi 500g ',
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/groceries%2Fnew%2Frice%20powder%2Fdosa%20podi.jpeg?alt=media&token=d4beb730-fe37-4119-9a44-0b3e0fe19a04',
    'imageType': 'online',
    'amount': 55,
    'quantity': 1,
    'unit': 'pkt',
    'category': 'spices',
    'available': 'available'
  },
  {
    'name': 'Homely Easy Palappam Podi 500g',
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/groceries%2Fnew%2Frice%20powder%2Feasy%20palappam%20podi.jpeg?alt=media&token=d1d63464-1c30-486d-bb73-75762d8e8936',
    'imageType': 'online',
    'amount': 40,
    'quantity': 1,
    'unit': 'pkt',
    'category': 'spices',
    'available': 'available'
  },
  {
    'name': 'Homely Ideli Podi 500g',
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/groceries%2Fnew%2Frice%20powder%2Fidili%20podi.jpeg?alt=media&token=6f05195e-43d1-4898-a9fd-dd979c98f5e4',
    'imageType': 'online',
    'amount': 50,
    'quantity': 1,
    'unit': 'pkt',
    'category': 'spices',
    'available': 'available'
  },
  {
    'name': 'Homely Puttu Podi 1Kg',
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/groceries%2Fnew%2Frice%20powder%2Fputtu%20podi.jpeg?alt=media&token=e740c5a9-886b-469a-9035-024bd7424c5e',
    'imageType': 'online',
    'amount': 64,
    'mrp': 65,
    'quantity': 1,
    'unit': 'pkt',
    'category': 'spices',
    'available': 'available'
  },
  {
    'name': 'Homely Aripodi 1Kg',
    'image':
        'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/groceries%2Fnew%2Frice%20powder%2Frice%20powder.jpeg?alt=media&token=6ca4cfa4-7e72-4508-bf81-5ca4fec87abb',
    'imageType': 'online',
    'amount': 70,
    'mrp': 79,
    'quantity': 1,
    'unit': 'pkt',
    'category': 'spices',
    'available': 'available'
  },
  // {
  //   'name': 'muthaari ',
  //   'image':
  //   'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/groceries%2F16.jpg?alt=media&token=3404a4e5-943d-4daa-b20f-dccad8c3e797',
  //   'imageType': 'online',
  //   'amount': 30,
  //   'quantity': 1,
  //   'unit': 'pkt',
  //   'category': 'spices',
  //   'available': 'available'
  // },
  // {
  //   'name': 'Turmeric 100g',
  //   'image': '',
  //   'imageType': 'online',
  //   'amount': 30,
  //   'quantity': 1,
  //   'unit': 'pkt',
  //   'category': 'spices',
  //   'available': 'available'
  // },
];

List riceList = [
  // {
  //   'name': 'Homely Dosa Podi 500g ',
  //   'image':
  //       'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/groceries%2Fnew%2Frice%20powder%2Fdosa%20podi.jpeg?alt=media&token=d4beb730-fe37-4119-9a44-0b3e0fe19a04',
  //   'imageType': 'online',
  //   'amount': 55,
  //   'quantity': 1,
  //   'unit': 'pkt',
  //   'category': 'spices',
  //   'available': 'available'
  // },
];
